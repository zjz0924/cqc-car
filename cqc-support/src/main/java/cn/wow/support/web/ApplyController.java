package cn.wow.support.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import cn.wow.common.domain.Address;
import cn.wow.common.domain.ApplyRecord;
import cn.wow.common.domain.AtlasResult;
import cn.wow.common.domain.Attach;
import cn.wow.common.domain.CarCode;
import cn.wow.common.domain.ExamineRecord;
import cn.wow.common.domain.LabConclusion;
import cn.wow.common.domain.LabReq;
import cn.wow.common.domain.Material;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.Parts;
import cn.wow.common.domain.PfResult;
import cn.wow.common.domain.Task;
import cn.wow.common.domain.Vehicle;
import cn.wow.common.service.AccountService;
import cn.wow.common.service.AddressService;
import cn.wow.common.service.ApplyRecordService;
import cn.wow.common.service.AtlasResultService;
import cn.wow.common.service.AttachService;
import cn.wow.common.service.CarCodeService;
import cn.wow.common.service.InfoService;
import cn.wow.common.service.LabConclusionService;
import cn.wow.common.service.LabReqService;
import cn.wow.common.service.MaterialService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.PartsService;
import cn.wow.common.service.PfResultService;
import cn.wow.common.service.TaskService;
import cn.wow.common.service.VehicleService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.TaskTypeEnum;

/**
 * 申请管理
 * 
 * @author zhenjunzhuo 2017-11-05
 */
@Controller
@RequestMapping(value = "apply")
public class ApplyController extends AbstractController {

	Logger logger = LoggerFactory.getLogger(ApplyController.class);

	private final static String DEFAULT_PAGE_SIZE = "10";

	@Autowired
	private TaskService taskService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private VehicleService vehicleService;
	@Autowired
	private PartsService partsService;
	@Autowired
	private MaterialService materialService;
	@Autowired
	private InfoService infoService;
	@Autowired
	private AtlasResultService atlasResultService;
	@Autowired
	private PfResultService pfResultService;
	@Autowired
	private ApplyRecordService applyRecordService;
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
	private AttachService attachService;

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	// 原材料图片上传路径
	@Value("${info.material.url}")
	protected String materialUrl;

	// 图谱图片上传路径
	@Value("${result.atlas.url}")
	protected String atlasUrl;

	// 附件上传路径
	@Value("${result.attach.url}")
	protected String attachUrl;

	/**
	 * 任务列表
	 */
	@RequestMapping(value = "/taskList")
	public String taskList(HttpServletRequest request, HttpServletResponse response, Model model) {

		Menu menu = menuService.selectByAlias("updateApply");

		// 生产基地
		List<Address> addressList = addressService.getAddressList();
		// 车型代码
		List<CarCode> carCodeList = carCodeService.getCarCodeList();
		model.addAttribute("addressList", addressList);
		model.addAttribute("carCodeList", carCodeList);

		model.addAttribute("menuName", menu.getName());
		model.addAttribute("defaultPageSize", DEFAULT_PAGE_SIZE);
		return "apply/task_list";
	}

