package cn.wow.support.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.Page;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.Address;
import cn.wow.common.domain.ApplyRecord;
import cn.wow.common.domain.AtlasResult;
import cn.wow.common.domain.CarCode;
import cn.wow.common.domain.Department;
import cn.wow.common.domain.ExamineRecord;
import cn.wow.common.domain.LabConclusion;
import cn.wow.common.domain.LabReq;
import cn.wow.common.domain.Material;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.Parts;
import cn.wow.common.domain.PfResult;
import cn.wow.common.domain.Task;
import cn.wow.common.domain.TaskRecord;
import cn.wow.common.domain.Vehicle;
import cn.wow.common.service.AccountService;
import cn.wow.common.service.AddressService;
import cn.wow.common.service.ApplyRecordService;
import cn.wow.common.service.AtlasResultService;
import cn.wow.common.service.CarCodeService;
import cn.wow.common.service.CommonService;
import cn.wow.common.service.DepartmentService;
import cn.wow.common.service.ExamineRecordService;
import cn.wow.common.service.InfoService;
import cn.wow.common.service.LabConclusionService;
import cn.wow.common.service.LabReqService;
import cn.wow.common.service.MaterialService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.PartsService;
import cn.wow.common.service.PfResultService;
import cn.wow.common.service.TaskRecordService;
import cn.wow.common.service.TaskService;
import cn.wow.common.service.VehicleService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.StandardTaskEnum;
import cn.wow.common.utils.taskState.TaskStageEnum;
import cn.wow.common.utils.taskState.TaskTypeEnum;
import cn.wow.common.vo.ResultFlagVO;

/**
 * OTS任务
 * 
 * @author zhenjunzhuo 2017-10-30
 */
@Controller
@RequestMapping(value = "ots")
public class OtsTaskController extends AbstractController {

	Logger logger = LoggerFactory.getLogger(OtsTaskController.class);

	// 申请列表
	private final static String REQUIRE_DEFAULT_PAGE_SIZE = "10";
	// 审核列表
	private final static String EXAMINE_DEFAULT_PAGE_SIZE = "10";
	// 下达任务列表
	private final static String TRANSMIT_DEFAULT_PAGE_SIZE = "10";
	// 任务记录列表
	private final static String RECORD_DEFAULT_PAGE_SIZE = "10";
	// 任务审批列表
	private final static String APPROVE_DEFAULT_PAGE_SIZE = "10";

	// 零件图片上传图片
	@Value("${info.parts.url}")
	protected String partsUrl;

	// 材料图片上传路径
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
	@Autowired
	private PfResultService pfResultService;
	@Autowired
	private LabReqService labReqService;
	@Autowired
	private LabConclusionService labConclusionService;
	@Autowired
	private AddressService addressService;
	@Autowired
	private CarCodeService carCodeService;
	@Autowired
	private AccountService accountService;
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private CommonService commonService;

	/**
	 * 首页
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model, String choose) {
		HttpSession session = request.getSession();
		Menu menu = menuService.selectByAlias("otsTask");

		// 没有权限的菜单
		@SuppressWarnings("unchecked")
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
		return "task/ots/index";
	}

	/** -------------------------------- 任务申请 --------------------------------- */
	/**
	 * 任务申请列表
	 */
	@RequestMapping(value = "/requireList")
	public String requireList(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("defaultPageSize", REQUIRE_DEFAULT_PAGE_SIZE);

		// 生产基地
		List<Address> addressList = addressService.getAddressList();
		// 车型代码
		List<CarCode> carCodeList = carCodeService.getCarCodeList();

		model.addAttribute("addressList", addressList);
		model.addAttribute("carCodeList", carCodeList);

		return "task/ots/require_list";
	}

