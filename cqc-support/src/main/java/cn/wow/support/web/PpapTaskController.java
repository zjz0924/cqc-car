package cn.wow.support.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.Page;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.ApplyRecord;
import cn.wow.common.domain.AtlasResult;
import cn.wow.common.domain.ExamineRecord;
import cn.wow.common.domain.Info;
import cn.wow.common.domain.Material;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.Parts;
import cn.wow.common.domain.StandardVO;
import cn.wow.common.domain.Task;
import cn.wow.common.domain.Vehicle;
import cn.wow.common.service.ApplyRecordService;
import cn.wow.common.service.AtlasResultService;
import cn.wow.common.service.ExamineRecordService;
import cn.wow.common.service.InfoService;
import cn.wow.common.service.MaterialService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.PartsService;
import cn.wow.common.service.TaskRecordService;
import cn.wow.common.service.TaskService;
import cn.wow.common.service.VehicleService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.SamplingTaskEnum;
import cn.wow.common.utils.taskState.TaskTypeEnum;

/**
 * PPAP任务
 * @author zhenjunzhuo
 * 2017-10-30
 */
@Controller
@RequestMapping(value = "ppap")
public class PpapTaskController extends AbstractController {

	Logger logger = LoggerFactory.getLogger(OtsTaskController.class);
	
	// 下达任务列表
	private final static String TRANSMIT_DEFAULT_PAGE_SIZE = "10";
	// 任务记录列表
	private final static String RECORD_DEFAULT_PAGE_SIZE = "10";
	// 任务审批列表
	private final static String APPROVE_DEFAULT_PAGE_SIZE = "10";
	
	@Autowired
	private MenuService menuService;
	@Autowired
	private InfoService infoService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private TaskRecordService taskRecordService;
	@Autowired
	private VehicleService vehicleService;
	@Autowired
	private PartsService partsService;
	@Autowired
	private MaterialService materialService;
	@Autowired
	private ExamineRecordService examineRecordService;
	@Autowired
	private ApplyRecordService applyRecordService;
	@Autowired
	private AtlasResultService atlasResultService;
	
	/**
	 * 首页
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model, String choose) {
		HttpSession session = request.getSession();

		Menu menu = menuService.selectByAlias("ppapTask");
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

		if (StringUtils.isBlank(choose)) {
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
		return "task/ppap/index";
	}
	
	/** --------------------------------   任务下达      ---------------------------------*/
	/**
	 * 任务下达列表
	 */
	@RequestMapping(value = "/transmitList")
	public String transmitList(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("defaultPageSize", TRANSMIT_DEFAULT_PAGE_SIZE);
		return "task/ppap/transmit_list";
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
		map.put("state", SamplingTaskEnum.APPROVE_NOTPASS.getState());
		map.put("type", TaskTypeEnum.PPAP.getState());

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
		if (id != null) {
			Task task = taskService.selectOne(id);
			
			// 审批记录
			Map<String, Object> rMap = new PageMap(false);
			rMap.put("taskId", id);
			rMap.put("type", 2);
			rMap.put("state", 2);
			rMap.put("taskType", TaskTypeEnum.PPAP.getState());
			rMap.put("custom_order_sql", "create_time asc");
			List<ExamineRecord> recordList = examineRecordService.selectAllList(rMap);

			model.addAttribute("facadeBean", task);
			model.addAttribute("recordList", recordList);
		}

		model.addAttribute("resUrl", resUrl);
		return "task/ppap/transmit_detail";
	}

