package cn.wow.support.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.Page;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.AtlasResult;
import cn.wow.common.domain.CompareVO;
import cn.wow.common.domain.ExamineRecord;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.PfResult;
import cn.wow.common.domain.Task;
import cn.wow.common.service.AtlasResultService;
import cn.wow.common.service.ExamineRecordService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.PfResultService;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.SamplingTaskEnum;
import cn.wow.common.utils.taskState.StandardTaskEnum;
import cn.wow.common.utils.taskState.TaskTypeEnum;

/**
 * 结果控制器
 * 
 * @author zhenjunzhuo 2017-10-17
 */
@Controller
@RequestMapping(value = "result")
public class ResultController extends AbstractController {

	Logger logger = LoggerFactory.getLogger(ResultController.class);

	// 结果上传列表
	private final static String UPLOAD_DEFAULT_PAGE_SIZE = "10";
	// 结果发送列表
	private final static String SEND_DEFAULT_PAGE_SIZE = "10";
	// 任务记录列表
	private final static String RECORD_DEFAULT_PAGE_SIZE = "10";
	// 结果确认列表
	private final static String CONFIRM_DEFAULT_PAGE_SIZE = "10";
	// 结果对比列表
	private final static String COMPARE_DEFAULT_PAGE_SIZE = "10";
	
	// 图谱图片上传路径
	@Value("${result.atlas.url}")
	protected String atlasUrl;
	
	@Autowired
	private MenuService menuService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private AtlasResultService atlasResultService;
	@Autowired
	private PfResultService pfResultService;
	
	
	//-----------------------------------    结果上传        ---------------------------------------------------------------
	
	/**
	 * 结果上传列表
	 * @param type  类型：1-型式结果上传 2-图谱结果上传
	 */
	@RequestMapping(value = "/uploadList")
	public String uploadList(HttpServletRequest request, HttpServletResponse response, Model model, int type) {
		Menu menu = null;
		
		if(type == 1){
			menu = menuService.selectByAlias("patternUpload");
		}else{
			menu = menuService.selectByAlias("atlasUpload");
		}
		
		model.addAttribute("defaultPageSize", UPLOAD_DEFAULT_PAGE_SIZE);
		model.addAttribute("recordPageSize", RECORD_DEFAULT_PAGE_SIZE);
		model.addAttribute("menuName", menu.getName());
		model.addAttribute("type", type);
		return "result/upload_list";
	}

