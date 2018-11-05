package cn.wow.support.web;

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
import cn.wow.common.service.MenuService;
import cn.wow.common.service.ReasonService;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.SamplingTaskEnum;
import cn.wow.common.utils.taskState.StandardTaskEnum;

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
	@Autowired
	private MenuService menuService;

	private static Map<Integer, String> urlMap = new HashMap<Integer, String>();

	static {
		urlMap.put(1, "ots/index?choose=0");
		urlMap.put(2, "ots/index?choose=1");
		urlMap.put(3, "ots/index?choose=2");
		urlMap.put(4, "ots/index?choose=3");
		urlMap.put(5, "ppap/index?taskType=2&choose=0");
		urlMap.put(6, "ppap/index?taskType=2&choose=1");
		urlMap.put(7, "ppap/index?taskType=3&choose=0");
		urlMap.put(8, "ppap/index?taskType=3&choose=1");
		urlMap.put(9, "tpt/index?choose=0");
		urlMap.put(10, "tpt/index?choose=1");
		urlMap.put(11, "tpt/index?choose=2");
		urlMap.put(12, "tpt/index?choose=3");
		urlMap.put(13, "result/uploadList?type=1");
		urlMap.put(14, "result/uploadList?type=2");
		urlMap.put(15, "result/compareList");
		urlMap.put(16, "result/sendList");
		urlMap.put(17, "result/confirmList?type=1");
		urlMap.put(18, "result/confirmList?type=2");
	}

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, Model model) {

		Menu menu = menuService.selectByAlias("backlog");
		model.addAttribute("menuName", menu.getName());
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

		// 获取有权限的菜单
		@SuppressWarnings("unchecked")
		Map<String, Menu> permissionMap = (Map<String, Menu>) request.getSession()
				.getAttribute(Contants.PERMISSION_MENU_MAP);

		if (isHasPermission(permissionMap, "otsRequire")) {
			map.put("otsRequire", true);
		}

		if (isHasPermission(permissionMap, "otsExamine")) {
			map.put("otsExamine", true);
		}

		if (isHasPermission(permissionMap, "otsOrder")) {
			map.put("otsTransmit", true);
		}

		if (isHasPermission(permissionMap, "otsApprove")) {
			map.put("otsApprove", true);
		}

		if (isHasPermission(permissionMap, "ppapOrder")) {
			map.put("ppapTransmit", true);
		}

		if (isHasPermission(permissionMap, "ppapApprove")) {
			map.put("ppapApprove", true);
		}

		if (isHasPermission(permissionMap, "sopOrder")) {
			map.put("sopTransmit", true);
		}

		if (isHasPermission(permissionMap, "sopApprove")) {
			map.put("sopApprove", true);
		}

		if (isHasPermission(permissionMap, "tptRequire")) {
			map.put("tptRequire", true);
		}

		if (isHasPermission(permissionMap, "tptExamine")) {
			map.put("tptExamine", true);
		}

		if (isHasPermission(permissionMap, "tptOrder")) {
			map.put("tptTransmit", true);
		}

		if (isHasPermission(permissionMap, "tptApprove")) {
			map.put("tptApprove", true);
		}

		if (isHasPermission(permissionMap, "patternUpload")) {
			map.put("patternTask", true);
		}

		if (isHasPermission(permissionMap, "atlasUpload")) {
			map.put("atlasTask", true);
		}

		if (isHasPermission(permissionMap, "compare")) {
			map.put("patternTask", true);
		}

		if (isHasPermission(permissionMap, "send")) {
			map.put("sendTask", true);
		}

		if (isHasPermission(permissionMap, "waitConfirm")) {
			map.put("confirmTask_wait", true);
		}

		if (isHasPermission(permissionMap, "finishConfirm")) {
			map.put("confirmTask_finish", true);
		}

		map.put("applicatId", applicat.getId());
		List<Task> dataList = taskService.getBacklogTask(map);

		if (dataList != null && dataList.size() > 0) {
			for (Task task : dataList) {
				task.setUrl(urlMap.get(task.getTaskType()));
			}
		}

		// 分页
		Page<Task> pageList = (Page<Task>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model) {

		// 获取有权限的菜单
		@SuppressWarnings("unchecked")
		Map<String, Menu> permissionMap = (Map<String, Menu>) request.getSession()
				.getAttribute(Contants.PERMISSION_MENU_MAP);

		Menu menu = permissionMap.get("backlog");
		if (menu != null) {
			model.addAttribute("backlogPermission", true);
		}
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

	public boolean isHasPermission(Map<String, Menu> permissionMap, String alias) {
		Menu menu = permissionMap.get(alias);
		if (menu != null) {
			return true;
		} else {
			return false;
		}
	}

}