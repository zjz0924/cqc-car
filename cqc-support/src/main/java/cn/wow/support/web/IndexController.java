package cn.wow.support.web;

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

import cn.wow.common.domain.Account;
import cn.wow.common.domain.Menu;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.SamplingTaskEnum;
import cn.wow.common.utils.taskState.StandardTaskEnum;
import cn.wow.common.utils.taskState.TaskTypeEnum;

/**
 * 首页控制器
 * 
 * @author zhenjunzhuo
 */
@Controller
@RequestMapping(value = "")
public class IndexController {

	private static Logger logger = LoggerFactory.getLogger(IndexController.class);

	@Autowired
	private TaskService taskService;

	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, Model model) {

		// 弹出待办信息
		String isShow = (String) request.getSession().getAttribute(Contants.SHOW_BACKLOG);
		if (StringUtils.isBlank(isShow)) {
			model.addAttribute("showBacklog", 1);
			request.getSession().setAttribute(Contants.SHOW_BACKLOG, "0");
		}

		return "index/index";
	}

	@ResponseBody
	@RequestMapping(value = "/getTaskNum")
	public AjaxVO getTaskNum(HttpServletRequest request, Model model) {

		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
		Map<String, Object> qMap = new PageMap(false);

		// 获取有权限的菜单
		@SuppressWarnings("unchecked")
		Map<String, Menu> permissionMap = (Map<String, Menu>) request.getSession()
				.getAttribute(Contants.PERMISSION_MENU_MAP);

		AjaxVO vo = new AjaxVO();

		// 任务数
		int examineNum = -1;
		int approveNum = -1;
		int patternUploadNum = -1;
		int atlasUploadNum = -1;
		int compareNum = -1;
		int waitConfirmNum = -1;
		int finishConfirmNum = -1;

		try {

			// ots审核数
			if (isHasPermission(permissionMap, "otsExamine")) {
				if (examineNum == -1) {
					examineNum = 0;
				}

				qMap.clear();
				qMap.put("state", StandardTaskEnum.EXAMINE.getState());
				qMap.put("type", 1);
				qMap.put("examineAccountId", account.getId());

				examineNum = taskService.getTaskNum(qMap);
			}

			// tpt审核数
			if (isHasPermission(permissionMap, "tptExamine")) {
				if (examineNum == -1) {
					examineNum = 0;
				}

				qMap.clear();
				qMap.put("state", StandardTaskEnum.EXAMINE.getState());
				qMap.put("type", 4);
				qMap.put("examineAccountId", account.getId());

				examineNum = taskService.getTaskNum(qMap);
			}

			// OTS 审批数
			if (isHasPermission(permissionMap, "otsApprove")) {
				if (approveNum == -1) {
					approveNum = 0;
				}

				qMap.clear();
				qMap.put("approveTask_ots", true);
				qMap.put("type", 1);
				qMap.put("approveAccountId", account.getId());
				approveNum += taskService.getTaskNum(qMap);
			}

			// TPT审批数
			if (isHasPermission(permissionMap, "tptApprove")) {
				if (approveNum == -1) {
					approveNum = 0;
				}

				qMap.clear();
				qMap.put("approveTask_gs", true);
				qMap.put("type", 4);
				qMap.put("approveAccountId", account.getId());
				approveNum += taskService.getTaskNum(qMap);
			}

			// SOP 审批数
			if (isHasPermission(permissionMap, "sopApprove")) {
				if (approveNum == -1) {
					approveNum = 0;
				}

				qMap.clear();
				qMap.put("ppap_approveTask", true);
				qMap.put("type", TaskTypeEnum.SOP.getState());
				qMap.put("approveAccountId", account.getId());
				approveNum += taskService.getTaskNum(qMap);
			}

			// PPAP 审批数
			if (isHasPermission(permissionMap, "ppapApprove")) {
				if (approveNum == -1) {
					approveNum = 0;
				}

				qMap.clear();
				qMap.put("ppap_approveTask", true);
				qMap.put("type", TaskTypeEnum.PPAP.getState());
				qMap.put("approveAccountId", account.getId());
				approveNum += taskService.getTaskNum(qMap);
			}

			// 型式结果上传数
			if (isHasPermission(permissionMap, "patternUpload")) {
				if (patternUploadNum == -1) {
					patternUploadNum = 0;
				}

				qMap.clear();
				qMap.put("state", StandardTaskEnum.TESTING.getState());
				qMap.put("patternTask", account.getOrgId() == null ? -1 : account.getOrgId());
				patternUploadNum = taskService.getTaskNum(qMap);
			}

			// 图谱结果上传数
			if (isHasPermission(permissionMap, "atlasUpload")) {
				if (atlasUploadNum == -1) {
					atlasUploadNum = 0;
				}

				qMap.clear();
				qMap.put("state", StandardTaskEnum.TESTING.getState());
				qMap.put("atlasTask", account.getOrgId() == null ? -1 : account.getOrgId());
				atlasUploadNum = taskService.getTaskNum(qMap);
			}

			// 结果对比
			if (isHasPermission(permissionMap, "compare")) {
				if (compareNum == -1) {
					compareNum = 0;
				}

				qMap.clear();
				qMap.put("state", SamplingTaskEnum.COMPARE.getState());
				qMap.put("compareTask", account.getOrgId());
				compareNum = taskService.getTaskNum(qMap);
			}

			// 结果接收-待上传
			if (isHasPermission(permissionMap, "waitConfirm")) {
				if (waitConfirmNum == -1) {
					waitConfirmNum = 0;
				}

				qMap.clear();
				qMap.put("applicatId", account.getId());
				qMap.put("confirmTask_wait", true);
				waitConfirmNum = taskService.getTaskNum(qMap);
			}

			// 结果接收已上传
			if (isHasPermission(permissionMap, "finishConfirm")) {
				if (finishConfirmNum == -1) {
					finishConfirmNum = 0;
				}

				qMap.clear();
				qMap.put("applicatId", account.getId());
				qMap.put("confirmTask_finish", true);

				finishConfirmNum = taskService.getTaskNum(qMap);
			}
		} catch (Exception ex) {
			logger.error("获取任务数异常", ex);
		} finally {
			Integer[] data = new Integer[] { examineNum, approveNum, patternUploadNum, atlasUploadNum, compareNum,
					waitConfirmNum, finishConfirmNum };
			vo.setData(data);
		}
		return vo;
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