	/**
	 * 下达任务结果
	 * 
	 * @param t_id         任务ID
	 * @param i_id         信息ID
	 * @param partsAtlId   零部件图谱实验室ID
	 * @param matAtlId     原材料图谱实验室ID
	 * @param partsPatId   零部件型式实验室ID
	 * @param matPatId     原材料型式实验室ID
	 */
	@ResponseBody
	@RequestMapping(value = "/transmit")
	public AjaxVO transmit(HttpServletRequest request, Model model, Long t_id, Long i_id, Long partsAtlId, Long matAtlId, Long partsPatId, Long matPatId) {
		AjaxVO vo = new AjaxVO();

		try {
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			
			boolean flag = infoService.transmit(account, t_id, i_id, partsAtlId, matAtlId, partsPatId, matPatId);
			if (!flag) {
				vo.setSuccess(false);
				vo.setMsg("已有进行中抽样，不能再申请");
				return vo;
			}
		} catch (Exception ex) {
			logger.error("PPAP任务下达失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}
	
	/** --------------------------------   任务审批      ---------------------------------*/
	/**
	 * 任务审批列表
	 */
	@RequestMapping(value = "/approveList")
	public String approveList(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("defaultPageSize", APPROVE_DEFAULT_PAGE_SIZE);
		model.addAttribute("recordPageSize", RECORD_DEFAULT_PAGE_SIZE);
		return "task/ppap/approve_list";
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
		map.put("ppap_approveTask", true);
		map.put("type", TaskTypeEnum.PPAP.getState());

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
		int approveType = 3;
		
		if (id != null) {
			Task task = taskService.selectOne(id);
			
			if(task.getState() == SamplingTaskEnum.APPLYING.getState()){
				if (task.getInfoApply() == 1) { // 申请修改信息
					approveType = 1;
					ApplyRecord applyRecord = applyRecordService.getRecordByTaskId(task.getId(), 1);
					
					if(applyRecord != null){
						if (applyRecord.getpId() != null) {
							Parts newParts = partsService.selectOne(applyRecord.getpId());
							model.addAttribute("newParts", newParts);
						}

						if (applyRecord.getvId() != null) {
							Vehicle newVehicle = vehicleService.selectOne(applyRecord.getvId());
							model.addAttribute("newVehicle", newVehicle);
						}

						if (applyRecord.getmId() != null) {
							Material newMaterial = materialService.selectOne(applyRecord.getvId());
							model.addAttribute("newMaterial", newMaterial);
						}
					}
					
				}else if (task.getResultApply() == 1) { // 申请修改试验结果
					approveType = 2;
					
					/** ---------  原结果  ----------- */
					// 零部件-图谱结果（只取最后一次实验）
					List<AtlasResult> pAtlasResult_old = atlasResultService.getLastResult(1, task.gettId());
					
					// 原材料-图谱结果（只取最后一次实验）
					List<AtlasResult> mAtlasResult_old = atlasResultService.getLastResult(2, task.gettId());
					
					/** ---------  修改之后的结果  ----------- */
					// 零部件-图谱结果（只取最后一次实验）
					List<AtlasResult> pAtlasResult_new = atlasResultService.getLastResult(1, task.getId());
					
					// 原材料-图谱结果（只取最后一次实验）
					List<AtlasResult> mAtlasResult_new = atlasResultService.getLastResult(2, task.getId());
					
					model.addAttribute("pAtlasResult_old", pAtlasResult_old);
					model.addAttribute("mAtlasResult_old", mAtlasResult_old);
					model.addAttribute("pAtlasResult_new", pAtlasResult_new);
					model.addAttribute("mAtlasResult_new", mAtlasResult_new);
				}
			}

			model.addAttribute("facadeBean", task);
		}

		model.addAttribute("resUrl", resUrl);
		model.addAttribute("approveType", approveType);
		
		if (approveType == 1) {
			return "task/ppap/approve_info_detail";
		} else {
			return "task/ppap/approve_detail";
		}
	}
	
	
	/**
     * 审批结果
     * @param account  操作用户
     * @param id       任务ID
     * @param result   结果：1-通过，2-不通过
     * @param remark   备注
     * @param catagory 分类：1-信息修改申请，2-试验结果修改申请，3-正常流程
     */
	@ResponseBody
	@RequestMapping(value = "/approve")
	public AjaxVO approve(HttpServletRequest request, Model model, Long id, int result, String remark, int catagory) {
		AjaxVO vo = new AjaxVO();

		try {
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			infoService.approve(account, id, result, catagory, remark);
		} catch (Exception ex) {
			logger.error("PPAP任务审批失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}
	
	
	/**
	 * 获取基准数据
	 * @param v_id
	 * @param p_id
	 * @param m_id
	 */
	@ResponseBody
	@RequestMapping(value = "/standard")
	public List<StandardVO> standard(HttpServletRequest request, Model model, Long v_id, Long p_id, Long m_id) {
		List<StandardVO> dataList = new ArrayList<StandardVO>();
		if (v_id == null || p_id == null || m_id == null) {
			return dataList;
		}
		
		Map<String, Object> iMap = new PageMap(false);
		iMap.put("mId", m_id);
		iMap.put("pId", p_id);
		iMap.put("vId", v_id);
		iMap.put("state", 1);
		List<Info> infoList = infoService.selectAllList(iMap);
		
		if (infoList != null && infoList.size() > 0) {
			List<Long> idList = new ArrayList<Long>();
			for (Info info : infoList) {
				idList.add(info.getId());
			}

			List<Task> taskList = taskService.batchQueryByInfoId(idList);
			if (taskList != null && taskList.size() > 0) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

				for (int i = 0; i < taskList.size(); i++) {
					Task task = taskList.get(i);
					StandardVO vo = new StandardVO();
					vo.setDate(sdf.format(task.getCreateTime()));
					vo.setId(task.getiId());
					vo.setTaskCode(task.getCode());
					vo.setText("基准" + (i + 1));
					dataList.add(vo);
				}
			}
		}
		return dataList;
	}
	
}
