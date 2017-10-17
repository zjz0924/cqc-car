package cn.wow.support.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.Page;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.Material;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.Parts;
import cn.wow.common.domain.Task;
import cn.wow.common.domain.TaskRecord;
import cn.wow.common.domain.Vehicle;
import cn.wow.common.service.InfoService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.TaskRecordService;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.StandardTaskEnum;
import cn.wow.common.utils.taskState.TaskTypeEnum;

@Controller
@RequestMapping(value = "ots")
public class OtsTaskController extends AbstractController {
	
	Logger logger = LoggerFactory.getLogger(OtsTaskController.class);
	
	// 审核列表
	private final static String EXAMINE_DEFAULT_PAGE_SIZE = "10";
	// 下达任务列表
	private final static String TRANSMIT_DEFAULT_PAGE_SIZE = "10";
	// 任务记录列表
	private final static String RECORD_DEFAULT_PAGE_SIZE = "10";
	// 任务审批列表
	private final static String APPROVE_DEFAULT_PAGE_SIZE = "10";
	
	// 零部件图片上传图片
	@Value("${info.parts.url}")
	protected String partsUrl;
	
	// 原材料图片上传路径
	@Value("${info.material.url}")
	protected String materialUrl;
	
	@Autowired
	private MenuService menuService;
	@Autowired
	private InfoService infoService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private TaskRecordService taskRecordService;

