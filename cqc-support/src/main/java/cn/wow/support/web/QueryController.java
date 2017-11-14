package cn.wow.support.web;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.ImportExcelUtil;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.TaskTypeEnum;

@Controller
@RequestMapping(value = "query")
public class QueryController extends AbstractController {

	Logger logger = LoggerFactory.getLogger(QueryController.class);

	private final static String DEFAULT_PAGE_SIZE = "10";
	
	@Autowired
	private TaskService taskService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private ExamineRecordService examineRecordService;
	@Autowired
	private AtlasResultService atlasResultService;
	@Autowired
	private PfResultService pfResultService;
	
	private List<Task> data = new ArrayList<Task>();

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model) {
		
		Menu menu = menuService.selectByAlias("query");
		
		model.addAttribute("defaultPageSize", DEFAULT_PAGE_SIZE);
		model.addAttribute("resUrl", resUrl);
		model.addAttribute("menuName", menu.getName());
		return "query/task_list";
	}

	
	/**
	 * 获取数据
	 */
	@ResponseBody
	@RequestMapping(value = "/getListData")
	public Map<String, Object> getListData(HttpServletRequest request, Model model, String code, String startCreateTime, String endCreateTime, String taskType, String orgId, String nickName, String startConfirmTime, String endConfirmTime) {
		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
		
		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		
		if (StringUtils.isNotBlank(code)) {
			map.put("code", code);
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime);
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime);
		}
		if (StringUtils.isNotBlank(startConfirmTime)) {
			map.put("startConfirmTime", startConfirmTime);
		}
		if (StringUtils.isNotBlank(endConfirmTime)) {
			map.put("endConfirmTime", endConfirmTime);
		}
		if (StringUtils.isNotBlank(nickName)) {
			map.put("nickName", nickName);
		}
		if (StringUtils.isNotBlank(orgId)) {
			map.put("orgId", orgId);
		}
		if (StringUtils.isNotBlank(taskType)) {
			map.put("type", taskType);
		}
		
		/**
		 * 1) 任务发起人，只能查看自己发起的任务单
		 * 2) 需要我审批的单
		 * 3) 实验室，只看需要我上传结果的任务
		 */
		if (!Contants.SUPER_ROLE_CODE.equals(account.getRole().getCode())) {
			Map<String, Object> queryMap = new HashMap<String, Object>();
			queryMap.put("accountId", account.getId());

			// 审批过的任务ID
			List<Long> taskIdList = examineRecordService.selectTaskIdList(account.getId(), 2);
			if (taskIdList != null && taskIdList.size() > 0) {
				queryMap.put("taskIdList", taskIdList);
			}
			map.put("queryMap", queryMap);
		}
		
		List<Task> dataList = taskService.selectAllList(map);
		data = dataList;
		
		// 分页
		Page<Task> pageList = (Page<Task>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	/**
	 * 详情
	 */
	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id) {
		if (StringUtils.isNotBlank(id)) {
			Task task = taskService.selectOne(Long.parseLong(id));

			if(task.getType() == TaskTypeEnum.OTS.getState() || task.getType() == TaskTypeEnum.GS.getState()){   // OTS/GS 结果确认
				
				if(task.getState() >= 4) {
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
				}
			}else if(task.getType() == TaskTypeEnum.PPAP.getState() || task.getType() == TaskTypeEnum.SOP.getState() ){
				if(task.getState() >= 6) {
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
					Map<String, List<ExamineRecord>> compareResult = atlasResultService.assembleCompareResult(Long.parseLong(id));
					
					model.addAttribute("mAtlasResult", mAtlasResult);
					model.addAttribute("pAtlasResult", pAtlasResult);
					model.addAttribute("compareResult", compareResult);
				}
			}
			model.addAttribute("facadeBean", task);
		}
		model.addAttribute("resUrl", resUrl);
		return "query/task_detail";
	}
	
	
	/**
	 * 导出任务列表
	 */
	@RequestMapping(value = "/exportTask")
	public void exportTask(HttpServletRequest request, HttpServletResponse response) {
		String filename = "任务清单";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		try {
			// 设置头
			ImportExcelUtil.setResponseHeader(response, filename + ".xlsx");

			Workbook wb = new SXSSFWorkbook(100); // 保持100条在内存中，其它保存到磁盘中
			// 工作簿
			Sheet sh = wb.createSheet("任务清单");
			sh.setColumnWidth(0, (short) 6000);
			sh.setColumnWidth(1, (short) 6000);
			sh.setColumnWidth(2, (short) 4000);
			sh.setColumnWidth(3, (short) 9000);
			sh.setColumnWidth(4, (short) 5000);
			sh.setColumnWidth(5, (short) 6000);
			sh.setColumnWidth(6, (short) 6000);
			sh.setColumnWidth(7, (short) 6000);
			
			Map<String, CellStyle> styles = ImportExcelUtil.createStyles(wb);

			String[] titles = { "任务号", "任务类型", "状态", "录入单位", "录入用户", "录入时间", "完成时间"};
			int r = 0;
			
			Row titleRow = sh.createRow(0);
			titleRow.setHeight((short) 450);
			for(int k = 0; k < titles.length; k++){
				Cell cell = titleRow.createCell(k);
				cell.setCellStyle(styles.get("header"));
				cell.setCellValue(titles[k]);
			}
			
			++r;
			for (int j = 0; j < data.size(); j++) {// 添加数据
				Row contentRow = sh.createRow(r);
				contentRow.setHeight((short) 400);
				Task task = data.get(j);

				Cell cell1 = contentRow.createCell(0);
				cell1.setCellStyle(styles.get("cell"));
				cell1.setCellValue(task.getCode());

				Cell cell2 = contentRow.createCell(1);
				cell2.setCellStyle(styles.get("cell"));
				String taskType = "";
				if (task.getType() == TaskTypeEnum.OTS.getState()) {
					taskType = "车型OTS阶段任务";
				} else if (task.getType() == TaskTypeEnum.PPAP.getState()) {
					taskType = "车型PPAP阶段任务";
				} else if (task.getType() == TaskTypeEnum.SOP.getState()) {
					taskType = "车型SOP阶段任务";
				} else {
					taskType = "非车型材料任务";
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
						state = "结果确认中";
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

				Cell cell4 = contentRow.createCell(3);
				cell4.setCellStyle(styles.get("cell"));
				cell4.setCellValue(task.getOrg().getName());

				Cell cell5 = contentRow.createCell(4);
				cell5.setCellStyle(styles.get("cell"));
				cell5.setCellValue(task.getAccount().getUserName());

				Cell cell6 = contentRow.createCell(5);
				cell6.setCellStyle(styles.get("cell"));
				cell6.setCellValue(sdf.format(task.getCreateTime()));

				Cell cell7 = contentRow.createCell(6);
				cell7.setCellStyle(styles.get("cell"));
				if(task.getConfirmTime() != null) {
					cell7.setCellValue(sdf.format(task.getConfirmTime()));
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