	/**
	 * 列表数据
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/requireListData")
	public Map<String, Object> requireListData(HttpServletRequest request, Model model, String startCreateTime,
			String endCreateTime, String task_code, Integer state, Integer draft, String parts_name,
			String parts_producer, String parts_producerCode, String startProTime, String endProTime, String matName,
			String mat_producer, String matNo, String v_code, String v_proAddr, String applicat_name,
			String applicat_depart, Long applicat_org) {

		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);

		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", REQUIRE_DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");

		if (state == null) {
			map.put("examineState", true);
		} else {
			map.put("state", state);
		}
		map.put("type", TaskTypeEnum.OTS.getState());

		if (StringUtils.isNotBlank(task_code)) {
			map.put("code", task_code);
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
		}
		if (draft != null) {
			map.put("draft", draft);
		}

		List<Long> iIdList = infoService.selectIds(parts_name, parts_producer, parts_producerCode, startProTime,
				endProTime, matName, matNo, mat_producer, v_code, v_proAddr);
		if (iIdList.size() > 0) {
			map.put("iIdList", iIdList);
		}

		// 申请人信息
		List<Long> applicatIdList = accountService.selectIds(applicat_name, applicat_depart, applicat_org);
		if (applicatIdList.size() > 0) {
			map.put("applicatIdList", applicatIdList);
		}

		// 除了超级管理员，其它用户只能查看自己录入的申请记录
		if (account.getRole() == null || !Contants.SUPER_ROLE_CODE.equals(account.getRole().getCode())) {
			map.put("applicatId", account.getId());
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
	 * 任务详情
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/requireDetail")
	public String requireDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id) {

		Account applicat = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);

		if (id != null) {
			Task task = taskService.selectOne(id);

			// 审核记录
			Map<String, Object> rMap = new PageMap(false);
			rMap.put("taskId", id);
			rMap.put("custom_order_sql", "create_time asc");
			rMap.put("type", TaskTypeEnum.OTS.getState());
			rMap.put("taskType", task.getType());
			List<ExamineRecord> recordList = examineRecordService.selectAllList(rMap);

			// 申请人
			applicat = task.getApplicat();

			// 图谱类型
			if (validChoose(task.getAtlType(), "1")) {
				model.addAttribute("partAtl", "1");
			}
			if (validChoose(task.getAtlType(), "2")) {
				model.addAttribute("materialAtl", "1");
			}

			// 权限信息
			if (task.getExamineAccountId() != null) {
				model.addAttribute("examineAccount", accountService.selectOne(task.getExamineAccountId()));
			}
			if (task.getTrainsmitAccountId() != null) {
				model.addAttribute("trainsmitAccount", accountService.selectOne(task.getTrainsmitAccountId()));
			}
			if (task.getApproveAccountId() != null) {
				model.addAttribute("approveAccount", accountService.selectOne(task.getApproveAccountId()));
			}

			model.addAttribute("facadeBean", task);
			model.addAttribute("recordList", recordList);
		} else {
			// 权限信息
			Account examineAccount = applicat.getParent();
			if (examineAccount != null) {
				model.addAttribute("examineAccount", examineAccount);

				Account trainsmitAccount = examineAccount.getParent();
				if (trainsmitAccount != null) {
					model.addAttribute("trainsmitAccount", trainsmitAccount);

					Account approveAccount = trainsmitAccount.getParent();
					if (approveAccount != null) {
						model.addAttribute("approveAccount", approveAccount);
					}
				}
			}
		}

		// 生产基地
		List<Address> addressList = addressService.getAddressList();
		// 车型代码
		List<CarCode> carCodeList = carCodeService.getCarCodeList();

		model.addAttribute("addressList", addressList);
		model.addAttribute("carCodeList", carCodeList);
		model.addAttribute("applicat", applicat);
		return "task/ots/require_detail";
	}

	/**
	 * 任务申请保存
	 */
	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, Long v_id, String v_code, String v_proTime,
			String v_proAddr, String v_remark, String p_code, String p_name, String p_proTime, String p_place,
			String p_proNo, Long p_id, Integer p_num, String p_remark, Long m_id, String m_matName, String m_matColor,
			String m_proNo, String m_matNo, String m_remark, Long t_id, Integer m_num, Integer draft, String p_producer,
			String m_producer, String[] atlType, String atlRemark, String atlItem, String p_producerCode,
			Long examineAccountId, Long trainsmitAccountId, Long approveAccountId) {

		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
		AjaxVO vo = new AjaxVO();

		try {
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			// 车型信息
			Vehicle vehicle = null;
			if (v_id == null) {
				vehicle = new Vehicle();
				vehicle.setCode(v_code);
				if (StringUtils.isNotBlank(v_proTime)) {
					vehicle.setProTime(sdf.parse(v_proTime));
				}
				vehicle.setProAddr(v_proAddr);
				vehicle.setRemark(v_remark);
				vehicle.setState(Contants.ONDOING_TYPE);
				vehicle.setCreateTime(date);

				boolean isExist = vehicleService.isExist(null, v_code,
						StringUtils.isNotBlank(v_proTime) ? sdf.parse(v_proTime) : null, v_proAddr).getFlag();
				if (isExist) {
					vo.setSuccess(false);
					vo.setMsg("车型信息已存在");
					return vo;
				}
			} else {
				vehicle = vehicleService.selectOne(v_id);

				// 编辑时
				if (vehicle.getState().intValue() == 0) {
					boolean isExist = vehicleService.isExist(v_id, v_code,
							StringUtils.isNotBlank(v_proTime) ? sdf.parse(v_proTime) : null, v_proAddr).getFlag();

					if (isExist) {
						vo.setSuccess(false);
						vo.setMsg("车型信息已存在");
						return vo;
					}
				} else {
					// 新增时，如果是选择的情况，先判断输入的信息是否存在，如果存在就不新增，如果不存在就新增一条记录（表示有修改过）
					ResultFlagVO isExist = vehicleService.isExist(v_id, v_code,
							StringUtils.isNotBlank(v_proTime) ? sdf.parse(v_proTime) : null, v_proAddr);
					if (!isExist.getFlag()) {
						vehicle.setId(null);
					} else {
						// 存在正在审批的记录
						if (isExist.getState() == 0) {
							vo.setSuccess(false);
							vo.setMsg("车型信息已存在");
							return vo;
						}
					}
				}

				if (StringUtils.isNotBlank(v_proTime)) {
					vehicle.setProTime(sdf.parse(v_proTime));
				}
				vehicle.setProAddr(v_proAddr);
				vehicle.setRemark(v_remark);
				vehicle.setCode(v_code);
			}

			// 零件信息
			Parts parts = null;
			if (p_id == null) {
				parts = new Parts();
				parts.setType(Contants.STANDARD_TYPE);
				if (StringUtils.isNotBlank(p_proTime)) {
					parts.setProTime(sdf.parse(p_proTime));
				}
				parts.setRemark(p_remark);
				parts.setPlace(p_place);
				parts.setProNo(p_proNo);
				parts.setName(p_name);
				parts.setCode(p_code);
				parts.setProducer(p_producer);
				parts.setProducerCode(p_producerCode);
				parts.setCreateTime(date);
				if (p_num != null) {
					parts.setNum(p_num.intValue());
				}
				parts.setState(Contants.ONDOING_TYPE);

				boolean isExist = partsService
						.isExist(null, p_name, StringUtils.isNotBlank(p_proTime) ? sdf.parse(p_proTime) : null,
								p_producer, p_producerCode, p_code, p_proNo, p_num, p_place)
						.getFlag();
				if (isExist) {
					vo.setSuccess(false);
					vo.setMsg("零件信息已存在");
					return vo;
				}
			} else {
				parts = partsService.selectOne(p_id);

				// 编辑时
				if (parts.getState().intValue() == 0) {
					boolean isExist = partsService
							.isExist(p_id, p_name, StringUtils.isNotBlank(p_proTime) ? sdf.parse(p_proTime) : null,
									p_producer, p_producerCode, p_code, p_proNo, p_num, p_place)
							.getFlag();
					if (isExist) {
						vo.setSuccess(false);
						vo.setMsg("零件信息已存在");
						return vo;
					}
				} else {
					// 新增时，如果是选择的情况，先判断输入的信息是否存在，如果存在就不新增，如果不存在就新增一条记录（表示有修改过）
					ResultFlagVO isExist = partsService.isExist(p_id, p_name,
							StringUtils.isNotBlank(p_proTime) ? sdf.parse(p_proTime) : null, p_producer, p_producerCode,
							p_code, p_proNo, p_num, p_place);

					if (!isExist.getFlag()) {
						parts.setId(null);
					} else {
						// 存在正在审批的记录
						if (isExist.getState() == 0) {
							vo.setSuccess(false);
							vo.setMsg("零件信息已存在");
							return vo;
						}
					}
				}

				if (StringUtils.isNotBlank(p_proTime)) {
					parts.setProTime(sdf.parse(p_proTime));
				}
				parts.setRemark(p_remark);
				parts.setPlace(p_place);
				parts.setProNo(p_proNo);
				parts.setName(p_name);
				parts.setProducer(p_producer);
				parts.setCode(p_code);
				if (p_num != null) {
					parts.setNum(p_num.intValue());
				}
				parts.setProducerCode(p_producerCode);
			}

			// 材料信息
			Material material = null;
			if (m_id == null) {
				material = new Material();
				material.setType(Contants.STANDARD_TYPE);
				material.setRemark(m_remark);
				material.setProNo(m_proNo);
				material.setMatName(m_matName);
				material.setMatNo(m_matNo);
				material.setMatColor(m_matColor);
				material.setProducer(m_producer);
				material.setCreateTime(date);
				if (m_num != null) {
					material.setNum(m_num.intValue());
				}
				material.setState(Contants.ONDOING_TYPE);
			} else {
				material = materialService.selectOne(m_id);
				material.setRemark(m_remark);
				material.setProNo(m_proNo);
				material.setMatName(m_matName);
				material.setMatNo(m_matNo);
				material.setMatColor(m_matColor);
				material.setProducer(m_producer);
				if (m_num != null) {
					material.setNum(m_num.intValue());
				}
			}

			Task task = infoService.require(account, vehicle, parts, material, null, Contants.STANDARD_TYPE, t_id,
					TaskTypeEnum.OTS.getState(), draft.intValue(), formatAltType(atlType), atlRemark, atlItem,
					examineAccountId, trainsmitAccountId, approveAccountId);

			// 发送邮件
			commonService.mailNotify(account, task, TaskStageEnum.EXAMINE);

		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("任务申请失败", ex);

			vo.setSuccess(false);
			vo.setMsg("保存失败，系统异常");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("保存成功");
		return vo;
	}

	/** -------------------------------- 任务审核 --------------------------------- */
	/**
	 * 审核列表
	 */
	@RequestMapping(value = "/examineList")
	public String examineList(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("defaultPageSize", EXAMINE_DEFAULT_PAGE_SIZE);
		model.addAttribute("recordPageSize", RECORD_DEFAULT_PAGE_SIZE);

		// 生产基地
		List<Address> addressList = addressService.getAddressList();
		// 车型代码
		List<CarCode> carCodeList = carCodeService.getCarCodeList();

		model.addAttribute("addressList", addressList);
		model.addAttribute("carCodeList", carCodeList);

		return "task/ots/examine_list";
	}

	/**
	 * 列表数据
	 */
	@ResponseBody
	@RequestMapping(value = "/examineListData")
	public Map<String, Object> examineListData(HttpServletRequest request, Model model, String startCreateTime,
			String endCreateTime, String task_code, String parts_name, String parts_producer, String parts_producerCode,
			String startProTime, String endProTime, String matName, String mat_producer, String matNo, String v_code,
			String v_proAddr, String applicat_name, String applicat_depart, Long applicat_org) {

		Account applicat = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);

		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", EXAMINE_DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		map.put("state", StandardTaskEnum.EXAMINE.getState());
		map.put("type", TaskTypeEnum.OTS.getState());
		map.put("neDraft", "1");

		// 超级管理员拥有所有权限
		if (applicat.getRole() == null || !Contants.SUPER_ROLE_CODE.equals(applicat.getRole().getCode())) {
			map.put("examineAccountId", applicat.getId());
		}

		if (StringUtils.isNotBlank(task_code)) {
			map.put("code", task_code);
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
		}

		List<Long> iIdList = infoService.selectIds(parts_name, parts_producer, parts_producerCode, startProTime,
				endProTime, matName, matNo, mat_producer, v_code, v_proAddr);
		if (iIdList.size() > 0) {
			map.put("iIdList", iIdList);
		}

		// 申请人信息
		List<Long> applicatIdList = accountService.selectIds(applicat_name, applicat_depart, applicat_org);
		if (applicatIdList.size() > 0) {
			map.put("applicatIdList", applicatIdList);
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
		if (id != null) {
			Task task = taskService.selectOne(id);

			// 图谱类型
			if (validChoose(task.getAtlType(), "1")) {
				model.addAttribute("partAtl", "1");
			}
			if (validChoose(task.getAtlType(), "2")) {
				model.addAttribute("materialAtl", "1");
			}

			model.addAttribute("facadeBean", task);
		}

		// 生产基地
		List<Address> addressList = addressService.getAddressList();
		// 车型代码
		List<CarCode> carCodeList = carCodeService.getCarCodeList();

		model.addAttribute("carCodeList", carCodeList);
		model.addAttribute("addressList", addressList);
		model.addAttribute("resUrl", resUrl);
		return "task/ots/examine_detail";
	}

	/**
	 * 批量审核结果
	 * 
	 * @param ids    任务ID
	 * @param type   结果： 1-通过， 2-不通过
	 * @param remark 备注
	 */
	@ResponseBody
	@RequestMapping(value = "/batchExamine")
	public AjaxVO batchExamine(HttpServletRequest request, Model model, @RequestParam(value = "ids[]") Long[] ids,
			int type, String remark) {
		AjaxVO vo = new AjaxVO();
		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);

		try {
			List<Task> taskList = infoService.examine(account, ids, type, remark);

			// 发送邮件
			if (taskList != null && taskList.size() > 0) {
				for (Task task : taskList) {
					commonService.mailNotify(account, task, TaskStageEnum.TRANSMIT);
				}
			}

		} catch (Exception ex) {
			logger.error("任务批量审核失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}

	/**
	 * 审核结果
	 * 
	 * @param id     任务 ID
	 * @param result 结果： 1-通过， 2-不通过
	 * @param remark 备注
	 */
	@ResponseBody
	@RequestMapping(value = "/examine")
	public AjaxVO examine(HttpServletRequest request, Model model, Long v_id, String v_code, String v_proTime,
			String v_proAddr, String v_remark, String[] atlType, String atlRemark, String p_code, String p_name,
			String p_proTime, String p_place, String p_proNo, Long p_id, Integer p_num, String p_remark, Long m_id,
			String m_matName, String m_matColor, String m_proNo, String m_matNo, String m_remark, Long t_id,
			Integer result, String examine_remark, Long id, String p_producer, String m_producer, String p_producerCode,
			Integer m_num) {

		AjaxVO vo = new AjaxVO();
		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		try {
			// 车型信息
			Vehicle vehicle = vehicleService.selectOne(v_id);
			if (vehicleService.isUpdateVehicleInfo(vehicle, v_code, v_proTime, v_proAddr, v_remark)) {
				vehicle.setProTime(sdf.parse(v_proTime));
				vehicle.setProAddr(v_proAddr);
				vehicle.setRemark(v_remark);
				vehicle.setCode(v_code);

				boolean isExist = vehicleService.isExist(v_id, v_code,
						StringUtils.isNotBlank(v_proTime) ? sdf.parse(v_proTime) : null, v_proAddr).getFlag();
				if (isExist) {
					vo.setSuccess(false);
					vo.setMsg("车型信息已存在");
					return vo;
				}
			}

			// 零件信息
			Parts parts = partsService.selectOne(p_id);
			if (partsService.isUpdatePartsInfo(parts, p_code, p_name, p_proTime, p_place, p_proNo, p_remark, p_num,
					p_producer, p_producerCode)) {

				if (StringUtils.isNoneBlank(p_proTime)) {
					parts.setProTime(sdf.parse(p_proTime));
				}
				parts.setRemark(p_remark);
				parts.setPlace(p_place);
				parts.setProNo(p_proNo);
				parts.setName(p_name);
				parts.setProducer(p_producer);
				parts.setCode(p_code);
				if (p_num != null) {
					parts.setNum(p_num.intValue());
				}

				boolean isExist = partsService
						.isExist(p_id, p_name, StringUtils.isNoneBlank(p_proTime) ? sdf.parse(p_proTime) : null,
								p_producer, p_producerCode, p_code, p_proNo, p_num, p_place)
						.getFlag();
				if (isExist) {
					vo.setSuccess(false);
					vo.setMsg("零件信息已存在");
					return vo;
				}
			}

			// 材料信息
			Material material = null;
			material = materialService.selectOne(m_id);
			material.setRemark(m_remark);
			material.setProNo(m_proNo);
			material.setMatName(m_matName);
			material.setMatNo(m_matNo);
			material.setMatColor(m_matColor);
			material.setProducer(m_producer);
			if (m_num != null) {
				material.setNum(m_num);
			}

			Task task = infoService.examine(account, t_id, result, examine_remark, vehicle, parts, material,
					formatAltType(atlType), atlRemark, null);

			// 发送邮件
			commonService.mailNotify(account, task, TaskStageEnum.TRANSMIT);

		} catch (Exception ex) {
			logger.error("任务审核失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}

	/** -------------------------------- 任务下达 --------------------------------- */
	/**
	 * 任务下达列表
	 */
	@RequestMapping(value = "/transmitList")
	public String transmitList(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("defaultPageSize", TRANSMIT_DEFAULT_PAGE_SIZE);
		model.addAttribute("recordPageSize", RECORD_DEFAULT_PAGE_SIZE);

		// 生产基地
		List<Address> addressList = addressService.getAddressList();
		// 车型代码
		List<CarCode> carCodeList = carCodeService.getCarCodeList();

		model.addAttribute("addressList", addressList);
		model.addAttribute("carCodeList", carCodeList);

		return "task/ots/transmit_list";
	}

	/**
	 * 列表数据
	 */
	@ResponseBody
	@RequestMapping(value = "/transmitListData")
	public Map<String, Object> transmitListData(HttpServletRequest request, Model model, String startCreateTime,
			String endCreateTime, String task_code, String parts_name, String parts_producer, String parts_producerCode,
			String startProTime, String endProTime, String matName, String mat_producer, String matNo, String v_code,
			String v_proAddr, String applicat_name, String applicat_depart, Long applicat_org) {

		Account applicat = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);

		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", TRANSMIT_DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		map.put("transimtTask_ots", true);
		map.put("state", StandardTaskEnum.TESTING.getState());
		map.put("type", TaskTypeEnum.OTS.getState());

		// 超级管理员拥有所有权限
		if (applicat.getRole() == null || !Contants.SUPER_ROLE_CODE.equals(applicat.getRole().getCode())) {
			map.put("trainsmitAccountId", applicat.getId());
		}

		if (StringUtils.isNotBlank(task_code)) {
			map.put("code", task_code);
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
		}

		List<Long> iIdList = infoService.selectIds(parts_name, parts_producer, parts_producerCode, startProTime,
				endProTime, matName, matNo, mat_producer, v_code, v_proAddr);
		if (iIdList.size() > 0) {
			map.put("iIdList", iIdList);
		}

		// 申请人信息
		List<Long> applicatIdList = accountService.selectIds(applicat_name, applicat_depart, applicat_org);
		if (applicatIdList.size() > 0) {
			map.put("applicatIdList", applicatIdList);
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

			Map<String, Object> rMap = new PageMap(false);
			rMap.put("taskId", id);
			rMap.put("type", 2);
			rMap.put("state", 2);
			rMap.put("custom_order_sql", "create_time asc");
			rMap.put("taskType", TaskTypeEnum.OTS.getState());
			List<ExamineRecord> recordList = examineRecordService.selectAllList(rMap);

			// 图谱类型
			if (validChoose(task.getAtlType(), "1")) {
				model.addAttribute("partAtl", "1");
			}
			if (validChoose(task.getAtlType(), "2")) {
				model.addAttribute("materialAtl", "1");
			}

			model.addAttribute("facadeBean", task);
			model.addAttribute("recordList", recordList);
		}

		// 生产基地
		List<Address> addressList = addressService.getAddressList();
		// 车型代码
		List<CarCode> carCodeList = carCodeService.getCarCodeList();

		model.addAttribute("addressList", addressList);
		model.addAttribute("carCodeList", carCodeList);
		return "task/ots/transmit_detail";
	}

	/**
	 * 下达任务结果
	 * 
	 * @param id         任务ID
	 * @param partsAtlId 零件图谱实验室ID
	 * @param matAtlId   材料图谱实验室ID
	 * @param partsPatId 零件型式实验室ID
	 * @param matPatId   材料型式实验室ID
	 */
	@ResponseBody
	@RequestMapping(value = "/transmit")
	public AjaxVO transmit(HttpServletRequest request, Model model, Long id, Long partsAtlId, Long matAtlId,
			String partsAtlCode, String partsAtlTime, String partsAtlReq, String matAtlCode, String matAtlTime,
			String matAtlReq) {
		AjaxVO vo = new AjaxVO();

		try {
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			List<LabReq> labReqList = new ArrayList<LabReq>();
			if (partsAtlId != null) {
				labReqList.add(new LabReq(partsAtlCode,
						StringUtils.isNotBlank(partsAtlTime) ? sdf.parse(partsAtlTime) : null, partsAtlReq, id, 1));
			}

			if (matAtlId != null) {
				labReqList.add(new LabReq(matAtlCode, StringUtils.isNotBlank(matAtlTime) ? sdf.parse(matAtlTime) : null,
						matAtlReq, id, 2));
			}

			Task task = infoService.transmit(account, id, partsAtlId, matAtlId, null, null, labReqList);

			// 发送邮件
			commonService.mailNotify(account, task, TaskStageEnum.APPROVE);

		} catch (Exception ex) {
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
		map.put("custom_order_sql", "create_time desc");

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

	/** -------------------------------- 任务审批 --------------------------------- */
	/**
	 * 任务审批列表
	 */
	@RequestMapping(value = "/approveList")
	public String approveList(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("defaultPageSize", APPROVE_DEFAULT_PAGE_SIZE);
		model.addAttribute("recordPageSize", RECORD_DEFAULT_PAGE_SIZE);

		// 生产基地
		List<Address> addressList = addressService.getAddressList();
		// 车型代码
		List<CarCode> carCodeList = carCodeService.getCarCodeList();
		model.addAttribute("addressList", addressList);
		model.addAttribute("carCodeList", carCodeList);

		return "task/ots/approve_list";
	}

	/**
	 * 列表数据
	 */
	@ResponseBody
	@RequestMapping(value = "/approveListData")
	public Map<String, Object> approveListData(HttpServletRequest request, Model model, String startCreateTime,
			String endCreateTime, String task_code, String parts_name, String parts_producer, String parts_producerCode,
			String startProTime, String endProTime, String matName, String mat_producer, String matNo, String v_code,
			String v_proAddr, String applicat_name, String applicat_depart, Long applicat_org) {

		Account applicat = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);

		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", APPROVE_DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		map.put("approveTask_ots", true);
		map.put("type", TaskTypeEnum.OTS.getState());

		// 超级管理员拥有所有权限
		if (applicat.getRole() == null || !Contants.SUPER_ROLE_CODE.equals(applicat.getRole().getCode())) {
			map.put("approveAccountId", applicat.getId());
		}

		if (StringUtils.isNotBlank(task_code)) {
			map.put("code", task_code);
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
		}

		List<Long> iIdList = infoService.selectIds(parts_name, parts_producer, parts_producerCode, startProTime,
				endProTime, matName, matNo, mat_producer, v_code, v_proAddr);
		if (iIdList.size() > 0) {
			map.put("iIdList", iIdList);
		}

		// 申请人信息
		List<Long> applicatIdList = accountService.selectIds(applicat_name, applicat_depart, applicat_org);
		if (applicatIdList.size() > 0) {
			map.put("applicatIdList", applicatIdList);
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

			if (task.getState() == StandardTaskEnum.APPLYING.getState()) {
				if (task.getInfoApply() == 1) { // 申请修改信息
					approveType = 1;
					ApplyRecord applyRecord = applyRecordService.getRecordByTaskId(task.getId(), 1);

					if (applyRecord != null) {
						if (applyRecord.getpId() != null) {
							Parts newParts = partsService.selectOne(applyRecord.getpId());
							model.addAttribute("newParts", newParts);
						}

						if (applyRecord.getvId() != null) {
							Vehicle newVehicle = vehicleService.selectOne(applyRecord.getvId());
							model.addAttribute("newVehicle", newVehicle);
						}

						if (applyRecord.getmId() != null) {
							Material newMaterial = materialService.selectOne(applyRecord.getmId());
							model.addAttribute("newMaterial", newMaterial);
						}
					}

				} else if (task.getResultApply() == 1) { // 申请修改试验结果
					approveType = 2;

					/** --------- 原结果 ----------- */
					// 零件-性能结果（只取最后一次实验）
					List<PfResult> pPfResult_old = pfResultService.getLastResult(1, task.gettId());

					// 零件-图谱结果（只取最后一次实验）
					List<AtlasResult> pAtlasResult_old = atlasResultService.getLastResult(1, task.gettId());

					model.addAttribute("pPfResult_old", pPfResult_old);
					model.addAttribute("pAtlasResult_old", pAtlasResult_old);

					// 材料-性能结果（只取最后一次实验结果）
					List<PfResult> mPfResult_old = pfResultService.getLastResult(2, task.gettId());

					// 材料-图谱结果（只取最后一次实验）
					List<AtlasResult> mAtlasResult_old = atlasResultService.getLastResult(2, task.gettId());

					// 试验结论
					List<LabConclusion> conclusionList_old = labConclusionService.selectByTaskId(task.gettId());

					/** --------- 修改之后的结果 ----------- */
					// 零件-性能结果（只取最后一次实验）
					List<PfResult> pPfResult_new = pfResultService.getLastResult(1, task.getId());

					// 零件-图谱结果（只取最后一次实验）
					List<AtlasResult> pAtlasResult_new = atlasResultService.getLastResult(1, task.getId());

					model.addAttribute("pAtlasResult_new", pAtlasResult_new);
					model.addAttribute("pPfResult_new", pPfResult_new);

					// 材料-性能结果（只取最后一次实验结果）
					List<PfResult> mPfResult_new = pfResultService.getLastResult(2, task.getId());

					// 材料-图谱结果（只取最后一次实验）
					List<AtlasResult> mAtlasResult_new = atlasResultService.getLastResult(2, task.getId());

					// 试验结论
					List<LabConclusion> conclusionList_new = labConclusionService.selectByTaskId(task.getId());

					if (conclusionList_old != null && conclusionList_old.size() > 0) {
						for (LabConclusion conclusion : conclusionList_old) {
							if (conclusion.getType().intValue() == 1) {
								model.addAttribute("partsAtlConclusion_old", conclusion);
							} else if (conclusion.getType().intValue() == 2) {
								model.addAttribute("matAtlConclusion_old", conclusion);
							} else if (conclusion.getType().intValue() == 3) {
								model.addAttribute("partsPatConclusion_old", conclusion);
							} else {
								model.addAttribute("matPatConclusion_old", conclusion);
							}
						}
					}

					if (conclusionList_new != null && conclusionList_new.size() > 0) {
						for (LabConclusion conclusion : conclusionList_new) {
							if (conclusion.getType().intValue() == 1) {
								model.addAttribute("partsAtlConclusion_new", conclusion);
							} else if (conclusion.getType().intValue() == 2) {
								model.addAttribute("matAtlConclusion_new", conclusion);
							} else if (conclusion.getType().intValue() == 3) {
								model.addAttribute("partsPatConclusion_new", conclusion);
							} else {
								model.addAttribute("matPatConclusion_new", conclusion);
							}
						}
					}

					model.addAttribute("mPfResult_old", mPfResult_old);
					model.addAttribute("mAtlasResult_old", mAtlasResult_old);
					model.addAttribute("mPfResult_new", mPfResult_new);
					model.addAttribute("mAtlasResult_new", mAtlasResult_new);
				}
			}

			model.addAttribute("approveType", approveType);
			model.addAttribute("facadeBean", task);
		}

		model.addAttribute("resUrl", resUrl);

		if (approveType == 3) {
			List<LabReq> labReqList = labReqService.getLabReqListByTaskId(id);
			model.addAttribute("labReqList", labReqList);
		}

		if (approveType == 1) {
			return "task/ots/approve_info_detail";
		} else {
			return "task/ots/approve_detail";
		}
	}

	/**
	 * 审批结果
	 * 
	 * @param account    操作用户
	 * @param id         任务ID
	 * @param result     结果：1-通过，2-不通过
	 * @param remark     备注
	 * @param catagory   分类：1-零件图谱，2-材料图谱，3-零件型式，4-材料型式，5-全部（试验），6-信息修改申请，7-试验结果修改申请
	 * @param partsAtlId
	 * @param matAtlId
	 * @param partsPatId
	 * @param matPatId
	 */
	@ResponseBody
	@RequestMapping(value = "/approve")
	public AjaxVO approve(HttpServletRequest request, Model model, Long id, int result, int catagory, String remark,
			Long partsAtlId, Long matAtlId) {
		AjaxVO vo = new AjaxVO();

		try {
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			infoService.approve(account, id, result, remark, catagory, partsAtlId, matAtlId, null, null);
		} catch (Exception ex) {
			logger.error("OTS任务审批失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}

	/**
	 * 批量审批结果
	 * 
	 * @param account 操作用户
	 * @param ids     任务ID
	 * @param result  结果：1-通过，2-不通过
	 * @param remark  备注
	 */
	@ResponseBody
	@RequestMapping(value = "/batchApprove")
	public AjaxVO batchApprove(HttpServletRequest request, Model model, @RequestParam(value = "ids[]") Long[] ids,
			int result, String remark) {
		AjaxVO vo = new AjaxVO();

		try {
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			if (ids != null && ids.length > 0) {
				for (Long id : ids) {
					Task task = taskService.selectOne(id);
					int catagory = 5;

					if (task.getInfoApply() == 1) {
						catagory = 6;
					} else if (task.getResultApply() == 1) {
						catagory = 7;
					}
					infoService.approve(account, id, result, remark, catagory, null, null, null, null);
				}
			}
		} catch (Exception ex) {
			logger.error("OTS任务批量审批失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}

	/**
	 * 获取生产商列表（自动补全）
	 * 
	 * @param type: 1-零件 2-材料
	 */
	@ResponseBody
	@RequestMapping(value = "/getProducerList")
	public String getProducerList(HttpServletRequest request, Model model, int type) throws Exception {
		String qName = request.getParameter("q"); // 参数必须为q

		List<String> orgNameList = new ArrayList<String>();
		if (type == 1) {
			orgNameList = partsService.getProduceList(qName);
		} else {
			orgNameList = materialService.getProduceList(qName);
		}

		String jsonString = ""; // 多行数据使用\n进行换行
		for (int i = 0; i < orgNameList.size(); i++) {
			if (i != (orgNameList.size() - 1)) {
				jsonString += "{\'text\':\'" + orgNameList.get(i) + "\'}\n";
			} else {
				jsonString += "{\'text\':\'" + orgNameList.get(i) + "\'}";
			}
		}
		return jsonString;
	}

	/**
	 * 用户选择
	 * 
	 * @param model
	 * @param type
	 * @return
	 */
	@RequestMapping(value = "/userList")
	public String userList(HttpServletRequest httpServletRequest, Model model, String type) {
		model.addAttribute("defaultPageSize", REQUIRE_DEFAULT_PAGE_SIZE);
		model.addAttribute("type", type);

		List<Department> departmentList = departmentService.selectAllList(new PageMap(false));
		model.addAttribute("departmentList", departmentList);

		return "task/ots/account_list";
	}
}
