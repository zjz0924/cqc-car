package cn.wow.support.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import cn.wow.common.service.MenuService;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageMap;


/**
 * 申请管理
 * @author zhenjunzhuo
 * 2017-11-05
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
	
	/**
	 * 任务列表
	 */
	@RequestMapping(value = "/taskList")
	public String taskList(HttpServletRequest request, HttpServletResponse response, Model model) {

		Menu menu = menuService.selectByAlias("updateApply");

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
	public Map<String, Object> taskListData(HttpServletRequest request, Model model, String startCreateTime, String endCreateTime, Integer state) {
		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
		
		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime);
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime);
		}
		
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
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/infoDetail")
	public String infoDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id) {
		if(id != null){
			Task task = taskService.selectOne(id);
			
			model.addAttribute("facadeBean", task);
		}
		
		return "apply/info_detail";
	}
	
	/**
	 * 实验结果详情
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/labDetail")
	public String labDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id) {
		if(id != null){
			Task task = taskService.selectOne(id);
			
			model.addAttribute("facadeBean", task);
		}
		
		return "apply/lab_detail";
	}
	
	
	/**
	 * 申请列表
	 */
	@RequestMapping(value = "/applyList")
	public String applyList(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("defaultPageSize", DEFAULT_PAGE_SIZE);
		return "apply/apply_list";
	}
	
}
