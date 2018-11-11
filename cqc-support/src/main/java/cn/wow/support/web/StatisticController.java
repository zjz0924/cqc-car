package cn.wow.support.web;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.wow.common.domain.Address;
import cn.wow.common.domain.CarCode;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.ReasonOption;
import cn.wow.common.domain.ResultVO;
import cn.wow.common.domain.Task;
import cn.wow.common.service.AccountService;
import cn.wow.common.service.AddressService;
import cn.wow.common.service.CarCodeService;
import cn.wow.common.service.InfoService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.ReasonOptionService;
import cn.wow.common.service.ReasonService;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.ImportExcelUtil;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.SamplingTaskEnum;
import cn.wow.common.utils.taskState.StandardTaskEnum;
import cn.wow.common.utils.taskState.TaskTypeEnum;

/**
 * 统计控制器
 * 
 * @author zhenjunzhuo 2017-11-15
 */
@Controller
@RequestMapping(value = "statistic")
public class StatisticController {

	Logger logger = LoggerFactory.getLogger(StatisticController.class);

	@Autowired
	private MenuService menuService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private InfoService infoService;
	@Autowired
	private ReasonOptionService reasonOptionService;
	@Autowired
	private ReasonService reasonService;
	@Autowired
	private AccountService accountService;
	@Autowired
	private AddressService addressService;
	@Autowired
	private CarCodeService carCodeService;

	private ResultVO resultVO;

	private List<Task> taskResultList = new ArrayList<Task>();

	@RequestMapping(value = "/result")
	public String result(HttpServletRequest request, HttpServletResponse response, Model model) {
		Menu menu = menuService.selectByAlias("statistic");

		taskResultList.clear();

		// 生产基地
		List<Address> addressList = addressService.getAddressList();
		// 车型代码
		List<CarCode> carCodeList = carCodeService.getCarCodeList();
		model.addAttribute("addressList", addressList);
		model.addAttribute("carCodeList", carCodeList);

		// 抽样原因选项
		Map<String, Object> optionMap = new PageMap(false);
		optionMap.put("custom_order_sql", "type asc, name desc");
		List<ReasonOption> optionList = reasonOptionService.selectAllList(optionMap);

		model.addAttribute("menuName", menu.getName());
		model.addAttribute("optionList", optionList);
		return "statistic/result";
	}

	@ResponseBody
	@RequestMapping(value = "/getResult")
	public AjaxVO getResult(HttpServletRequest request, Model model, String startConfirmTime, String endConfirmTime,
			String reason, String source, String parts_name, String parts_producer, String parts_producerCode,
			String startProTime, String endProTime, String matName, String mat_producer, String matNo, String v_code,
			String v_proAddr, String applicat_name, String applicat_depart, Long applicat_org, String startCreateTime,
			String endCreateTime, String taskType) {

		taskResultList.clear();

		AjaxVO vo = new AjaxVO();

		Map<String, Object> qMap = new PageMap(false);

		if (StringUtils.isNotBlank(startConfirmTime)) {
			qMap.put("startConfirmTime", startConfirmTime + " 00:00:00");
		}
		if (StringUtils.isNotBlank(endConfirmTime)) {
			qMap.put("endConfirmTime", endConfirmTime + " 23:59:59");
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			qMap.put("startCreateTime", startCreateTime + " 00:00:00");
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			qMap.put("endCreateTime", endCreateTime + " 23:59:59");
		}
		if (StringUtils.isNotBlank(taskType)) {
			List<String> typeList = Arrays.asList(taskType.split(","));
			qMap.put("typeList", typeList);
		}

		List<Long> iIdList = infoService.selectIds(parts_name, parts_producer, parts_producerCode, startProTime,
				endProTime, matName, matNo, mat_producer, v_code, v_proAddr);
		if (iIdList.size() > 0) {
			qMap.put("iIdList", iIdList);
		}

		// 抽样原因
		List<Long> reasonIdList = reasonService.selectIds(null, source, reason);
		if (reasonIdList.size() > 0) {
			qMap.put("reasonIdList", reasonIdList);
		}

		// 申请人信息
		List<Long> applicatIdList = accountService.selectIds(applicat_name, applicat_depart, applicat_org);
		if (applicatIdList.size() > 0) {
			qMap.put("applicatIdList", applicatIdList);
		}

		List<Task> taskList = taskService.selectAllList(qMap);

		resultVO = new ResultVO();
		if (taskList != null && taskList.size() > 0) {
			resultVO.setTaskNum(taskList.size());

			for (Task task : taskList) {
				if (task.getResult() != null && task.getResult().intValue() == 1) {
					resultVO.setPassNum(resultVO.getPassNum() + 1);
				}
			}
			taskResultList.addAll(taskList);
		}

		vo.setData(resultVO);
		vo.setSuccess(true);
		return vo;
	}

