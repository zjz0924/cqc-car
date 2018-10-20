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

import cn.wow.common.domain.ReasonOption;
import cn.wow.common.service.ReasonOptionService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.pagination.PageMap;

@Controller
@RequestMapping(value = "reasonOption")
public class ReasonOptionController extends AbstractController {

	private static Logger logger = LoggerFactory.getLogger(ReasonOptionController.class);

	private final static String DEFAULT_PAGE_SIZE = "20";

	@Autowired
	private ReasonOptionService reasonOptionService;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model) {
		model.addAttribute("defaultPageSize", DEFAULT_PAGE_SIZE);
		return "reasonoption/reasonoption_list";
	}

	@ResponseBody
	@RequestMapping(value = "/getList")
	public Map<String, Object> getList(HttpServletRequest request, Model model, String name, Integer type) {
		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "type asc, name asc");

		if (StringUtils.isNotBlank(name)) {
			map.put("qname", name);
		}
		if (type != null) {
			map.put("type", type);
		}
		List<ReasonOption> dataList = reasonOptionService.selectAllList(map);

		// 分页
		Page<ReasonOption> pageList = (Page<ReasonOption>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id) {
		if (StringUtils.isNotBlank(id)) {
			ReasonOption ReasonOption = reasonOptionService.selectOne(Long.parseLong(id));
			model.addAttribute("facadeBean", ReasonOption);
		}
		return "reasonoption/reasonoption_detail";
	}

	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, String id, String name, String remark, int type) {
		AjaxVO vo = new AjaxVO();
		ReasonOption reasonOption = null;

		try {
			if (StringUtils.isNotBlank(id)) {
				reasonOption = reasonOptionService.selectOne(Long.parseLong(id));

				if (reasonOption != null) {
					if (!name.equals(reasonOption.getName())) {
						ReasonOption existReasonOption = reasonOptionService.selectByName(name);

						if (existReasonOption != null) {
							vo.setData("name");
							vo.setMsg("名称已经存在");
							vo.setSuccess(false);
							return vo;
						}
					}
				}

				reasonOption.setName(name);
				reasonOption.setRemark(remark);
				reasonOptionService.update(getCurrentUserName(), reasonOption);

				vo.setMsg("编辑成功");
			} else {
				ReasonOption existReasonOption = reasonOptionService.selectByName(name);
				if (existReasonOption != null) {
					vo.setData("name");
					vo.setMsg("名称已经存在");
					vo.setSuccess(false);
					return vo;
				} else {
					reasonOption = new ReasonOption();
					reasonOption.setName(name);
					reasonOption.setRemark(remark);
					reasonOption.setType(type);
					reasonOptionService.save(getCurrentUserName(), reasonOption);

					vo.setMsg("新增成功");
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			logger.error("抽样选项保存失败", ex);
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
			ReasonOption reasonOption = reasonOptionService.selectOne(Long.parseLong(id));

			if (reasonOption != null) {
				reasonOptionService.deleteByPrimaryKey(getCurrentUserName(), reasonOption);
			} else {
				vo.setMsg("删除失败，记录不存在");
				vo.setSuccess(false);
				return vo;
			}

		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("选择删除失败", ex);

			vo.setMsg("删除失败，系统异常");
			vo.setSuccess(false);
			return vo;
		}
		return vo;
	}
}