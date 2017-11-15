package cn.wow.support.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.wow.common.domain.Menu;
import cn.wow.common.domain.ResultVO;
import cn.wow.common.domain.Task;
import cn.wow.common.service.InfoService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.pagination.PageMap;

/**
 * 统计控制器
 * 
 * @author zhenjunzhuo 2017-11-15
 */
@Controller
@RequestMapping(value = "statistic")
public class StatisticController {

	@Autowired
	private MenuService menuService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private InfoService infoService;
	
	@RequestMapping(value = "/result")
	public String result(HttpServletRequest request, HttpServletResponse response, Model model) {
		Menu menu = menuService.selectByAlias("resultStatistic");
		
		model.addAttribute("menuName", menu.getName());
		return "statistic/result";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/getResult")
	public AjaxVO getResult(HttpServletRequest request, Model model, String startConfirmTime, String endConfirmTime, Long v_id,
			Long p_id, Long m_id, String taskType) {
		AjaxVO vo = new AjaxVO();

		Map<String, Object> qMap = new PageMap(false);
		
		if (StringUtils.isNotBlank(startConfirmTime)) {
			qMap.put("startConfirmTime", startConfirmTime);
		}
		if (StringUtils.isNotBlank(endConfirmTime)) {
			qMap.put("endConfirmTime", endConfirmTime);
		}
		if (StringUtils.isNotBlank(taskType)) {
			qMap.put("type", taskType);
		}
		
		List<Long> iIdList = new ArrayList<Long>();
		if (v_id != null || p_id != null || m_id != null) {
			Map<String, Object> iMap = new PageMap(false);
			iMap.put("state", 1);

			if (v_id != null) {
				iMap.put("vId", v_id);
			}
			if (p_id != null) {
				iMap.put("pId", p_id);
			}
			if (m_id != null) {
				iMap.put("mId", m_id);
			}
			iIdList = infoService.selectIdList(iMap);
			
			if(iIdList.size() <1) {
				iIdList.add(-1l);
			}
		}
		
		if(iIdList.size() > 0) {
			qMap.put("iIdList", iIdList);
		}
		List<Task> taskList = taskService.selectAllList(qMap);
		
		ResultVO resultVO = new ResultVO();
		if (taskList != null && taskList.size() > 0) {
			resultVO.setTaskNum(taskList.size());

			for (Task task : taskList) {
				if (task.getFailNum().intValue() == 0) {
					resultVO.setPassNum(resultVO.getPassNum() + 1);
				} else if (task.getFailNum().intValue() == 1) {
					resultVO.setOnceNum(resultVO.getOnceNum() + 1);
				} else {
					resultVO.setTwiceNum(resultVO.getTwiceNum() + 1);
				}
			}
		}
		
		vo.setData(resultVO);
		vo.setSuccess(true);
		return vo;
	}
	
}
