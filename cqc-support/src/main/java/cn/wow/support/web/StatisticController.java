package cn.wow.support.web;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import cn.wow.common.domain.Account;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.ResultVO;
import cn.wow.common.domain.Task;
import cn.wow.common.service.InfoService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.TaskInfoService;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.ImportExcelUtil;
import cn.wow.common.utils.operationlog.OperationType;
import cn.wow.common.utils.operationlog.ServiceType;
import cn.wow.common.utils.pagination.PageMap;
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
	private TaskInfoService taskInfoService;
	
	private ResultVO resultVO;
	
	@RequestMapping(value = "/result")
	public String result(HttpServletRequest request, HttpServletResponse response, Model model) {
		Menu menu = menuService.selectByAlias("statistic");
		
		model.addAttribute("menuName", menu.getName());
		return "statistic/result";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/getResult")
	public AjaxVO getResult(HttpServletRequest request, Model model, String startConfirmTime, String endConfirmTime, String v_code,
			String v_type, String p_code, String taskType, Long parts_org, Long lab_org, String applicant, String department, String reason,
			String provenance) {
		AjaxVO vo = new AjaxVO();

		Map<String, Object> qMap = new PageMap(false);
		
		if (StringUtils.isNotBlank(startConfirmTime)) {
			qMap.put("startConfirmTime", startConfirmTime  + " 00:00:00");
		}
		if (StringUtils.isNotBlank(endConfirmTime)) {
			qMap.put("endConfirmTime", endConfirmTime  + " 23:59:59");
		}
		if (StringUtils.isNotBlank(taskType)) {
			qMap.put("type", taskType);
		}
		if(lab_org != null) {
			qMap.put("labOrgId", lab_org);
		}
		
		List<Long> iIdList = new ArrayList<Long>();
		if (StringUtils.isNotBlank(v_code) || StringUtils.isNotBlank(v_type) || StringUtils.isNotBlank(p_code)
				|| parts_org != null) {
			
			Map<String, Object> iMap = new PageMap(false);
			iMap.put("state", 1);

			if (StringUtils.isNotBlank(v_code)) {
				iMap.put("v_code", v_code);
			}
			if (StringUtils.isNotBlank(v_type)) {
				iMap.put("v_type", v_type);
			}
			if (StringUtils.isNotBlank(p_code)) {
				iMap.put("p_code", p_code);
			}
			if (parts_org != null) {
				iMap.put("parts_org", parts_org);
			}
			iIdList = infoService.selectIdList(iMap);

			if (iIdList.size() < 1) {
				iIdList.add(-1l);
			}
		}

		if (iIdList.size() > 0) {
			qMap.put("iIdList", iIdList);
		}
		
		List<Long> taskInfoIdList = taskInfoService.getTaskIds(applicant, department, reason, provenance);
		if (taskInfoIdList != null && taskInfoIdList.size() > 0) {
			qMap.put("taskIdList", taskInfoIdList);
		}
		
		List<Task> taskList = taskService.selectAllList(qMap);
		
		resultVO = new ResultVO();
		if (taskList != null && taskList.size() > 0) {
			resultVO.setTaskNum(taskList.size());

			for (Task task : taskList) {
				if (task.getType() == TaskTypeEnum.PPAP.getState() || task.getType() == TaskTypeEnum.SOP.getState()) {
					if (task.getResult() != null) {
						if (task.getResult() == 1) {
							resultVO.setPassNum(resultVO.getPassNum() + 1);
						} else if (task.getResult() == 2) {
							resultVO.setOnceNum(resultVO.getOnceNum() + 1);
						}
					}
				}
			}
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

			// 合并单元格（参数说明：1：开始行 2：结束行  3：开始列 4：结束列）
			sh.addMergedRegion(new CellRangeAddress(1,2,0,0));

			Map<String, CellStyle> styles = ImportExcelUtil.createStyles(wb);

			String[] titles = { "任务数量", "合格", "一次不合格"};
			int r = 0;
			
			Row titleRow = sh.createRow(0);
			titleRow.setHeight((short) 450);
			
			Cell cell = titleRow.createCell(0);
			cell.setCellStyle(styles.get("header"));
			cell.setCellValue(titles[0]);
			
			Cell cel2 = titleRow.createCell(3);
			cel2.setCellStyle(styles.get("header"));
			cel2.setCellValue(titles[1]);
			
			Cell cel3 = titleRow.createCell(6);
			cel3.setCellStyle(styles.get("header"));
			cel3.setCellValue(titles[2]);
			
			++r;
			
			if(resultVO != null) {
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
				
				Cell cell4 = contentRow.createCell(5);
				cell4.setCellStyle(styles.get("cell"));
				cell4.setCellValue("数量");
				
				Cell cell5 = contentRow.createCell(6);
				cell5.setCellStyle(styles.get("cell"));
				cell5.setCellValue(resultVO.getOnceNum());
				
				++r;
				Row contentRow2 = sh.createRow(r);
				contentRow2.setHeight((short) 400);
				
				Cell cell6 = contentRow2.createCell(2);
				cell6.setCellStyle(styles.get("cell"));
				cell6.setCellValue("比例");
				
				Cell cell7 = contentRow2.createCell(3);
				cell7.setCellStyle(styles.get("cell"));
				cell7.setCellValue((Math.round(resultVO.getPassNum() / resultVO.getTaskNum() * 10000) / 100.00) + "%");
				
				Cell cell8 = contentRow2.createCell(5);
				cell8.setCellStyle(styles.get("cell"));
				cell8.setCellValue("比例");
				
				Cell cell9 = contentRow2.createCell(6);
				cell9.setCellStyle(styles.get("cell"));
				cell9.setCellValue((Math.round(resultVO.getOnceNum() / resultVO.getTaskNum() * 10000) / 100.00) + "%");
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
	
}