	/**
	 * 列表数据
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/taskListData")
	public Map<String, Object> taskListData(HttpServletRequest request, Model model, String startCreateTime,
			String endCreateTime, String startConfirmTime, String endConfirmTime, String task_code, String parts_name,
			String parts_producer, String parts_producerCode, String startProTime, String endProTime, String matName,
			String mat_producer, String matNo, String v_code, String v_proAddr, String applicat_name,
			String applicat_depart, Long applicat_org) {
		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);

		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");

		if (StringUtils.isNotBlank(task_code)) {
			map.put("code", task_code);
		}
		if (StringUtils.isNotBlank(startConfirmTime)) {
			map.put("startConfirmTime", startConfirmTime + " 00:00:00");
		}
		if (StringUtils.isNotBlank(endConfirmTime)) {
			map.put("endConfirmTime", endConfirmTime + " 23:59:59");
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
		}

		// 除了超级管理员， 流程上的用户都可以查看
		if (account.getRole() == null || !Contants.SUPER_ROLE_CODE.equals(account.getRole().getCode())) {
			// 流程上的用户
			map.put("applyTask", account.getId());

			// 分配到自己的实验室
			map.put("labId", account.getOrgId());
		}

		// 申请人信息
		List<Long> applicatIdList = accountService.selectIds(applicat_name, applicat_depart, applicat_org);
		if (applicatIdList.size() > 0) {
			map.put("applicatIdList", applicatIdList);
		}

		List<Long> iIdList = infoService.selectIds(parts_name, parts_producer, parts_producerCode, startProTime,
				endProTime, matName, matNo, mat_producer, v_code, v_proAddr);
		if (iIdList.size() > 0) {
			map.put("iIdList", iIdList);
		}

		map.put("accomplishTask", true);
		List<Task> dataList = taskService.selectAllList(map);

		// 分页
		Page<Task> pageList = (Page<Task>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	/**
	 * 信息详情
	 */
	@RequestMapping(value = "/infoDetail")
	public String infoDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id) {
		if (id != null) {
			Task task = taskService.selectOne(id);

			model.addAttribute("facadeBean", task);
		}

		// 生产基地
		List<Address> addressList = addressService.getAddressList();
		// 车型代码
		List<CarCode> carCodeList = carCodeService.getCarCodeList();

		model.addAttribute("addressList", addressList);
		model.addAttribute("carCodeList", carCodeList);
		model.addAttribute("resUrl", resUrl);
		return "apply/info_detail";
	}

	/**
	 * 实验结果详情
	 */
	@RequestMapping(value = "/labDetail")
	public String labDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id) {
		if (id != null) {
			Task task = taskService.selectOne(id);

			// 零部件-性能结果（只取最后一次实验）
			List<PfResult> pPfResult = pfResultService.getLastResult(1, id);

			// 原材料-性能结果（只取最后一次实验结果）
			List<PfResult> mPfResult = pfResultService.getLastResult(2, id);

			// 零部件-图谱结果（只取最后一次实验）
			List<AtlasResult> pAtlasResult = atlasResultService.getLastResult(1, id);
			// 后面加上的样品照片
			if (pAtlasResult != null && pAtlasResult.size() == 3) {
				AtlasResult tmp = pAtlasResult.get(0);
				AtlasResult ar = new AtlasResult(tmp.gettId(), 4, null, null, 1, tmp.getExpNo(), tmp.getCreateTime());
				pAtlasResult.add(ar);
			}

			// 原材料-图谱结果（只取最后一次实验）
			List<AtlasResult> mAtlasResult = atlasResultService.getLastResult(2, id);
			// 后面加上的样品照片
			if (mAtlasResult != null && mAtlasResult.size() == 3) {
				AtlasResult tmp = mAtlasResult.get(0);
				AtlasResult ar = new AtlasResult(tmp.gettId(), 4, null, null, 2, tmp.getExpNo(), tmp.getCreateTime());
				mAtlasResult.add(ar);
			}

			// 零部件-性能结果
			model.addAttribute("pPfResult", pPfResult);
			// 原材料-性能结果
			model.addAttribute("mPfResult", mPfResult);
			// 零部件-图谱结果
			model.addAttribute("pAtlasResult", pAtlasResult);
			// 原材料-图谱结果
			model.addAttribute("mAtlasResult", mAtlasResult);

			model.addAttribute("facadeBean", task);

			// 试验要求
			List<LabReq> labReqList = labReqService.getLabReqListByTaskId(id);
			model.addAttribute("labReqList", labReqList);

			// 试验结论
			List<LabConclusion> conclusionList = labConclusionService.selectByTaskId(task.getId());
			if (conclusionList != null && conclusionList.size() > 0) {
				for (LabConclusion conclusion : conclusionList) {
					if (conclusion.getType().intValue() == 1) {
						model.addAttribute("partsAtlConclusion", conclusion);
					} else if (conclusion.getType().intValue() == 2) {
						model.addAttribute("matAtlConclusion", conclusion);
					} else if (conclusion.getType().intValue() == 3) {
						model.addAttribute("partsPatConclusion", conclusion);
					} else {
						model.addAttribute("matPatConclusion", conclusion);
					}
				}
			}

			if (task.getType() == TaskTypeEnum.GS.getState()) {
				// 型式结果附件
				model.addAttribute("attach", attachService.getFileName(id));
			}

			if (task.getType() == TaskTypeEnum.PPAP.getState() || task.getType() == TaskTypeEnum.SOP.getState()) {
				// 对比结果
				Map<String, List<ExamineRecord>> compareResult = atlasResultService.assembleCompareResult(id);

				if (compareResult != null && !compareResult.isEmpty()) {

					List<ExamineRecord> pRecordList = compareResult.get("零部件");
					if (pRecordList != null && pRecordList.size() > 0) {
						for (ExamineRecord record : pRecordList) {
							if (record.getCatagory() == 1) {
								model.addAttribute("p_inf", record);
							} else if (record.getCatagory() == 2) {
								model.addAttribute("p_dt", record);
							} else if (record.getCatagory() == 3) {
								model.addAttribute("p_tg", record);
							} else if (record.getCatagory() == 4) {
								model.addAttribute("p_result", record);
							} else if (record.getCatagory() == 9) {
								model.addAttribute("p_temp", record);
							}
						}
					}

					List<ExamineRecord> mRecordList = compareResult.get("原材料");
					if (mRecordList != null && mRecordList.size() > 0) {
						for (ExamineRecord record : mRecordList) {
							if (record.getCatagory() == 5) {
								model.addAttribute("m_inf", record);
							} else if (record.getCatagory() == 6) {
								model.addAttribute("m_dt", record);
							} else if (record.getCatagory() == 7) {
								model.addAttribute("m_tg", record);
							} else if (record.getCatagory() == 8) {
								model.addAttribute("m_result", record);
							} else if (record.getCatagory() == 10) {
								model.addAttribute("m_temp", record);
							}
						}
					}
				}
			}
		}

		model.addAttribute("superRoleCole", Contants.SUPER_ROLE_CODE);
		model.addAttribute("resUrl", resUrl);
		return "apply/lab_detail";
	}

	/**
	 * 终止申请列表
	 */
	@RequestMapping(value = "/applyList")
	public String applyList(HttpServletRequest request, HttpServletResponse response, Model model) {

		Menu menu = menuService.selectByAlias("endApply");

		model.addAttribute("menuName", menu.getName());
		model.addAttribute("defaultPageSize", DEFAULT_PAGE_SIZE);
		return "apply/apply_list";
	}

	/**
	 * 列表数据
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/applyListData")
	public Map<String, Object> applyListData(HttpServletRequest request, Model model, String startCreateTime,
			String endCreateTime, String code, String type) {
		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);

		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "r.create_time desc");
		map.put("state", 0);

		// 除了超级管理员，其它用户只能查看自己录入的申请记录
		if (account.getRole() == null || !Contants.SUPER_ROLE_CODE.equals(account.getRole().getCode())) {
			map.put("applicatId", account.getId());
		}

		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
		}
		if (StringUtils.isNotBlank(code)) {
			map.put("code", code);
		}
		if (StringUtils.isNotBlank(type)) {
			map.put("type", type);
		}

		List<ApplyRecord> dataList = applyRecordService.selectAllList(map);

		// 分页
		Page<ApplyRecord> pageList = (Page<ApplyRecord>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	@RequestMapping(value = "/applyDetail")
	public String requireDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id) {
		if (id != null) {
			ApplyRecord applyRecord = applyRecordService.selectOne(id);
			Task task = applyRecord.getTask();

			if (applyRecord.getType() == 1) {
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
			} else {
				// 试验要求
				List<LabReq> labReqList = labReqService.getLabReqListByTaskId(task.getId());

				/** --------- 原结果 ----------- */
				// 零部件-性能结果（只取最后一次实验）
				List<PfResult> pPfResult_old = pfResultService.getLastResult(1, task.gettId());

				// 原材料-性能结果（只取最后一次实验结果）
				List<PfResult> mPfResult_old = pfResultService.getLastResult(2, task.gettId());

				// 零部件-图谱结果（只取最后一次实验）
				List<AtlasResult> pAtlasResult_old = atlasResultService.getLastResult(1, task.gettId());

				// 原材料-图谱结果（只取最后一次实验）
				List<AtlasResult> mAtlasResult_old = atlasResultService.getLastResult(2, task.gettId());

				// 对比结果
				Map<String, List<ExamineRecord>> compareResult_old = atlasResultService
						.assembleCompareResult(task.gettId());

				// 试验结论
				List<LabConclusion> conclusionList_old = labConclusionService.selectByTaskId(task.gettId());

				/** --------- 修改之后的结果 ----------- */
				// 零部件-性能结果（只取最后一次实验）
				List<PfResult> pPfResult_new = pfResultService.getLastResult(1, task.getId());

				// 原材料-性能结果（只取最后一次实验结果）
				List<PfResult> mPfResult_new = pfResultService.getLastResult(2, task.getId());

				// 零部件-图谱结果（只取最后一次实验）
				List<AtlasResult> pAtlasResult_new = atlasResultService.getLastResult(1, task.getId());

				// 原材料-图谱结果（只取最后一次实验）
				List<AtlasResult> mAtlasResult_new = atlasResultService.getLastResult(2, task.getId());

				// 对比结果
				Map<String, List<ExamineRecord>> compareResult_new = atlasResultService
						.assembleCompareResult(task.getId());

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

				model.addAttribute("pPfResult_old", pPfResult_old);
				model.addAttribute("mPfResult_old", mPfResult_old);
				model.addAttribute("pAtlasResult_old", pAtlasResult_old);
				model.addAttribute("mAtlasResult_old", mAtlasResult_old);
				model.addAttribute("pPfResult_new", pPfResult_new);
				model.addAttribute("mPfResult_new", mPfResult_new);
				model.addAttribute("pAtlasResult_new", pAtlasResult_new);
				model.addAttribute("mAtlasResult_new", mAtlasResult_new);
				model.addAttribute("compareResult_old", compareResult_old);
				model.addAttribute("compareResult_new", compareResult_new);
				model.addAttribute("labReqList", labReqList);

				// 型式结果附件
				model.addAttribute("attach", attachService.getFileName(id));
			}

			// 试验结论
			List<LabConclusion> conclusionList = labConclusionService.selectByTaskId(task.getId());
			if (conclusionList != null && conclusionList.size() > 0) {
				for (LabConclusion conclusion : conclusionList) {
					if (conclusion.getType().intValue() == 1) {
						model.addAttribute("partsAtlConclusion", conclusion);
					} else if (conclusion.getType().intValue() == 2) {
						model.addAttribute("matAtlConclusion", conclusion);
					} else if (conclusion.getType().intValue() == 3) {
						model.addAttribute("partsPatConclusion", conclusion);
					} else {
						model.addAttribute("matPatConclusion", conclusion);
					}
				}
			}

			model.addAttribute("applyRecord", applyRecord);
			model.addAttribute("facadeBean", task);
		}

		model.addAttribute("resUrl", resUrl);
		return "apply/apply_detail";
	}

	/**
	 * 中止申请
	 * 
	 * @param id     申请记录ID
	 * @param remark 备注
	 */
	@ResponseBody
	@RequestMapping(value = "/end")
	public AjaxVO end(HttpServletRequest request, Model model, Long id, String remark) {
		AjaxVO vo = new AjaxVO();

		try {
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			applyRecordService.end(account, id, remark);
		} catch (Exception ex) {
			logger.error("中止申请修改失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;

	}

	/**
	 * 信息修改申请保存
	 */
	@ResponseBody
	@RequestMapping(value = "/applyInfoSave")
	public AjaxVO applyInfoSave(HttpServletRequest request, Model model, String v_code, String v_proTime,
			String v_proAddr, String v_remark, String p_code, String p_name, String p_proTime, String p_place,
			String p_proNo, Integer p_num, String p_producer, String p_producerCode, String p_remark, String m_matName,
			String m_matColor, String m_proNo, String m_matNo, String m_remark, Integer m_num, String m_producer,
			Long t_id) {

		AjaxVO vo = new AjaxVO();

		try {
			Date date = new Date();
			Task task = taskService.selectOne(t_id);

			// 整车信息
			Vehicle vehicle = null;
			if (isUpdateVehicleInfo(v_code, v_proTime, v_proAddr, v_remark)) {
				vehicle = vehicleService.selectOne(task.getInfo().getvId());
				assembleVehicleInfo(vehicle, v_code, v_proTime, v_proAddr, v_remark, date);

				boolean isExist = vehicleService
						.isExist(task.getInfo().getvId(), vehicle.getCode(), vehicle.getProTime(), vehicle.getProAddr())
						.getFlag();
				if (isExist) {
					vo.setSuccess(false);
					vo.setMsg("整车信息已存在");
					return vo;
				}
			}

			// 零部件信息
			Parts parts = null;
			if (partsService.isUpdatePartsInfo(parts, p_code, p_name, p_proTime, p_place, p_proNo, p_remark, p_num,
					p_producer, p_producerCode)) {
				parts = partsService.selectOne(task.getInfo().getpId());
				assemblePartsInfo(parts, p_code, p_name, p_proTime, p_place, p_proNo, p_producer, p_remark, date, p_num,
						p_producerCode);

				boolean isExist = partsService.isExist(task.getInfo().getpId(), parts.getName(), parts.getProTime(),
						p_producer, p_producerCode, p_code, p_proNo, p_num, p_place).getFlag();
				if (isExist) {
					vo.setSuccess(false);
					vo.setMsg("零部件信息已存在");
					return vo;
				}
			} else {
				parts = null;
			}

			// 原材料信息
			Material material = null;
			if (isUpdateMetailInfo(m_matName, m_matColor, m_proNo, m_producer, m_matNo, m_remark, m_num)) {
				material = materialService.selectOne(task.getInfo().getmId());
				assembleMaterialInfo(material, m_matName, m_matColor, m_proNo, m_producer, m_matNo, m_remark, date,
						m_num);
			}

			if (vehicle == null && parts == null && material == null) {
				vo.setSuccess(false);
				vo.setMsg("请输入要修改的信息");
				return vo;
			}

			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			infoService.applyInfo(account, task, vehicle, parts, material);
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("修改申请失败", ex);

			vo.setSuccess(false);
			vo.setMsg("保存失败，系统异常");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("保存成功");
		return vo;
	}

	/**
	 * 试验结果修改申请保存
	 * 
	 * @param taskId   任务ID
	 * @param p_tgLab  零部件热重分析描述
	 * @param p_infLab 零部件红外光分析描述
	 * @param p_dtLab  零部件差热扫描描述
	 * @param m_tgLab  原材料热重分析描述
	 * @param m_infLab 原材料红外光分析描述
	 * @param m_dtLab  原材料差热扫描描述
	 */
	@ResponseBody
	@RequestMapping(value = "/labInfoSave")
	public AjaxVO labInfoSave(HttpServletRequest request, Model model, Long taskId, String p_tgLab, String p_infLab,
			String p_dtLab, String m_tgLab, String m_infLab, String m_dtLab, String m_tempLab, String p_tempLab,
			@RequestParam(value = "p_tgLab_pic", required = false) MultipartFile p_tgfile,
			@RequestParam(value = "p_infLab_pic", required = false) MultipartFile p_infile,
			@RequestParam(value = "p_dtLab_pic", required = false) MultipartFile p_dtfile,
			@RequestParam(value = "p_tempLab_pic", required = false) MultipartFile p_tempfile,
			@RequestParam(value = "m_tempLab_pic", required = false) MultipartFile m_tempfile,
			@RequestParam(value = "m_tgLab_pic", required = false) MultipartFile m_tgfile,
			@RequestParam(value = "m_infLab_pic", required = false) MultipartFile m_infile,
			@RequestParam(value = "m_dtLab_pic", required = false) MultipartFile m_dtfile, String result, Integer p_inf,
			String p_inf_remark, Integer p_dt, String p_dt_remark, Integer p_tg, String p_tg_remark, Integer p_result,
			String p_result_remark, Integer m_inf, String m_inf_remark, Integer m_dt, String m_dt_remark, Integer m_tg,
			String m_tg_remark, Integer m_result, String m_result_remark, Integer p_temp, String p_temp_remark,
			Integer m_temp, String m_temp_remark, String conclusionResult,
			@RequestParam(value = "partsResultAttachFile", required = false) MultipartFile partsResultAttachFile,
			@RequestParam(value = "materialResultAttachFile", required = false) MultipartFile materialResultAttachFile) {

		AjaxVO vo = new AjaxVO();
		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
		Date date = new Date();

		try {
			// 型式结果
			ObjectMapper mapper = new ObjectMapper();
			List<PfResult> pfResultList = mapper.readValue(result, new TypeReference<List<PfResult>>() {
			});

			// 附件
			Attach attach = new Attach();
			attach.setTaskId(taskId);

			String fileName = null;
			// 零件型式附件
			if (partsResultAttachFile != null && !partsResultAttachFile.isEmpty()) {
				fileName = uploadImg(partsResultAttachFile, attachUrl + taskId + "/parts/", false);
				attach.setPartsFile(fileName);
			}

			// 材料型式附件
			if (materialResultAttachFile != null && !materialResultAttachFile.isEmpty()) {
				fileName = uploadImg(materialResultAttachFile, attachUrl + taskId + "/material/", false);
				attach.setMaterialFile(fileName);
			}

			// 试验结论
			List<LabConclusion> conclusionDataList = mapper.readValue(conclusionResult,
					new TypeReference<List<LabConclusion>>() {
					});

			// 组装图谱信息
			List<AtlasResult> atlResultList = assembleAtlasInfo(taskId, p_tgLab, p_infLab, p_dtLab, m_tgLab, m_infLab,
					m_dtLab, p_tgfile, p_infile, p_dtfile, m_tgfile, m_infile, m_dtfile, p_tempfile, m_tempfile,
					m_tempLab, p_tempLab);

			// 对比结果
			List<ExamineRecord> compareList = new ArrayList<ExamineRecord>();
			if (p_inf != null) {
				ExamineRecord record1 = new ExamineRecord(taskId, account.getId(), p_inf, p_inf_remark, 4, 1, date,
						TaskTypeEnum.PPAP.getState());
				ExamineRecord record2 = new ExamineRecord(taskId, account.getId(), p_dt, p_dt_remark, 4, 2, date,
						TaskTypeEnum.PPAP.getState());
				ExamineRecord record3 = new ExamineRecord(taskId, account.getId(), p_tg, p_tg_remark, 4, 3, date,
						TaskTypeEnum.PPAP.getState());
				ExamineRecord record4 = new ExamineRecord(taskId, account.getId(), p_result, p_result_remark, 4, 4,
						date, TaskTypeEnum.PPAP.getState());
				ExamineRecord record9 = new ExamineRecord(taskId, account.getId(), p_temp, p_temp_remark, 4, 9, date,
						TaskTypeEnum.PPAP.getState());

				compareList.add(record1);
				compareList.add(record2);
				compareList.add(record3);
				compareList.add(record4);
				compareList.add(record9);
			}

			if (m_inf != null) {
				ExamineRecord record5 = new ExamineRecord(taskId, account.getId(), m_inf, m_inf_remark, 4, 5, date,
						TaskTypeEnum.PPAP.getState());
				ExamineRecord record6 = new ExamineRecord(taskId, account.getId(), m_dt, m_dt_remark, 4, 6, date,
						TaskTypeEnum.PPAP.getState());
				ExamineRecord record7 = new ExamineRecord(taskId, account.getId(), m_tg, m_tg_remark, 4, 7, date,
						TaskTypeEnum.PPAP.getState());
				ExamineRecord record8 = new ExamineRecord(taskId, account.getId(), m_result, m_result_remark, 4, 8,
						date, TaskTypeEnum.PPAP.getState());
				ExamineRecord record10 = new ExamineRecord(taskId, account.getId(), m_temp, m_temp_remark, 4, 10, date,
						TaskTypeEnum.PPAP.getState());

				compareList.add(record5);
				compareList.add(record6);
				compareList.add(record7);
				compareList.add(record8);
				compareList.add(record10);
			}

			// 是否合格
			int is_pass = 1;
			if ((p_result != null && p_result == 2) || (m_result != null && m_result == 2)) {
				is_pass = 2;
			}

			infoService.applyResult(account, taskId, pfResultList, atlResultList, compareList, conclusionDataList,
					is_pass, attach);

		} catch (Exception ex) {
			logger.error("试验结果修改申请保存失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("保存成功");
		return vo;
	}

	/**
	 * 是否更新整车信息
	 */
	boolean isUpdateVehicleInfo(String v_code, String v_proTime, String v_proAddr, String v_remark) {
		if (StringUtils.isBlank(v_code) && StringUtils.isBlank(v_proTime) && StringUtils.isBlank(v_proAddr)
				&& StringUtils.isBlank(v_remark)) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 是否更新原材料信息
	 * 
	 * @return
	 */
	boolean isUpdateMetailInfo(String m_matName, String m_matColor, String m_proNo, String m_producer, String m_matNo,
			String m_remark, Integer m_num) {
		if (StringUtils.isBlank(m_matName) && StringUtils.isBlank(m_matColor) && StringUtils.isBlank(m_proNo)
				&& StringUtils.isBlank(m_matNo) && StringUtils.isBlank(m_matName) && StringUtils.isBlank(m_remark)
				&& StringUtils.isBlank(m_producer) && m_num == null) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 组装整车信息
	 */
	void assembleVehicleInfo(Vehicle vehicle, String v_code, String v_proTime, String v_proAddr, String v_remark,
			Date date) {
		if (StringUtils.isNotBlank(v_code)) {
			vehicle.setCode(v_code);
		}

		if (StringUtils.isNotBlank(v_proTime)) {
			try {
				vehicle.setProTime(sdf.parse(v_proTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}

		if (StringUtils.isNotBlank(v_proAddr)) {
			vehicle.setProAddr(v_proAddr);
		}

		if (StringUtils.isNotBlank(v_remark)) {
			vehicle.setRemark(v_remark);
		}

		vehicle.setCreateTime(date);
		vehicle.setId(null);
		vehicle.setState(0);
	}

	/**
	 * 组装零部件信息
	 */
	void assemblePartsInfo(Parts parts, String p_code, String p_name, String p_proTime, String p_place, String p_proNo,
			String p_producer, String p_remark, Date date, int p_num, String p_producerCode) {

		if (StringUtils.isNotBlank(p_code)) {
			parts.setCode(p_code);
		}

		if (StringUtils.isNotBlank(p_name)) {
			parts.setName(p_name);
		}

		if (StringUtils.isNotBlank(p_proTime)) {
			try {
				parts.setProTime(sdf.parse(p_proTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}

		if (StringUtils.isNotBlank(p_place)) {
			parts.setPlace(p_place);
		}

		if (StringUtils.isNotBlank(p_proNo)) {
			parts.setProNo(p_proNo);
		}

		if (StringUtils.isNotBlank(p_producer)) {
			parts.setProducer(p_producer);
		}

		if (StringUtils.isNotBlank(p_producerCode)) {
			parts.setProducerCode(p_producerCode);
		}

		if (StringUtils.isNotBlank(p_remark)) {
			parts.setRemark(p_remark);
		}

		parts.setNum(p_num);
		parts.setCreateTime(date);
		parts.setId(null);
		parts.setState(0);
	}

	/**
	 * 组装原材料信息
	 */
	void assembleMaterialInfo(Material material, String m_matName, String m_matColor, String m_proNo, String m_producer,
			String m_matNo, String m_remark, Date date, int m_num) throws Exception {

		if (StringUtils.isNotBlank(m_matName)) {
			material.setMatName(m_matName);
		}

		if (StringUtils.isNotBlank(m_matColor)) {
			material.setMatColor(m_matColor);
		}

		if (StringUtils.isNotBlank(m_proNo)) {
			material.setProNo(m_proNo);
		}

		if (StringUtils.isNotBlank(m_producer)) {
			material.setProducer(m_producer);
		}

		if (StringUtils.isNotBlank(m_matNo)) {
			material.setMatNo(m_matNo);
		}

		if (StringUtils.isNotBlank(m_remark)) {
			material.setRemark(m_remark);
		}

		material.setNum(m_num);
		material.setId(null);
		material.setCreateTime(date);
		material.setState(0);
	}

	/**
	 * 组装图谱信息
	 */
	List<AtlasResult> assembleAtlasInfo(Long taskId, String p_tgLab, String p_infLab, String p_dtLab, String m_tgLab,
			String m_infLab, String m_dtLab,
			@RequestParam(value = "p_tgLab_pic", required = false) MultipartFile p_tgfile,
			@RequestParam(value = "p_infLab_pic", required = false) MultipartFile p_infile,
			@RequestParam(value = "p_dtLab_pic", required = false) MultipartFile p_dtfile,
			@RequestParam(value = "m_tgLab_pic", required = false) MultipartFile m_tgfile,
			@RequestParam(value = "m_infLab_pic", required = false) MultipartFile m_infile,
			@RequestParam(value = "m_dtLab_pic", required = false) MultipartFile m_dtfile,
			@RequestParam(value = "p_tempLab_pic", required = false) MultipartFile p_tempfile,
			@RequestParam(value = "m_tempLab_pic", required = false) MultipartFile m_tempfile, String m_tempLab,
			String p_tempLab) throws Exception {

		List<AtlasResult> dataList = new ArrayList<AtlasResult>();
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String dateStr = sdf.format(date);

		// 零部件-图谱结果（只取最后一次实验）
		Map<String, Object> pAtMap = new HashMap<String, Object>();
		pAtMap.put("tId", taskId);
		pAtMap.put("expNo", atlasResultService.getExpNoByCatagory(taskId, 1));
		pAtMap.put("catagory", 1);
		List<AtlasResult> pAtlasResult = atlasResultService.selectAllList(pAtMap);
		// 后面加上的样品照片
		if (pAtlasResult != null && pAtlasResult.size() == 3) {
			AtlasResult tmp = pAtlasResult.get(0);
			AtlasResult ar = new AtlasResult(tmp.gettId(), 4, null, null, 1, tmp.getExpNo(), tmp.getCreateTime());
			pAtlasResult.add(ar);
		}

		if (pAtlasResult != null && pAtlasResult.size() > 0) {
			for (AtlasResult at : pAtlasResult) {
				if (at.getType() == 1) { // 红外光分析
					if (StringUtils.isNotBlank(p_infLab)) {
						at.setRemark(p_infLab);
					}
					if (p_infile != null && !p_infile.isEmpty()) {
						String pic = uploadImg(p_infile, atlasUrl + taskId + "/apply/parts/inf/" + dateStr + "/",
								false);
						at.setPic(pic);
					}
				} else if (at.getType() == 2) { // 差热分析
					if (StringUtils.isNotBlank(p_dtLab)) {
						at.setRemark(p_dtLab);
					}

					if (p_dtfile != null && !p_dtfile.isEmpty()) {
						String pic = uploadImg(p_dtfile, atlasUrl + taskId + "/apply/parts/dt/" + dateStr + "/", false);
						at.setPic(pic);
					}
				} else if (at.getType() == 3) { // 热重分析
					if (StringUtils.isNotBlank(p_tgLab)) {
						at.setRemark(p_tgLab);
					}

					if (p_tgfile != null && !p_tgfile.isEmpty()) {
						String pic = uploadImg(p_tgfile, atlasUrl + taskId + "/apply/parts/tg/" + dateStr + "/", false);
						at.setPic(pic);
					}
				} else {
					if (StringUtils.isNotBlank(p_tempLab)) {
						at.setRemark(p_tempLab);
					}

					if (p_tempfile != null && !p_tempfile.isEmpty()) {
						String pic = uploadImg(p_tempfile, atlasUrl + taskId + "/apply/parts/temp/" + dateStr + "/",
								false);
						at.setPic(pic);
					}
				}
			}
		} else {
			// 红外光分析
			if (p_infile != null && !p_infile.isEmpty()) {
				String pic = uploadImg(p_infile, atlasUrl + taskId + "/apply/parts/inf/" + dateStr + "/", false);
				AtlasResult at = new AtlasResult(taskId, 1, pic, p_infLab, 1, 1, date);

				dataList.add(at);
			}

			// 差热分析
			if (p_dtfile != null && !p_dtfile.isEmpty()) {
				String pic = uploadImg(p_dtfile, atlasUrl + taskId + "/apply/parts/dt/" + dateStr + "/", false);
				AtlasResult at = new AtlasResult(taskId, 2, pic, p_dtLab, 1, 1, date);

				dataList.add(at);
			}

			// 热重分析
			if (p_tgfile != null && !p_tgfile.isEmpty()) {
				String pic = uploadImg(p_tgfile, atlasUrl + taskId + "/apply/parts/tg/" + dateStr + "/", false);
				AtlasResult at = new AtlasResult(taskId, 3, pic, p_tgLab, 1, 1, date);

				dataList.add(at);
			}

			// 样品照片
			if (p_tempfile != null && !p_tempfile.isEmpty()) {
				String pic = uploadImg(p_tempfile, atlasUrl + taskId + "/apply/parts/temp/" + dateStr + "/", false);
				AtlasResult at = new AtlasResult(taskId, 4, pic, p_tempLab, 1, 1, date);

				dataList.add(at);
			}
		}

		// 原材料-图谱结果（只取最后一次实验）
		Map<String, Object> mAtMap = new HashMap<String, Object>();
		mAtMap.put("tId", taskId);
		mAtMap.put("catagory", 2);
		mAtMap.put("expNo", atlasResultService.getExpNoByCatagory(taskId, 2));
		List<AtlasResult> mAtlasResult = atlasResultService.selectAllList(mAtMap);
		// 后面加上的样品照片
		if (mAtlasResult != null && mAtlasResult.size() == 3) {
			AtlasResult tmp = mAtlasResult.get(0);
			AtlasResult ar = new AtlasResult(tmp.gettId(), 4, null, null, 2, tmp.getExpNo(), tmp.getCreateTime());
			mAtlasResult.add(ar);
		}

		if (mAtlasResult != null && mAtlasResult.size() > 0) {
			for (AtlasResult at : mAtlasResult) {
				if (at.getType() == 1) { // 红外光分析
					if (StringUtils.isNotBlank(m_infLab)) {
						at.setRemark(m_infLab);
					}

					if (m_infile != null && !m_infile.isEmpty()) {
						String pic = uploadImg(m_infile, atlasUrl + taskId + "/apply/material/inf/" + dateStr + "/",
								false);
						at.setPic(pic);
					}
				} else if (at.getType() == 2) { // 差热分析
					if (StringUtils.isNotBlank(m_dtLab)) {
						at.setRemark(m_dtLab);
					}

					if (m_dtfile != null && !m_dtfile.isEmpty()) {
						String pic = uploadImg(m_dtfile, atlasUrl + taskId + "/apply/material/dt/" + dateStr + "/",
								false);
						at.setPic(pic);
					}
				} else if (at.getType() == 3) { // 热重分析
					if (StringUtils.isNotBlank(m_tgLab)) {
						at.setRemark(m_tgLab);
					}

					if (m_tgfile != null && !m_tgfile.isEmpty()) {
						String pic = uploadImg(m_tgfile, atlasUrl + taskId + "/apply/material/tg/" + dateStr + "/",
								false);
						at.setPic(pic);
					}
				} else {
					if (StringUtils.isNotBlank(m_tempLab)) {
						at.setRemark(m_tempLab);
					}

					if (m_tempfile != null && !m_tempfile.isEmpty()) {
						String pic = uploadImg(m_tempfile, atlasUrl + taskId + "/apply/material/temp/" + dateStr + "/",
								false);
						at.setPic(pic);
					}
				}
			}
		} else {
			// 红外光分析
			if (m_infile != null && !m_infile.isEmpty()) {
				String pic = uploadImg(m_infile, atlasUrl + taskId + "/apply/material/inf/" + dateStr + "/", false);
				AtlasResult at = new AtlasResult(taskId, 1, pic, m_infLab, 2, 1, date);

				dataList.add(at);
			}

			// 差热分析
			if (m_dtfile != null && !m_dtfile.isEmpty()) {
				String pic = uploadImg(m_dtfile, atlasUrl + taskId + "/apply/material/dt/" + dateStr + "/", false);
				AtlasResult at = new AtlasResult(taskId, 2, pic, m_dtLab, 2, 1, date);

				dataList.add(at);
			}

			// 热重分析
			if (m_tgfile != null && !m_tgfile.isEmpty()) {
				String pic = uploadImg(m_tgfile, atlasUrl + taskId + "/apply/material/tg/" + dateStr + "/", false);
				AtlasResult at = new AtlasResult(taskId, 3, pic, m_tgLab, 2, 1, date);

				dataList.add(at);
			}

			// 样品照片
			if (m_tempfile != null && !m_tempfile.isEmpty()) {
				String pic = uploadImg(m_tempfile, atlasUrl + taskId + "/apply/material/temp/" + dateStr + "/", false);
				AtlasResult at = new AtlasResult(taskId, 4, pic, m_tempLab, 2, 1, date);

				dataList.add(at);
			}
		}

		if (pAtlasResult != null && pAtlasResult.size() > 0) {
			dataList.addAll(pAtlasResult);
		}

		if (mAtlasResult != null && mAtlasResult.size() > 0) {
			dataList.addAll(mAtlasResult);
		}
		return dataList;
	}

}