	/**
	 * 导出结果
	 */
	@RequestMapping(value = "/export")
	public void export(HttpServletRequest request, HttpServletResponse response) {
		String filename = "统计结果";

		try {
			// 设置头
			ImportExcelUtil.setResponseHeader(response, filename + ".xlsx");

			Workbook wb = new SXSSFWorkbook(100); // 保持100条在内存中，其它保存到磁盘中
			// 工作簿
			Sheet sh = wb.createSheet("统计清单");
			sh.setColumnWidth(0, (short) 4000);
			sh.setColumnWidth(1, (short) 1000);
			sh.setColumnWidth(2, (short) 3000);
			sh.setColumnWidth(3, (short) 4000);
			sh.setColumnWidth(4, (short) 1000);
			sh.setColumnWidth(5, (short) 3000);
			sh.setColumnWidth(6, (short) 4000);

			// 合并单元格（参数说明：1：开始行 2：结束行 3：开始列 4：结束列）
			sh.addMergedRegion(new CellRangeAddress(1, 2, 0, 0));

			Map<String, CellStyle> styles = ImportExcelUtil.createStyles(wb);

			String[] titles = { "任务数量", "合格" };
			int r = 0;

			Row titleRow = sh.createRow(r++);
			titleRow.setHeight((short) 450);

			Cell cell = titleRow.createCell(0);
			cell.setCellStyle(styles.get("header"));
			cell.setCellValue(titles[0]);

			Cell cel2 = titleRow.createCell(3);
			cel2.setCellStyle(styles.get("header"));
			cel2.setCellValue(titles[1]);

			if (resultVO != null) {
				Row contentRow = sh.createRow(r);
				contentRow.setHeight((short) 400);

				Cell cell1 = contentRow.createCell(0);
				cell1.setCellStyle(styles.get("cell"));
				cell1.setCellValue(resultVO.getTaskNum());

				Cell cell2 = contentRow.createCell(2);
				cell2.setCellStyle(styles.get("cell"));
				cell2.setCellValue("数量");

				Cell cell3 = contentRow.createCell(3);
				cell3.setCellStyle(styles.get("cell"));
				cell3.setCellValue(resultVO.getPassNum());

				++r;
				Row contentRow2 = sh.createRow(r);
				contentRow2.setHeight((short) 400);

				Cell cell6 = contentRow2.createCell(2);
				cell6.setCellStyle(styles.get("cell"));
				cell6.setCellValue("比例");

				Cell cell7 = contentRow2.createCell(3);
				cell7.setCellStyle(styles.get("cell"));
				cell7.setCellValue((Math.round(resultVO.getPassNum() / resultVO.getTaskNum() * 10000) / 100.00) + "%");
			}

			OutputStream os = response.getOutputStream();
			wb.write(os);
			os.flush();
			os.close();

		} catch (Exception e) {
			logger.error("统计结果导出失败");

			e.printStackTrace();
		}
	}

