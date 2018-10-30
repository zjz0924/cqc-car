package cn.wow.support.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.Page;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.Task;
import cn.wow.common.service.AccountService;
import cn.wow.common.service.EmailRecordService;
import cn.wow.common.service.InfoService;
import cn.wow.common.service.ReasonService;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.SamplingTaskEnum;
import cn.wow.common.utils.taskState.StandardTaskEnum;
import cn.wow.common.utils.taskState.TaskTypeEnum;

@Controller
@RequestMapping(value = "backlog")
public class BacklogController {

	Logger logger = LoggerFactory.getLogger(AreaController.class);

	private final static String DEFAULT_PAGE_SIZE = "10";

	@Autowired
	private TaskService taskService;
	@Autowired
	private EmailRecordService emailRecordService;
	@Autowired
	private InfoService infoService;
	@Autowired
	private AccountService accountService;
	@Autowired
	private ReasonService reasonService;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, Model model) {
		return "backlog/backlog_list";
	}

	/**
	 * 获取数据
	 */
	@ResponseBody
	@RequestMapping(value = "/getListData")
	public Map<String, Object> getListData(HttpServletRequest request, Model model, String sort, String order) {

		Account applicat = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);

		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", DEFAULT_PAGE_SIZE);
		}

		String orderSql = "t.create_time desc";
		if (StringUtils.isNotBlank(sort)) {
			if ("isReceive".equals(sort)) {
				sort = "is_receive";
			}
			if ("createTime".equals(sort)) {
				sort = "create_time";
			}
			if ("confirmTime".equals(sort)) {
				sort = "confirm_time";
			}
			orderSql = sort + " " + order;
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", orderSql);

		List<Task> dataList = taskService.selectAllList(map);

		// 分页
		Page<Task> pageList = (Page<Task>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model) {
		return "backlog/backlog_detail";
	}

	/**
	 * 获取不同类型的任务 type:
	 * 1-任务申请，2-信息审核，3-任务下达，4-任务审批，5-图谱结果上传，6-型式结果上传，7-结果对比，8-结果发送，9-结果确认-待上传结果，10-结果确认-已上传结果
	 */
	private void getTaskByType(int type, List<Task> dataList, Account account) {
		Map<String, Object> map = new PageMap(false);

		if (type == 1) {
			map.put("examineState", true);
			map.put("otsAndtPtTask", true);
		} else if (type == 2) {
			map.put("state", StandardTaskEnum.EXAMINE.getState());
			map.put("otsAndtPtTask", true);
			map.put("neDraft", "1");
			map.put("examineAccountId", account.getId());
		} else if (type == 3) {
			map.put("transimtTask_ots", true);
			map.put("state", StandardTaskEnum.TESTING.getState());
			map.put("otsAndtPtTask", true);
			map.put("trainsmitAccountId", account.getId());

			map.put("state", SamplingTaskEnum.APPROVE_NOTPASS.getState());
			map.put("ppapAndSopTask", true);

		} else if (type == 4) {
			map.put("approveTask_ots", true);
			map.put("otsAndtPtTask", true);
			map.put("approveAccountId", account.getId());

			map.put("ppap_approveTask", true);
			map.put("approveAccountId", account.getId());
			map.put("ppapAndSopTask", true);
		} else if (type == 5) {
			map.put("state", StandardTaskEnum.TESTING.getState());
			map.put("atlasTask", account.getOrgId() == null ? -1 : account.getOrgId());
		} else if (type == 6) {
			map.put("state", StandardTaskEnum.TESTING.getState());
			map.put("patternTask", account.getOrgId() == null ? -1 : account.getOrgId());
		} else if (type == 7) {
			map.put("state", SamplingTaskEnum.COMPARE.getState());
			map.put("compareTask", true);
		} else if (type == 8) {
			map.put("sendTask", account.getOrgId());
		} else if (type == 9) {
			map.put("confirmTask_wait", true);
		} else {
			map.put("confirmTask_finish", true);
		}
	}

}
