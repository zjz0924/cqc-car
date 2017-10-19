package cn.wow.support.web;

import java.util.ArrayList;
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
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.PfResult;
import cn.wow.common.domain.Task;
import cn.wow.common.service.AtlasResultService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.PfResultService;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.StandardTaskEnum;

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
		map.put("state", StandardTaskEnum.UPLOADING.getState());
		
		// 超级管理员具有所有的权限
		if(account.getRole() == null || !Contants.SUPER_ROLE_CODE.equals(account.getRole().getCode())){
			if(type == 1){  //型式结果
				map.put("patternLab", account.getOrgId() == null ? -1: account.getOrgId());
			}else{   // 图谱结果
				map.put("atlasLab", account.getOrgId() == null ? -1: account.getOrgId());
			}
		}
		
		if(type == 1){
			map.put("patternResult", 0);
		}else{
			map.put("atlasResult", 0);
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
			
			// 零部件试验次数
			int pNum = atlasResultService.getExpNoByCatagory(taskId, 1);
			// 原材料试验次数
			int mNum = atlasResultService.getExpNoByCatagory(taskId, 2);
			
			/**  零部件结果  **/
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
			
			
			/** 原材料结果  **/
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
			
			List<AtlasResult> dataList = new ArrayList<AtlasResult>();
			dataList.add(p_tg);
			dataList.add(p_inf);
			dataList.add(p_dt);
			dataList.add(m_tg);
			dataList.add(m_inf);
			dataList.add(m_dt);
			
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
		
		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", SEND_DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		map.put("state", StandardTaskEnum.UPLOADING.getState());
		map.put("canSend", "yes");

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

			// 型式结果
			if(task.getPatternResult() == 1){
				Map<String, Object> pfMap = new HashMap<String, Object>();
				pfMap.put("tId", id);
				pfMap.put("custom_order_sql", "exp_no asc");
				List<PfResult> pfDataList = pfResultService.selectAllList(pfMap);
				
				Map<Integer, List<PfResult>> pPfResult = new HashMap<Integer, List<PfResult>>();
				Map<Integer, List<PfResult>> mPfResult = new HashMap<Integer, List<PfResult>>();
				assemblePfResult(pfDataList, pPfResult, mPfResult);
				
				model.addAttribute("pPfResult", pPfResult);
				model.addAttribute("mPfResult", mPfResult);
			}
			
			// 图谱结果
			if(task.getAtlasResult() == 1){
				Map<String, Object> atMap = new HashMap<String, Object>();
				atMap.put("tId", id);
				atMap.put("custom_order_sql", "exp_no asc");
				List<AtlasResult> atDataList = atlasResultService.selectAllList(atMap);
				
				Map<Integer, List<AtlasResult>> pAtlasResult = new HashMap<Integer, List<AtlasResult>>();
				Map<Integer, List<AtlasResult>> mAtlasResult = new HashMap<Integer, List<AtlasResult>>();
				assembleAtlasResult(atDataList, pAtlasResult, mAtlasResult);
				
				model.addAttribute("pAtlasResult", pAtlasResult);
				model.addAttribute("mAtlasResult", mAtlasResult);
			}
			
			model.addAttribute("facadeBean", task);
		}
		
		model.addAttribute("resUrl", resUrl);
		return "result/send_detail";
	}
	
	
	/**
	 * 结果发送
	 * @param taskId  任务ID
	 * @param orgs    要发送的机构
	 * @param type    类型：1-图谱结果，2-型式结果，3-两者
	 */
	@ResponseBody
	@RequestMapping(value = "/sendResult")
	public AjaxVO sendResult(HttpServletRequest request, Model model, Long taskId, String orgs, int type){
		AjaxVO vo = new AjaxVO();
		
		try {
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			taskService.sendResult(account, taskId, orgs, type);
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
	 * @param type  类型：1-原料图谱结果，2-零部件图谱结果
	 */
	@RequestMapping(value = "/confirmList")
	public String confirmList(HttpServletRequest request, HttpServletResponse response, Model model, int type) {
		Menu menu = null;
		
		if(type == 1){
			menu = menuService.selectByAlias("materialConfirm");
		}else{
			menu = menuService.selectByAlias("partsConfirm");
		}
		
		model.addAttribute("defaultPageSize", CONFIRM_DEFAULT_PAGE_SIZE);
		model.addAttribute("recordPageSize", RECORD_DEFAULT_PAGE_SIZE);
		model.addAttribute("menuName", menu.getName());
		model.addAttribute("type", type);
		return "result/confirm_list";
	}

	/**
	 * 列表数据
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
		map.put("state", StandardTaskEnum.CONFIRM.getState());
		
		if(type == 1){
			map.put("materialResult", 0);
		}else{
			map.put("partsResult", 0);
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

			// 图谱结果
			Map<String, Object> atMap = new HashMap<String, Object>();
			atMap.put("tId", id);
			atMap.put("custom_order_sql", "exp_no asc");
			List<AtlasResult> atDataList = atlasResultService.selectAllList(atMap);
			
			Map<Integer, List<AtlasResult>> pAtlasResult = new HashMap<Integer, List<AtlasResult>>();
			Map<Integer, List<AtlasResult>> mAtlasResult = new HashMap<Integer, List<AtlasResult>>();
			assembleAtlasResult(atDataList, pAtlasResult, mAtlasResult);
			
			model.addAttribute("pAtlasResult", pAtlasResult);
			model.addAttribute("mAtlasResult", mAtlasResult);
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
	 * @param type    类型：1-原料图谱结果，2-零部件图谱结果
	 */
	@ResponseBody
	@RequestMapping(value = "/confirmResult")
	public AjaxVO confirmResult(HttpServletRequest request, Model model, Long taskId, int result, int type){
		AjaxVO vo = new AjaxVO();
		
		try {
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			taskService.confirmResult(account, taskId, result, type);
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
	
	
	//-----------------------------------    其它       ---------------------------------------------------------------
	
	/**
	 * 组装型式结果
	 * @param pfDataList  当前任务所有的型式结果记录
	 * @param pPfResult   零部件的型式结果记录
	 * @param mPfResult   原材料的型式结果记录
	 */
	public void assemblePfResult(List<PfResult> pfDataList, Map<Integer, List<PfResult>> pPfResult,
			Map<Integer, List<PfResult>> mPfResult) {

		if (pfDataList != null && pfDataList.size() > 0) {
			for (PfResult pf : pfDataList) {
				if (pf.getCatagory() == 1) { // 零部件
					List<PfResult> list = pPfResult.get(pf.getExpNo());
					if (list != null) {
						list.add(pf);
					} else {
						list = new ArrayList<PfResult>();
						list.add(pf);
					}
					pPfResult.put(pf.getExpNo(), list);
				} else { // 原材料
					List<PfResult> list = mPfResult.get(pf.getExpNo());
					if (list != null) {
						list.add(pf);
					} else {
						list = new ArrayList<PfResult>();
						list.add(pf);
					}
					mPfResult.put(pf.getExpNo(), list);
				}
			}
		}
	}
	
	
	/**
	 * 组装图谱结果
	 * @param pfDataList  当前任务所有的图谱结果记录
	 * @param pPfResult   零部件的图谱结果记录
	 * @param mPfResult   原材料的图谱结果记录
	 */
	public void assembleAtlasResult(List<AtlasResult> atDataList, Map<Integer, List<AtlasResult>> pAtlasResult,
			Map<Integer, List<AtlasResult>> mAtlasResult) {

		if (atDataList != null && atDataList.size() > 0) {
			for (AtlasResult at : atDataList) {
				if (at.getCatagory() == 1) { // 零部件
					List<AtlasResult> list = pAtlasResult.get(at.getExpNo());
					if (list != null) {
						list.add(at);
					} else {
						list = new ArrayList<AtlasResult>();
						list.add(at);
					}
					pAtlasResult.put(at.getExpNo(), list);
				} else { // 原材料
					List<AtlasResult> list = mAtlasResult.get(at.getExpNo());
					if (list != null) {
						list.add(at);
					} else {
						list = new ArrayList<AtlasResult>();
						list.add(at);
					}
					mAtlasResult.put(at.getExpNo(), list);
				}
			}
		}
	}
	
	
}