	/**
	 * 列表数据
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadListData")
	public Map<String, Object> uploadListData(HttpServletRequest request, Model model, String code, String orgId,
			String startCreateTime, String endCreateTime, String nickName, int type) {
		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
		
		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", UPLOAD_DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		map.put("state", StandardTaskEnum.TESTING.getState());
		
		// 超级管理员具有所有的权限
		if(account.getRole() == null || !Contants.SUPER_ROLE_CODE.equals(account.getRole().getCode())){
			if(type == 1){  //型式结果
				map.put("patternTask", account.getOrgId() == null ? -1: account.getOrgId());
			}else{   // 图谱结果
				map.put("atlasTask", account.getOrgId() == null ? -1: account.getOrgId());
			}
		}else{
			if(type == 1){
				map.put("patternTask_admin", true);
			}else{
				map.put("atlasTask_admin", true);
			}
		}

		if (StringUtils.isNotBlank(code)) {
			map.put("code", code);
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime);
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime);
		}
		if (StringUtils.isNotBlank(nickName)) {
			map.put("nickName", nickName);
		}
		if (StringUtils.isNotBlank(orgId)) {
			map.put("orgId", orgId);
		}

		List<Task> dataList = taskService.selectAllList(map);

		// 分页
		Page<Task> pageList = (Page<Task>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	/**
	 * 详情列表
	 * @param type  类型：1-型式结果上传 2-图谱结果上传
	 */
	@RequestMapping(value = "/uploadDetail")
	public String uploadDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id, int type) {
		if (id != null) {
			Task task = taskService.selectOne(id);

			model.addAttribute("facadeBean", task);
		}
		
		if(type == 1){
			// 零部件试验次数
			int pNum = pfResultService.getExpNoByCatagory(id, 1);
			// 原材料试验次数
			int mNum = pfResultService.getExpNoByCatagory(id, 2);
			
			model.addAttribute("pNum", pNum + 1);
			model.addAttribute("mNum", mNum + 1);
		}

		model.addAttribute("resUrl", resUrl);
		model.addAttribute("type", type);
		model.addAttribute("superRoleCole", Contants.SUPER_ROLE_CODE);
		return "result/upload_detail";
	}

	/**
	 * 图谱结果上传
	 * 
	 * @param taskId  任务ID
	 * @param p_tgLab   零部件热重分析描述
	 * @param p_infLab  零部件红外光分析描述
	 * @param p_dtLab   零部件差热扫描描述
	 * @param m_tgLab   原材料热重分析描述
	 * @param m_infLab  原材料红外光分析描述
	 * @param m_dtLab   原材料差热扫描描述
	 */
	@ResponseBody
	@RequestMapping(value = "/atlasUpload")
	public AjaxVO atlasUpload(HttpServletRequest request, Model model, Long taskId, 
			String p_tgLab, String p_infLab, String p_dtLab, String m_tgLab, String m_infLab, String m_dtLab, 
			@RequestParam(value = "p_tgLab_pic", required = false) MultipartFile p_tgfile,
			@RequestParam(value = "p_infLab_pic", required = false) MultipartFile p_infile,
			@RequestParam(value = "p_dtLab_pic", required = false) MultipartFile p_dtfile,
			@RequestParam(value = "m_tgLab_pic", required = false) MultipartFile m_tgfile,
			@RequestParam(value = "m_infLab_pic", required = false) MultipartFile m_infile,
			@RequestParam(value = "m_dtLab_pic", required = false) MultipartFile m_dtfile) {
		AjaxVO vo = new AjaxVO();
		String pic = null;
		
		try {
			Date date = new Date();
			List<AtlasResult> dataList = new ArrayList<AtlasResult>();
			
			/**  零部件结果  **/
			if(p_tgfile != null){
				// 零部件试验次数
				int pNum = atlasResultService.getExpNoByCatagory(taskId, 1);
				
				// 热重分析
				if (p_tgfile != null && !p_tgfile.isEmpty()) {
					pic = uploadImg(p_tgfile, atlasUrl + taskId + "/parts/tg/", false);
				}
				AtlasResult p_tg = new AtlasResult(taskId, 3, pic, p_tgLab, 1, pNum + 1, date);
				
				// 红外光分析
				if (p_infile != null && !p_infile.isEmpty()) {
					pic = uploadImg(p_infile, atlasUrl + taskId + "/parts/inf/", false);
				}
				AtlasResult p_inf = new AtlasResult(taskId, 1, pic, p_infLab, 1, pNum + 1, date);
				
				// 差热扫描
				if (p_dtfile != null && !p_dtfile.isEmpty()) {
					pic = uploadImg(p_dtfile, atlasUrl + taskId + "/parts/dt/", false);
				}
				AtlasResult p_dt = new AtlasResult(taskId, 2, pic, p_dtLab, 1, pNum + 1, date);
				
				dataList.add(p_tg);
				dataList.add(p_inf);
				dataList.add(p_dt);
			}
			
			/** 原材料结果  **/
			if(m_tgfile != null){
				// 原材料试验次数
				int mNum = atlasResultService.getExpNoByCatagory(taskId, 2);
				
				// 热重分析
				if (m_tgfile != null && !m_tgfile.isEmpty()) {
					pic = uploadImg(m_tgfile, atlasUrl + taskId + "/material/tg/", false);
				}
				AtlasResult m_tg = new AtlasResult(taskId, 3, pic, m_tgLab, 2, mNum + 1, date);
				
				// 红外光分析
				if (m_infile != null && !m_infile.isEmpty()) {
					pic = uploadImg(m_infile, atlasUrl + taskId + "/material/inf/", false);
				}
				AtlasResult m_inf = new AtlasResult(taskId, 1, pic, m_infLab, 2, mNum + 1, date);
				
				// 差热扫描
				if (m_dtfile != null && !m_dtfile.isEmpty()) {
					pic = uploadImg(m_dtfile, atlasUrl + taskId + "/material/dt/", false);
				}
				AtlasResult m_dt = new AtlasResult(taskId, 2, pic, m_dtLab, 2, mNum + 1, date);
				
				dataList.add(m_tg);
				dataList.add(m_inf);
				dataList.add(m_dt);
			}
			
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			atlasResultService.upload(account, dataList, taskId, date);
		} catch (Exception ex) {
			logger.error("图谱上传失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}
	
	
	/**
	 * 型式结果上传
	 * 
	 * @param taskId  任务ID
	 * @param tgLab   热重分析描述
	 * @param infLab  红外光分析描述
	 * @param dtLab   差热扫描描述
	 */
	@ResponseBody
	@RequestMapping(value = "/patternUpload")
	public AjaxVO patternUpload(HttpServletRequest request, Model model, Long taskId, String result){
		AjaxVO vo = new AjaxVO();
		
		try {
			ObjectMapper mapper = new ObjectMapper();
	        List<PfResult> dataList = mapper.readValue(result,new TypeReference<List<PfResult>>() { });
	        
	        Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
	        pfResultService.upload(account, dataList, taskId);
	        
		}catch(Exception ex){
			logger.error("型式结果上传失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}
		
		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}

	
	//-----------------------------------    结果发送        ---------------------------------------------------------------
	
	/**
	 * 结果发送列表
	 */
	@RequestMapping(value = "/sendList")
	public String sendList(HttpServletRequest request, HttpServletResponse response, Model model) {
		Menu menu = menuService.selectByAlias("send");
		
		model.addAttribute("defaultPageSize", SEND_DEFAULT_PAGE_SIZE);
		model.addAttribute("recordPageSize", RECORD_DEFAULT_PAGE_SIZE);
		model.addAttribute("menuName", menu.getName());
		return "result/send_list";
	}

	/**
	 * 列表数据
	 */
	@ResponseBody
	@RequestMapping(value = "/sendListData")
	public Map<String, Object> sendListData(HttpServletRequest request, Model model, String code, String orgId,
			String startCreateTime, String endCreateTime, String nickName) {
		
		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
		
		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", SEND_DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		
		// 超级管理员具有所有的权限
		if(account.getRole() == null || !Contants.SUPER_ROLE_CODE.equals(account.getRole().getCode())){
			map.put("sendTask", account.getOrgId());
		}else{
			map.put("sendTask_admin", true);
		}

		if (StringUtils.isNotBlank(code)) {
			map.put("code", code);
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime);
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime);
		}
		if (StringUtils.isNotBlank(nickName)) {
			map.put("nickName", nickName);
		}
		if (StringUtils.isNotBlank(orgId)) {
			map.put("orgId", orgId);
		}

		List<Task> dataList = taskService.selectAllList(map);

		// 分页
		Page<Task> pageList = (Page<Task>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	
	/**
	 * 详情列表
	 */
	@RequestMapping(value = "/sendDetail")
	public String sendDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id) {
		if (id != null) {
			Task task = taskService.selectOne(id);

			// 性能结果
			if (task.getMatPatResult() == 2 || task.getPartsPatResult() == 2) {
				Map<String, Object> pfMap = new HashMap<String, Object>();
				pfMap.put("tId", id);
				pfMap.put("custom_order_sql", "exp_no asc");
				List<PfResult> pfDataList = pfResultService.selectAllList(pfMap);

				Map<Integer, List<PfResult>> pPfResult = new HashMap<Integer, List<PfResult>>();
				Map<Integer, List<PfResult>> mPfResult = new HashMap<Integer, List<PfResult>>();
				pfResultService.assemblePfResult(pfDataList, pPfResult, mPfResult);

				// 原材料型式结果
				model.addAttribute("mPfResult", mPfResult);
				// 零部件型式结果
				model.addAttribute("pPfResult", pPfResult);
			}

			// 图谱结果
			if (task.getMatAtlResult() == 2 || task.getPartsAtlResult() == 2) {
				Map<String, Object> atMap = new HashMap<String, Object>();
				atMap.put("tId", id);
				atMap.put("custom_order_sql", "exp_no asc");
				List<AtlasResult> atDataList = atlasResultService.selectAllList(atMap);

				Map<Integer, List<AtlasResult>> pAtlasResult = new HashMap<Integer, List<AtlasResult>>();
				Map<Integer, List<AtlasResult>> mAtlasResult = new HashMap<Integer, List<AtlasResult>>();
				atlasResultService.assembleAtlasResult(atDataList, pAtlasResult, mAtlasResult);

				// 原材料图谱结果
				model.addAttribute("mAtlasResult", mAtlasResult);
				// 零部件图谱结果
				model.addAttribute("pAtlasResult", pAtlasResult);
			}

			model.addAttribute("facadeBean", task);
		}

		model.addAttribute("resUrl", resUrl);
		model.addAttribute("superRoleCole", Contants.SUPER_ROLE_CODE);
		return "result/send_detail";
	}
	
	
	/**
	 * 结果发送
	 * @param taskId  任务ID
	 * @param pAtlOrgVal    零部件图谱
	 * @param pPatOrgVal    零部件型式
	 * @param mAtlOrgVal    原材料图谱
	 * @param mPatOrgVal    原材料型式   
	 */
	@ResponseBody
	@RequestMapping(value = "/sendResult")
	public AjaxVO sendResult(HttpServletRequest request, Model model, Long taskId, String pAtlOrgVal, String pPatOrgVal, String mAtlOrgVal, String mPatOrgVal){
		AjaxVO vo = new AjaxVO();
		
		try {
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			taskService.sendResult(account, taskId, pAtlOrgVal, pPatOrgVal, mAtlOrgVal, mPatOrgVal);
		}catch(Exception ex){
			logger.error("结果发送失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}
		
		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}
	
	
	//-----------------------------------    结果确认        ---------------------------------------------------------------
	
	/**
	 * 结果确认列表
	 * @param type  类型：1-待上传结果，2-已上传结果
	 */
	@RequestMapping(value = "/confirmList")
	public String confirmList(HttpServletRequest request, HttpServletResponse response, Model model, int type) {
		Menu menu = null;
		
		if(type == 1){
			menu = menuService.selectByAlias("waitConfirm");
		}else{
			menu = menuService.selectByAlias("finishConfirm");
		}
		
		model.addAttribute("defaultPageSize", CONFIRM_DEFAULT_PAGE_SIZE);
		model.addAttribute("recordPageSize", RECORD_DEFAULT_PAGE_SIZE);
		model.addAttribute("menuName", menu.getName());
		model.addAttribute("type", type);
		return "result/confirm_list";
	}

	/**
	 * 列表数据
	 * @param type  类型：1-待上传结果，2-已上传结果
	 */
	@ResponseBody
	@RequestMapping(value = "/confirmListData")
	public Map<String, Object> confirmListData(HttpServletRequest request, Model model, String code, String orgId,
			String startCreateTime, String endCreateTime, String nickName, int type) {
		
		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", CONFIRM_DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		
		if(type == 1){
			map.put("confirmTask_wait", true);
		}else{
			map.put("confirmTask_finish", true);
		}

		if (StringUtils.isNotBlank(code)) {
			map.put("code", code);
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime);
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime);
		}
		if (StringUtils.isNotBlank(nickName)) {
			map.put("nickName", nickName);
		}
		if (StringUtils.isNotBlank(orgId)) {
			map.put("orgId", orgId);
		}

		List<Task> dataList = taskService.selectAllList(map);

		// 分页
		Page<Task> pageList = (Page<Task>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	/**
	 * 详情列表
	 */
	@RequestMapping(value = "/confirmDetail")
	public String confirmDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id, int type) {
		if (id != null) {
			Task task = taskService.selectOne(id);

			if(task.getType() == TaskTypeEnum.OTS.getState()){   // OTS 结果确认
				// 性能结果
				Map<String, Object> pfMap = new HashMap<String, Object>();
				pfMap.put("tId", id);
				pfMap.put("custom_order_sql", "exp_no asc");
				List<PfResult> pfDataList = pfResultService.selectAllList(pfMap);

				Map<Integer, List<PfResult>> pPfResult = new HashMap<Integer, List<PfResult>>();
				Map<Integer, List<PfResult>> mPfResult = new HashMap<Integer, List<PfResult>>();
				pfResultService.assemblePfResult(pfDataList, pPfResult, mPfResult);

				// 图谱结果
				Map<String, Object> atMap = new HashMap<String, Object>();
				atMap.put("tId", id);
				atMap.put("custom_order_sql", "exp_no asc");
				List<AtlasResult> atDataList = atlasResultService.selectAllList(atMap);

				Map<Integer, List<AtlasResult>> pAtlasResult = new HashMap<Integer, List<AtlasResult>>();
				Map<Integer, List<AtlasResult>> mAtlasResult = new HashMap<Integer, List<AtlasResult>>();
				atlasResultService.assembleAtlasResult(atDataList, pAtlasResult, mAtlasResult);

				// 原材料图谱结果
				model.addAttribute("mAtlasResult", mAtlasResult);
				// 零部件图谱结果
				model.addAttribute("pAtlasResult", pAtlasResult);
				// 原材料型式结果
				model.addAttribute("mPfResult", mPfResult);
				// 零部件型式结果
				model.addAttribute("pPfResult", pPfResult);
			}else if(task.getType() == TaskTypeEnum.PPAP.getState() || task.getType() == TaskTypeEnum.SOP.getState() ){
				
				// 基准图谱结果
				List<AtlasResult> sd_pAtlasResult = atlasResultService.getStandardAtlResult(task.getiId(), 1);
				List<AtlasResult> st_mAtlasResult = atlasResultService.getStandardAtlResult(task.getiId(), 2);
				
				// 抽样图谱结果
				Map<String, Object> atMap = new HashMap<String, Object>();
				atMap.put("tId", id);
				atMap.put("custom_order_sql", "exp_no desc limit 6");
				List<AtlasResult> atDataList = atlasResultService.selectAllList(atMap);

				List<AtlasResult> sl_pAtlasResult = new ArrayList<AtlasResult>();
				List<AtlasResult> sl_mAtlasResult = new ArrayList<AtlasResult>();
				groupAtlasResult(atDataList, sl_pAtlasResult, sl_mAtlasResult);
				
				// 零部件图谱结果
				Map<Integer, CompareVO> pAtlasResult = atlasResultService.assembleCompareAtlas(sd_pAtlasResult, sl_pAtlasResult);
				// 原材料图谱结果
				Map<Integer, CompareVO> mAtlasResult = atlasResultService.assembleCompareAtlas(st_mAtlasResult, sl_mAtlasResult);
				// 对比结果
				Map<String, List<ExamineRecord>> compareResult = atlasResultService.assembleCompareResult(id);
				
				model.addAttribute("mAtlasResult", mAtlasResult);
				model.addAttribute("pAtlasResult", pAtlasResult);
				model.addAttribute("compareResult", compareResult);
			}
						
			model.addAttribute("facadeBean", task);
		}
		
		model.addAttribute("resUrl", resUrl);
		model.addAttribute("type", type);
		return "result/confirm_detail";
	}
	
	
	/**
	 * 结果确认
	 * @param taskId  任务ID
	 * @param result  结果：1-合格，2-不合格
	 * @param type    类型：1-零部件图谱试验，2-零部件型式试验，3-原材料图谱试验，4-原材料型式试验，5-全部  （针对OTS任务类型）
	 * @param remark  不合格的理由
	 * @param orgs    发送警告书的机构
	 */
	@ResponseBody
	@RequestMapping(value = "/confirmResult")
	public AjaxVO confirmResult(HttpServletRequest request, Model model, Long taskId, int result, int type, String remark, String orgs){
		AjaxVO vo = new AjaxVO();
		
		try {
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			taskService.confirmResult(account, taskId, result, type, remark, orgs);
		}catch(Exception ex){
			logger.error("结果确认失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}
		
		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}
	
	
	//-----------------------------------    结果对比       ---------------------------------------------------------------
	
	/**
	 * 结果对比列表
	 */
	@RequestMapping(value = "/compareList")
	public String compareList(HttpServletRequest request, HttpServletResponse response, Model model) {
		Menu menu = menuService.selectByAlias("compare");
		
		model.addAttribute("defaultPageSize", COMPARE_DEFAULT_PAGE_SIZE);
		model.addAttribute("recordPageSize", RECORD_DEFAULT_PAGE_SIZE);
		model.addAttribute("menuName", menu.getName());
		return "result/compare_list";
	}

	/**
	 * 列表数据
	 */
	@ResponseBody
	@RequestMapping(value = "/compareListData")
	public Map<String, Object> compareListData(HttpServletRequest request, Model model, String code, String orgId,
			String startCreateTime, String endCreateTime, String nickName) {
		
		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", COMPARE_DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		map.put("state", SamplingTaskEnum.COMPARE.getState());
		map.put("compareTask", true);

		if (StringUtils.isNotBlank(code)) {
			map.put("code", code);
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime);
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime);
		}
		if (StringUtils.isNotBlank(nickName)) {
			map.put("nickName", nickName);
		}
		if (StringUtils.isNotBlank(orgId)) {
			map.put("orgId", orgId);
		}

		List<Task> dataList = taskService.selectAllList(map);

		// 分页
		Page<Task> pageList = (Page<Task>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	/**
	 * 详情列表
	 */
	@RequestMapping(value = "/compareDetail")
	public String compareDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id) {
		if (id != null) {
			Task task = taskService.selectOne(id);

			// 基准图谱结果
			List<AtlasResult> sd_pAtlasResult = atlasResultService.getStandardAtlResult(task.getiId(), 1);
			List<AtlasResult> st_mAtlasResult = atlasResultService.getStandardAtlResult(task.getiId(), 2);
			
			// 抽样图谱结果
			Map<String, Object> atMap = new HashMap<String, Object>();
			atMap.put("tId", id);
			atMap.put("custom_order_sql", "exp_no desc limit 6");
			List<AtlasResult> atDataList = atlasResultService.selectAllList(atMap);

			List<AtlasResult> sl_pAtlasResult = new ArrayList<AtlasResult>();
			List<AtlasResult> sl_mAtlasResult = new ArrayList<AtlasResult>();
			groupAtlasResult(atDataList, sl_pAtlasResult, sl_mAtlasResult);
			
			// 零部件图谱结果
			Map<Integer, CompareVO> pAtlasResult = atlasResultService.assembleCompareAtlas(sd_pAtlasResult, sl_pAtlasResult);
			// 原材料图谱结果
			Map<Integer, CompareVO> mAtlasResult = atlasResultService.assembleCompareAtlas(st_mAtlasResult, sl_mAtlasResult);

			// 原材料图谱结果
			model.addAttribute("mAtlasResult", mAtlasResult);
			// 零部件图谱结果
			model.addAttribute("pAtlasResult", pAtlasResult);
						
			model.addAttribute("facadeBean", task);
		}
		
		model.addAttribute("resUrl", resUrl);
		return "result/compare_detail";
	}
	
	
	/**
	 * 结果对比
	 * @param taskId  任务ID
	 * @param p_inf             零部件红外光一致性
	 * @param p_inf_remark      零部件红外光结论
	 * @param p_dt 				零部件差热一致性
	 * @param p_dt_remark       零部件差热结论
	 * @param p_tg              零部件热重一致性
	 * @param p_tg_remark       零部件热重光结论
	 * @param p_result          零部件结论一致性
	 * @param p_result_remark   零部件结论
	 * @param m_inf             原材料红外光一致性
	 * @param m_inf_remark      原材料红外光结论
	 * @param m_dt              原材料差热一致性
	 * @param m_dt_remark       原材料差热结论
	 * @param m_tg              原材料热重一致性
	 * @param m_tg_remark       原材料热重光结论
	 * @param m_result          原材料结论一致性
	 * @param m_result_remark   原材料结论
	 * @param state             状态：1-正常，2-异常
	 */
	@ResponseBody
	@RequestMapping(value = "/compareResult")
	public AjaxVO compareResult(HttpServletRequest request, Model model, Long taskId, int p_inf, String p_inf_remark,
			int p_dt, String p_dt_remark, int p_tg, String p_tg_remark, int p_result, String p_result_remark, int m_inf,
			String m_inf_remark, int m_dt, String m_dt_remark, int m_tg, String m_tg_remark, int m_result,
			String m_result_remark, int state) {

		AjaxVO vo = new AjaxVO();

		try {
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			Date date = new Date();

			// 对比结果
			List<ExamineRecord> resultList = new ArrayList<ExamineRecord>();

			if (state == 1) {
				ExamineRecord record1 = new ExamineRecord(taskId, account.getId(), p_inf, p_inf_remark, 4, 1, date, TaskTypeEnum.PPAP.getState());
				ExamineRecord record2 = new ExamineRecord(taskId, account.getId(), p_dt, p_dt_remark, 4, 2, date, TaskTypeEnum.PPAP.getState());
				ExamineRecord record3 = new ExamineRecord(taskId, account.getId(), p_tg, p_tg_remark, 4, 3, date, TaskTypeEnum.PPAP.getState());
				ExamineRecord record4 = new ExamineRecord(taskId, account.getId(), p_result, p_result_remark, 4, 4, date, TaskTypeEnum.PPAP.getState());
				ExamineRecord record5 = new ExamineRecord(taskId, account.getId(), m_inf, m_inf_remark, 4, 5, date, TaskTypeEnum.PPAP.getState());
				ExamineRecord record6 = new ExamineRecord(taskId, account.getId(), m_dt, m_dt_remark, 4, 6, date, TaskTypeEnum.PPAP.getState());
				ExamineRecord record7 = new ExamineRecord(taskId, account.getId(), m_tg, m_tg_remark, 4, 7, date, TaskTypeEnum.PPAP.getState());
				ExamineRecord record8 = new ExamineRecord(taskId, account.getId(), m_result, m_result_remark, 4, 8, date, TaskTypeEnum.PPAP.getState());

				resultList.add(record1);
				resultList.add(record2);
				resultList.add(record3);
				resultList.add(record4);
				resultList.add(record5);
				resultList.add(record6);
				resultList.add(record7);
				resultList.add(record8);
			}

			taskService.compareResult(account, taskId, resultList, state);
		} catch (Exception ex) {
			logger.error("结果对比失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}
	
	
	//-----------------------------------    其它       ---------------------------------------------------------------
	
	
	/**
	 * 分组
	 * @param atDataList
	 * @param pAtlasResult
	 * @param mAtlasResult
	 */
	public void groupAtlasResult(List<AtlasResult> arDataList, List<AtlasResult> pAtlasResult,  List<AtlasResult> mAtlasResult) {
		for (AtlasResult ar : arDataList) {
			if (ar.getCatagory() == 1) {
				pAtlasResult.add(ar);
			} else {
				mAtlasResult.add(ar);
			}
		}
	}
	
}