	/**
	 * 导出任务列表
	 */
	@RequestMapping(value = "/exportTask")
	public void exportTask(HttpServletRequest request, HttpServletResponse response) {
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String filename = sdf1.format(new Date()) + "_统计任务清单";

		try {
			// 设置头
			ImportExcelUtil.setResponseHeader(response, filename + ".xlsx");

			Workbook wb = new SXSSFWorkbook(100); // 保持100条在内存中，其它保存到磁盘中
			// 工作簿
			Sheet sh = wb.createSheet("任务清单");
			sh.setColumnWidth(0, (short) 6000);
			sh.setColumnWidth(1, (short) 6000);
			sh.setColumnWidth(2, (short) 4000);
			sh.setColumnWidth(3, (short) 4000);
			sh.setColumnWidth(4, (short) 6000);
			sh.setColumnWidth(5, (short) 6000);
			sh.setColumnWidth(6, (short) 6000);
			sh.setColumnWidth(7, (short) 6000);
			sh.setColumnWidth(8, (short) 6000);
			sh.setColumnWidth(9, (short) 6000);
			sh.setColumnWidth(10, (short) 6000);
			sh.setColumnWidth(11, (short) 6000);

			Map<String, CellStyle> styles = ImportExcelUtil.createStyles(wb);

			String[] titles = { "任务号", "任务类型", "状态", "结果", "车型", "零件号", "零件名称", "生产商", "材料名称", "生产商", "录入用户", "录入时间",
					"完成时间", };
			int r = 0;

			Row titleRow = sh.createRow(0);
			titleRow.setHeight((short) 450);
			for (int k = 0; k < titles.length; k++) {
				Cell cell = titleRow.createCell(k);
				cell.setCellStyle(styles.get("header"));
				cell.setCellValue(titles[k]);
			}

			++r;
			for (int j = 0; j < taskResultList.size(); j++) {// 添加数据
				Row contentRow = sh.createRow(r);
				contentRow.setHeight((short) 400);
				Task task = taskResultList.get(j);

				Cell cell1 = contentRow.createCell(0);
				cell1.setCellStyle(styles.get("cell"));
				cell1.setCellValue(task.getCode());

				Cell cell2 = contentRow.createCell(1);
				cell2.setCellStyle(styles.get("cell"));
				String taskType = "";
				if (task.getType() == TaskTypeEnum.OTS.getState()) {
					taskType = "基准图谱建立";
				} else if (task.getType() == TaskTypeEnum.PPAP.getState()) {
					taskType = "图谱试验抽查-开发阶段";
				} else if (task.getType() == TaskTypeEnum.SOP.getState()) {
					taskType = "图谱试验抽查-量产阶段";
				} else {
					taskType = "第三方委托";
				}
				cell2.setCellValue(taskType);

				Cell cell3 = contentRow.createCell(2);
				cell3.setCellStyle(styles.get("cell"));
				String state = "";
				if (task.getType() == TaskTypeEnum.OTS.getState() || task.getType() == TaskTypeEnum.GS.getState()) {
					if (task.getState() == 1) {
						state = "审核中";
					} else if (task.getState() == 2) {
						state = "审核不通过";
					} else if (task.getState() == 3) {
						state = "试验中";
					} else if (task.getState() == 4) {
						state = "完成";
					} else if (task.getState() == 5) {
						state = "申请修改";
					} else {
						state = "申请不通过";
					}
				} else if (task.getType() == TaskTypeEnum.PPAP.getState()
						|| task.getType() == TaskTypeEnum.SOP.getState()) {
					if (task.getState() == 1) {
						state = "审批中";
					} else if (task.getState() == 2) {
						state = "审批不通过";
					} else if (task.getState() == 3) {
						state = "结果上传中";
					} else if (task.getState() == 4) {
						state = "结果比对中";
					} else if (task.getState() == 5) {
						state = "结果发送中";
					} else if (task.getState() == 6) {
						state = "结果接收中";
					} else if (task.getState() == 7) {
						state = "完成";
					} else if (task.getState() == 8) {
						state = "申请修改";
					} else if (task.getState() == 9) {
						state = "申请不通过";
					} else if (task.getState() == 10) {
						state = "等待是否二次抽样";
					} else {
						state = "中止任务";
					}
				}
				cell3.setCellValue(state);

				String result = "";
				Cell cell4 = contentRow.createCell(3);
				cell4.setCellStyle(styles.get("cell"));
				if (task.getResult() != null) {
					if (task.getResult().intValue() == 1) {
						result = "合格";
					} else if (task.getResult().intValue() == 0) {
						result = "不合格";
					}
				}
				cell4.setCellValue(result);

				Cell cell6 = contentRow.createCell(4);
				cell6.setCellStyle(styles.get("cell"));
				if (task.getType() != TaskTypeEnum.GS.getState()) {
					if (task.getInfo() != null && task.getInfo().getParts() != null) {
						cell6.setCellValue(task.getInfo().getParts().getCode());
					}
				}

				Cell cell7 = contentRow.createCell(5);
				cell7.setCellStyle(styles.get("cell"));
				if (task.getType() != TaskTypeEnum.GS.getState()) {
					if (task.getInfo() != null && task.getInfo().getParts() != null) {
						cell7.setCellValue(task.getInfo().getParts().getName());
					}
				}

				Cell cell8 = contentRow.createCell(6);
				cell8.setCellStyle(styles.get("cell"));
				if (task.getType() != TaskTypeEnum.GS.getState()) {
					if (task.getInfo() != null && task.getInfo().getParts() != null
							&& task.getInfo().getParts().getProducer() != null) {
						cell8.setCellValue(task.getInfo().getParts().getProducer());
					}
				}

				Cell cell9 = contentRow.createCell(7);
				cell9.setCellStyle(styles.get("cell"));
				if (task.getInfo() != null && task.getInfo().getMaterial() != null) {
					cell9.setCellValue(task.getInfo().getMaterial().getMatName());
				}

				Cell cell10 = contentRow.createCell(8);
				cell10.setCellStyle(styles.get("cell"));
				if (task.getInfo() != null && task.getInfo().getMaterial() != null
						&& task.getInfo().getMaterial().getProducer() != null) {
					cell10.setCellValue(task.getInfo().getMaterial().getProducer());
				}

				Cell cell11 = contentRow.createCell(9);
				cell11.setCellStyle(styles.get("cell"));
				if (task.getApplicat() != null) {
					cell11.setCellValue(task.getApplicat().getUserName());
				}

				Cell cell12 = contentRow.createCell(10);
				cell12.setCellStyle(styles.get("cell"));
				cell12.setCellValue(sdf.format(task.getCreateTime()));

				Cell cell13 = contentRow.createCell(11);
				cell13.setCellStyle(styles.get("cell"));
				if (task.getConfirmTime() != null) {
					cell13.setCellValue(sdf.format(task.getConfirmTime()));
				}

				r++;
			}

			OutputStream os = response.getOutputStream();
			wb.write(os);
			os.flush();
			os.close();
		} catch (Exception e) {
			logger.error("任务清单导出失败");

			e.printStackTrace();
		}
	}

}
