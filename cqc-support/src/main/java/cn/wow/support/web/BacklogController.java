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
import cn.wow.common.utils.taskState.TaskTypeEnum;

@Controller
@RequestMapping(value = "backlog")
public class BacklogController {

	Logger logger = LoggerFactory.getLogger(AreaController.class);

	private final static String DEFAULT_PAGE_SIZE = "10";

	@Autowired
	private TaskService taskService;
	@Autowired
	private MenuService menuService;

	private static Map<Integer, String> urlMap = new HashMap<Integer, String>();

	static {
		urlMap.put(1, "ots/index?choose=0");
		urlMap.put(2, "ots/index?choose=");
		urlMap.put(3, "ots/index?choose=");
		urlMap.put(4, "ots/index?choose=");
		urlMap.put(5, "ppap/index?taskType=2&choose=0");
		urlMap.put(6, "ppap/index?taskType=2&choose=");
		urlMap.put(7, "ppap/index?taskType=3&choose=0");
		urlMap.put(8, "ppap/index?taskType=3&choose=");
		urlMap.put(9, "tpt/index?choose=0");
		urlMap.put(10, "tpt/index?choose=");
		urlMap.put(11, "tpt/index?choose=");
		urlMap.put(12, "tpt/index?choose=");
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
				task.setUrl(getUrl(permissionMap, task));
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

	public boolean isHasPermission(Map<String, Menu> permissionMap, String alias) {
		Menu menu = permissionMap.get(alias);
		if (menu != null) {
			return true;
		} else {
			return false;
		}
	}

	private String getUrl(Map<String, Menu> permissionMap, Task task) {
		String url = urlMap.get(task.getTaskType());
		int num = 0;

		if (task.getTaskType() == 2) {
			if (isHasPermission(permissionMap, "otsRequire")) {
				url += 1;
			} else {
				url += 0;
			}
		} else if (task.getTaskType() == 3) {
			if (isHasPermission(permissionMap, "otsRequire")) {
				++num;
			}

			if (isHasPermission(permissionMap, "otsExamine")) {
				++num;
			}
			url += num;

		} else if (task.getTaskType() == 4) {
			if (isHasPermission(permissionMap, "otsRequire")) {
				++num;
			}

			if (isHasPermission(permissionMap, "otsExamine")) {
				++num;
			}

			if (isHasPermission(permissionMap, "otsOrder")) {
				++num;
			}

			url += num;
		} else if (task.getTaskType() == 6) {
			if (isHasPermission(permissionMap, "ppapOrder")) {
				++num;
			}

			url += num;
		} else if (task.getTaskType() == 8) {
			if (isHasPermission(permissionMap, "sopOrder")) {
				++num;
			}

			url += num;
		} else if (task.getTaskType() == 11) {
			if (isHasPermission(permissionMap, "tptRequire")) {
				url += 1;
			} else {
				url += 0;
			}
		} else if (task.getTaskType() == 12) {
			if (isHasPermission(permissionMap, "tptRequire")) {
				++num;
			}

			if (isHasPermission(permissionMap, "tptExamine")) {
				++num;
			}
			url += num;

		} else if (task.getTaskType() == 13) {
			if (isHasPermission(permissionMap, "tptRequire")) {
				++num;
			}

			if (isHasPermission(permissionMap, "tptExamine")) {
				++num;
			}

			if (isHasPermission(permissionMap, "tptOrder")) {
				++num;
			}

			url += num;
		}
		return url;
	}

}