	/**
	 * 首页
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model, String choose) {
		HttpSession session = request.getSession();
		
		Menu menu = menuService.selectByAlias("otsTask");
		// 没有权限的菜单
		Set<Long> illegalMenu = (Set<Long>) session.getAttribute(Contants.CURRENT_ILLEGAL_MENU);
		
		if (menu != null && menu.getSubList() != null && menu.getSubList().size() > 0) {
			Iterator<Menu> it = menu.getSubList().iterator();
			while (it.hasNext()) {
				Menu subMenu = it.next();
				if (illegalMenu.contains(subMenu.getId())) {
					it.remove();
				}
			}
		}
		
		if(StringUtils.isBlank(choose)){
			choose = "0";
		}
		model.addAttribute("choose", Integer.parseInt(choose));
		
		ObjectMapper mapper = new ObjectMapper();  
        try {
			String json = mapper.writeValueAsString(menu.getSubList());
			model.addAttribute("menu", json);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
        
        model.addAttribute("menuName", menu.getName());
		return "task/ots/index";
	}
	
	
	/**
	 * 任务申请
	 */
	@RequestMapping(value = "/require")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "task/ots/require";
	}
	
	/**
	 * 任务申请保存
	 */
	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, String v_code, String v_type, String v_proTime,
			String v_proAddr, String v_remark, String p_code, String p_name, String p_producer, String p_proTime,
			String p_place, String p_proNo, String p_technology, String p_matName, String p_matNo, String p_matColor,
			String p_matProducer, String p_remark, String m_matName, String m_matColor, String m_proNo,
			String m_matProducer, String m_matNo, String m_producerAdd, String m_remark,
			@RequestParam(value = "p_pic", required = false) MultipartFile pfile,
			@RequestParam(value = "m_pic", required = false) MultipartFile mfile) {
		
		AjaxVO vo = new AjaxVO();
		
		try {
			Date date = new Date();
			
			// 整车信息
			Vehicle vehicle = new Vehicle();
			vehicle = new Vehicle();
			vehicle.setType(v_type);
			vehicle.setCode(v_code);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			vehicle.setProTime(sdf.parse(v_proTime));
			vehicle.setProAddr(v_proAddr);
			vehicle.setRemark(v_remark);
			vehicle.setState(Contants.ONDOING_TYPE);
			vehicle.setCreateTime(date);
			
			// 零部件信息
			Parts parts = new Parts();
			parts.setType(Contants.STANDARD_TYPE);
			parts.setProTime(sdf.parse(p_proTime));
			parts.setRemark(p_remark);
			parts.setProducer(p_matProducer);
			parts.setPlace(p_place);
			parts.setProNo(p_proNo);
			parts.setTechnology(p_technology);
			parts.setMatName(p_matName);
			parts.setMatNo(p_matNo);
			parts.setMatColor(p_matColor);
			parts.setMatProducer(p_matProducer);
			parts.setName(p_name);
			parts.setCode(p_code);
			parts.setCreateTime(date);
			parts.setState(Contants.ONDOING_TYPE);
			if (pfile != null && !pfile.isEmpty()) {
				String pic = uploadImg(pfile, partsUrl, true);
				parts.setPic(pic);
			}
			
			// 原材料信息
			Material material = new Material();
			material.setType(Contants.STANDARD_TYPE);
			material.setRemark(m_remark);
			material.setProNo(m_proNo);
			material.setMatName(m_matName);
			material.setMatNo(m_matNo);
			material.setMatColor(m_matColor);
			material.setMatProducer(m_matProducer);
			material.setProducerAdd(m_producerAdd);
			material.setCreateTime(date);
			material.setState(Contants.ONDOING_TYPE);
			
			if (mfile != null && !mfile.isEmpty()) {
				String pic = uploadImg(mfile, materialUrl, true);
				material.setPic(pic);
			}
			
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			infoService.insert(account, vehicle, parts, material, Contants.STANDARD_TYPE);
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("OTS任务申请失败", ex);
			
			vo.setSuccess(false);
			vo.setMsg("保存失败，系统异常");
		}
		
		vo.setSuccess(true);
		vo.setMsg("保存成功");
		return vo;
	}
	
	
	/**
	 * 审核列表
	 */
	@RequestMapping(value = "/examineList")
	public String examineList(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("defaultPageSize", EXAMINE_DEFAULT_PAGE_SIZE);
		model.addAttribute("recordPageSize", RECORD_DEFAULT_PAGE_SIZE);
		return "task/ots/examine_list";
	}
	
	/**
	 * 列表数据
	 */
	@ResponseBody
	@RequestMapping(value = "/examineListData")
	public Map<String, Object> examineListData(HttpServletRequest request, Model model, String code, String orgId,
			String startCreateTime, String endCreateTime, String nickName) {

		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", EXAMINE_DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		map.put("state", StandardTaskEnum.EXAMINE.getState());
		map.put("type", TaskTypeEnum.OTS.getState());

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
	@RequestMapping(value = "/examineDetail")
	public String examineDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id) {
		if(id != null){
			Task task = taskService.selectOne(id);
			
			model.addAttribute("facadeBean", task);
		}
		
		model.addAttribute("resUrl", resUrl);
		return "task/ots/examine_detail";
	}
	
	/**
	 * 审核结果
	 * @param id      任务ID
	 * @param type    结果： 1-通过， 2-不通过
	 * @param remark  备注
	 */
	@ResponseBody
	@RequestMapping(value = "/examine")
	public AjaxVO examine(HttpServletRequest request, Model model, Long id, int type, String remark){
		AjaxVO vo = new AjaxVO();
		
		try{
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			infoService.examine(account, id, type, remark);
		}catch(Exception ex){
			logger.error("OTS任务审核失败", ex);
			
			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}
		
		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}
	
	
	/**
	 * 任务下达列表
	 */
	@RequestMapping(value = "/transmitList")
	public String transmitList(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("defaultPageSize", TRANSMIT_DEFAULT_PAGE_SIZE);
		model.addAttribute("recordPageSize", RECORD_DEFAULT_PAGE_SIZE);
		return "task/ots/transmit_list";
	}
	
	/**
	 * 列表数据
	 */
	@ResponseBody
	@RequestMapping(value = "/transmitListData")
	public Map<String, Object> transmitListData(HttpServletRequest request, Model model, String code, String orgId,
			String startCreateTime, String endCreateTime, String nickName) {

		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", TRANSMIT_DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		map.put("state", StandardTaskEnum.TRANSMIT.getState());
		map.put("type", TaskTypeEnum.OTS.getState());

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
	@RequestMapping(value = "/transmitDetail")
	public String transmitDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id) {
		if(id != null){
			Task task = taskService.selectOne(id);
			
			model.addAttribute("facadeBean", task);
		}
		
		model.addAttribute("resUrl", resUrl);
		return "task/ots/transmit_detail";
	}
	
	
	/**
	 * 下达任务结果
	 * @param id     	     任务ID
	 * @param atlasLab    图谱实验室ID
	 * @param patternLab  型式实验室ID
	 */
	@ResponseBody
	@RequestMapping(value = "/transmit")
	public AjaxVO transmit(HttpServletRequest request, Model model, Long id, Long atlasLab, Long patternLab){
		AjaxVO vo = new AjaxVO();
		
		try{
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			infoService.transmit(account, id, atlasLab, patternLab);
		}catch(Exception ex){
			logger.error("OTS任务下达失败", ex);
			
			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}
		
		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}
	
	
	/**
	 * 任务记录列表数据
	 */
	@ResponseBody
	@RequestMapping(value = "/taskRecordListData")
	public Map<String, Object> taskRecordListData(HttpServletRequest request, Model model, String code) {

		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", RECORD_DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "create_time ASC");

		if (StringUtils.isNotBlank(code)) {
			map.put("code", code);

			List<TaskRecord> dataList = taskRecordService.selectAllList(map);

			// 分页
			Page<TaskRecord> pageList = (Page<TaskRecord>) dataList;

			Map<String, Object> dataMap = new HashMap<String, Object>();
			dataMap.put("total", pageList.getTotal());
			dataMap.put("rows", pageList.getResult());
			return dataMap;

		} else {
			Map<String, Object> dataMap = new HashMap<String, Object>();
			dataMap.put("total", 0);
			dataMap.put("rows", "");
			return dataMap;
		}
	}
	
	
	/**
	 * 任务审批列表
	 */
	@RequestMapping(value = "/approveList")
	public String approveList(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("defaultPageSize", APPROVE_DEFAULT_PAGE_SIZE);
		model.addAttribute("recordPageSize", RECORD_DEFAULT_PAGE_SIZE);
		return "task/ots/approve_list";
	}
	
	
	/**
	 * 列表数据
	 */
	@ResponseBody
	@RequestMapping(value = "/approveListData")
	public Map<String, Object> approveListData(HttpServletRequest request, Model model, String code, String orgId,
			String startCreateTime, String endCreateTime, String nickName) {

		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", APPROVE_DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		map.put("state", StandardTaskEnum.APPROVE.getState());
		map.put("type", TaskTypeEnum.OTS.getState());

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
	@RequestMapping(value = "/approveDetail")
	public String approveDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id) {
		if(id != null){
			Task task = taskService.selectOne(id);
			
			model.addAttribute("facadeBean", task);
		}
		
		model.addAttribute("resUrl", resUrl);
		return "task/ots/approve_detail";
	}
	
	
	/**
	 * 审批结果
	 * @param id      任务ID
	 * @param type    结果： 1-通过， 2-不通过
	 * @param remark  备注
	 */
	@ResponseBody
	@RequestMapping(value = "/approve")
	public AjaxVO approve(HttpServletRequest request, Model model, Long id, int type, String remark){
		AjaxVO vo = new AjaxVO();
		
		try{
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			infoService.approve(account, id, type, remark);
		}catch(Exception ex){
			logger.error("OTS任务审批失败", ex);
			
			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}
		
		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}
}
