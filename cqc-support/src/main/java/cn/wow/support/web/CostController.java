package cn.wow.support.web;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.Page;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.AtlasResult;
import cn.wow.common.domain.CostRecord;
import cn.wow.common.domain.ExpItem;
import cn.wow.common.domain.LabReq;
import cn.wow.common.domain.Menu;
import cn.wow.common.service.AtlasResultService;
import cn.wow.common.service.AttachService;
import cn.wow.common.service.CostRecordService;
import cn.wow.common.service.ExpItemService;
import cn.wow.common.service.LabConclusionService;
import cn.wow.common.service.LabReqService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.PfResultService;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.ImportExcelUtil;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.TaskTypeEnum;

/**
 * 费用管理控制器
 * 
 * @author zhenjunzhuo 2017-11-04
 */
@Controller
@RequestMapping(value = "cost")
public class CostController extends AbstractController {

	Logger logger = LoggerFactory.getLogger(CostController.class);

	private final static String DEFAULT_PAGE_SIZE = "10";

	@Autowired
	private CostRecordService costRecordService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private ExpItemService expItemService;
	@Autowired
	private LabReqService labReqService;

	// 查询的条件，用于导出
	private Map<String, Object> queryMap = new PageMap(false);

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model, int type) {
		Menu menu = null;
		if (type == 1) {
			menu = menuService.selectByAlias("tosend");
		} else {
			menu = menuService.selectByAlias("sent");
		}

		model.addAttribute("defaultPageSize", DEFAULT_PAGE_SIZE);
		model.addAttribute("type", type);
		model.addAttribute("menuName", menu.getName());
		return "cost/cost_list";
	}

	/**
	 * 获取数据
	 * 
	 * @param startCreateTime 创建时间
	 * @param endCreateTime   创建时间
	 * @param code            任务编码
	 * @param type            类型：0-未发送列表 ，1-已发送列表
	 * @param taskType        任务类型
	 * @param labType         实验类型
	 * @param labResult       实验结果
	 */
	@ResponseBody
	@RequestMapping(value = "/getListData")
	public Map<String, Object> getListData(HttpServletRequest request, Model model, String startCreateTime,
			String endCreateTime, String code, int type, String taskType, String labType, String labResult) {

		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
		queryMap.clear();

		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "c.create_time desc, t.code asc, c.state asc");
		queryMap.put("custom_order_sql", "c.create_time desc, t.code asc, c.state asc");

		if (StringUtils.isNotBlank(code)) {
			map.put("code", code);
			queryMap.put("code", code);
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
			queryMap.put("startCreateTime", startCreateTime + " 00:00:00");
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
			queryMap.put("endCreateTime", endCreateTime + " 23:59:59");
		}
		if (StringUtils.isNotBlank(taskType)) {
			map.put("taskType", taskType);
			queryMap.put("taskType", taskType);
		}
		if (StringUtils.isNotBlank(labType)) {
			map.put("labType", labType);
			queryMap.put("labType", labType);
		}
		if (StringUtils.isNotBlank(labResult)) {
			map.put("labResult", labResult);
			queryMap.put("labResult", labResult);
		}

		if (type == 1) {
			map.put("state", 0);
			queryMap.put("state", 0);

			if (account.getRole() != null && !Contants.SUPER_ROLE_CODE.equals(account.getRole().getCode())) {
				map.put("labId", account.getOrgId());
				queryMap.put("labId", account.getOrgId());
			}
		} else {
			map.put("state", 1);
			queryMap.put("state", 1);

			if (account.getRole() != null && !Contants.SUPER_ROLE_CODE.equals(account.getRole().getCode())) {
				map.put("orgs", account.getOrgId());
				queryMap.put("orgs", account.getOrgId());
			}
		}

		List<CostRecord> dataList = costRecordService.selectAllList(map);

		// 分页
		Page<CostRecord> pageList = (Page<CostRecord>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id, int type) {
		if (StringUtils.isNotBlank(id)) {
			CostRecord costRecord = costRecordService.selectOne(Long.parseLong(id));

			// 费用详情
			if (type == 2) {
				Map<String, Object> eMap = new PageMap(false);
				eMap.put("cId", costRecord.getId());
				List<ExpItem> itemList = expItemService.selectAllList(eMap);

				model.addAttribute("itemList", itemList);
			}

			List<LabReq> labReqList = labReqService.getLabReqListByTaskId(costRecord.getTask().getId());
			model.addAttribute("labReqList", labReqList);

			model.addAttribute("facadeBean", costRecord);
		}

		model.addAttribute("resUrl", resUrl);
		model.addAttribute("type", type);
		return "cost/cost_detail";
	}


	/**
	 * 费用清单发送
	 * 
	 * @param costId 费用清单ID
	 * @param result 试验项目
	 * @param orgs   发送机构
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/costSend")
	public AjaxVO costSend(HttpServletRequest request, Model model, Long costId, String result, String orgs) {
		AjaxVO vo = new AjaxVO();

		try {
			ObjectMapper mapper = new ObjectMapper();
			List<ExpItem> itemList = mapper.readValue(result, new TypeReference<List<ExpItem>>() {
			});

			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			costRecordService.costSend(account, costId, orgs, itemList);

		} catch (Exception ex) {
			logger.error("费用清单发送失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}

	/**
	 * 导出列表
	 */
	@RequestMapping(value = "/exportList")
	public void exportList(HttpServletRequest request, HttpServletResponse response, int type) {
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		StringBuffer filename = new StringBuffer(sdf1.format(new Date()));
		if (type == 1) {
			filename.append("_待发送费用清单");
		} else {
			filename.append("_收费通知清单");
		}

		try {
			// 设置头
			ImportExcelUtil.setResponseHeader(response, filename + ".xlsx");

			Workbook wb = new SXSSFWorkbook(100); // 保持100条在内存中，其它保存到磁盘中
			// 工作簿
			Sheet sh = wb.createSheet("清单列表");
			sh.setColumnWidth(0, (short) 6000);
			sh.setColumnWidth(1, (short) 6000);
			sh.setColumnWidth(2, (short) 4000);
			sh.setColumnWidth(3, (short) 4000);
			sh.setColumnWidth(4, (short) 5000);

			Map<String, CellStyle> styles = ImportExcelUtil.createStyles(wb);

			String[] titles = { "任务号", "任务类型", "实验类型", "实验结果", "创建时间" };
			int r = 0;

			Row titleRow = sh.createRow(0);
			titleRow.setHeight((short) 450);
			for (int k = 0; k < titles.length; k++) {
				Cell cell = titleRow.createCell(k);
				cell.setCellStyle(styles.get("header"));
				cell.setCellValue(titles[k]);
			}

			++r;
			List<CostRecord> dataList = costRecordService.selectAllList(queryMap);
			for (int j = 0; j < dataList.size(); j++) {// 添加数据
				Row contentRow = sh.createRow(r);
				contentRow.setHeight((short) 400);
				CostRecord costRecord = dataList.get(j);

				// 任务号
				Cell cell1 = contentRow.createCell(0);
				cell1.setCellStyle(styles.get("cell"));
				if (costRecord.getTask() != null) {
					cell1.setCellValue(costRecord.getTask().getCode());
				}

				// 任务类型
				Cell cell2 = contentRow.createCell(1);
				cell2.setCellStyle(styles.get("cell"));
				String taskType = "";
				if (costRecord.getTask() != null) {
					if (costRecord.getTask().getType() == TaskTypeEnum.OTS.getState()) {
						taskType = "基准图谱建立";
					} else if (costRecord.getTask().getType() == TaskTypeEnum.PPAP.getState()) {
						taskType = "图谱试验抽查-开发阶段";
					} else if (costRecord.getTask().getType() == TaskTypeEnum.SOP.getState()) {
						taskType = "图谱试验抽查-量产阶段";
					} else {
						taskType = "第三方委托";
					}
				}
				cell2.setCellValue(taskType);

				// 实验类型
				Cell cell3 = contentRow.createCell(2);
				cell3.setCellStyle(styles.get("cell"));
				String labType = "";
				if (costRecord.getLabType() == 1) {
					labType = "零部件图谱";
				} else if (costRecord.getLabType() == 2) {
					labType = "零部件型式";
				} else if (costRecord.getLabType() == 3) {
					labType = "原材料图谱";
				} else {
					labType = "原材料型式";
				}
				cell3.setCellValue(labType);

				// 实验结果
				Cell cell4 = contentRow.createCell(3);
				cell4.setCellStyle(styles.get("cell"));
				String labResult = costRecord.getLabResult().intValue() == 1 ? "合格" : "不合格";
				cell4.setCellValue(labResult);

				// 创建时间
				Cell cell5 = contentRow.createCell(4);
				cell5.setCellStyle(styles.get("cell"));
				if (costRecord.getCreateTime() != null) {
					cell5.setCellValue(sdf.format(costRecord.getCreateTime()));
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

	/**
	 * 分组
	 * 
	 * @param atDataList
	 * @param pAtlasResult
	 * @param mAtlasResult
	 */
	public void groupAtlasResult(List<AtlasResult> arDataList, List<AtlasResult> pAtlasResult,
			List<AtlasResult> mAtlasResult) {
		for (AtlasResult ar : arDataList) {
			if (ar.getCatagory() == 1) {
				pAtlasResult.add(ar);
			} else {
				mAtlasResult.add(ar);
			}
		}
	}
}
