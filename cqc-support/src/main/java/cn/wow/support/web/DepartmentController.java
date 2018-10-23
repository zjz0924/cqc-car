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

import cn.wow.common.domain.Department;
import cn.wow.common.service.DepartmentService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.pagination.PageMap;

@Controller
@RequestMapping(value = "department")
public class DepartmentController extends AbstractController {

	private static Logger logger = LoggerFactory.getLogger(DepartmentController.class);

	private final static String DEFAULT_PAGE_SIZE = "20";

	@Autowired
	private DepartmentService departmentService;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model) {
		model.addAttribute("defaultPageSize", DEFAULT_PAGE_SIZE);
		return "department/department_list";
	}

	@ResponseBody
	@RequestMapping(value = "/getList")
	public Map<String, Object> getList(HttpServletRequest request, Model model, String name) {
		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "name asc");

		if (StringUtils.isNotBlank(name)) {
			map.put("qname", name);
		}
		List<Department> dataList = departmentService.selectAllList(map);

		// 分页
		Page<Department> pageList = (Page<Department>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id) {
		if (StringUtils.isNotBlank(id)) {
			Department department = departmentService.selectOne(Long.parseLong(id));
			model.addAttribute("facadeBean", department);
		}
		return "department/department_detail";
	}

	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, String id, String name, String remark) {
		AjaxVO vo = new AjaxVO();
		Department department = null;

		try {
			if (StringUtils.isNotBlank(id)) {
				department = departmentService.selectOne(Long.parseLong(id));

				if (department != null) {
					if (!name.equals(department.getName())) {
						Department existDepartment = departmentService.selectByName(name);

						if (existDepartment != null) {
							vo.setData("name");
							vo.setMsg("科室已经存在");
							vo.setSuccess(false);
							return vo;
						}
					}
				}

				department.setName(name);
				department.setRemark(remark);
				departmentService.update(getCurrentUserName(), department);

				vo.setMsg("编辑成功");
			} else {
				Department existCarCode = departmentService.selectByName(name);
				if (existCarCode != null) {
					vo.setData("name");
					vo.setMsg("科室已经存在");
					vo.setSuccess(false);
					return vo;
				} else {
					department = new Department();
					department.setName(name);
					department.setRemark(remark);
					departmentService.save(getCurrentUserName(), department);

					vo.setMsg("新增成功");
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			logger.error("科室保存失败", ex);
			vo.setMsg("保存失败，系统异常");
			vo.setSuccess(false);
			return vo;
		}

		return vo;
	}

	@ResponseBody
	@RequestMapping(value = "/delete")
	public AjaxVO delete(HttpServletRequest request, String id) {
		AjaxVO vo = new AjaxVO();
		vo.setMsg("删除成功");

		try {
			Department department = departmentService.selectOne(Long.parseLong(id));

			if (department != null) {
				departmentService.deleteByPrimaryKey(getCurrentUserName(), department);
			} else {
				vo.setMsg("删除失败，记录不存在");
				vo.setSuccess(false);
				return vo;
			}

		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("科室删除失败", ex);

			vo.setMsg("删除失败，系统异常");
			vo.setSuccess(false);
			return vo;
		}
		return vo;
	}
}