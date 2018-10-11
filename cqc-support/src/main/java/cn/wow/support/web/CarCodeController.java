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

import cn.wow.common.domain.CarCode;
import cn.wow.common.service.CarCodeService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.pagination.PageMap;

@Controller
@RequestMapping(value = "carCode")
public class CarCodeController extends AbstractController {

	private static Logger logger = LoggerFactory.getLogger(CarCodeController.class);

	private final static String DEFAULT_PAGE_SIZE = "20";

	@Autowired
	private CarCodeService carCodeService;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model) {
		model.addAttribute("defaultPageSize", DEFAULT_PAGE_SIZE);
		return "carcode/carcode_list";
	}

	@ResponseBody
	@RequestMapping(value = "/getList")
	public Map<String, Object> getList(HttpServletRequest request, Model model, String code) {
		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "code asc");

		if (StringUtils.isNotBlank(code)) {
			map.put("code", code);
		}
		List<CarCode> dataList = carCodeService.selectAllList(map);

		// 分页
		Page<CarCode> pageList = (Page<CarCode>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id) {
		if (StringUtils.isNotBlank(id)) {
			CarCode carCode = carCodeService.selectOne(Long.parseLong(id));
			model.addAttribute("facadeBean", carCode);
		}
		return "carcode/carcode_detail";
	}

	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, String id, String code, String remark) {
		AjaxVO vo = new AjaxVO();
		CarCode carCode = null;

		try {
			if (StringUtils.isNotBlank(id)) {
				carCode = carCodeService.selectOne(Long.parseLong(id));

				if (carCode != null) {
					if (!code.equals(carCode.getCode())) {
						CarCode existCarCode = carCodeService.selectByCode(code);

						if (existCarCode != null) {
							vo.setData("code");
							vo.setMsg("车型代码已经存在");
							vo.setSuccess(false);
							return vo;
						}
					}
				}

				carCode.setCode(code);
				carCode.setRemark(remark);
				carCodeService.update(getCurrentUserName(), carCode);

				vo.setMsg("编辑成功");
			} else {
				CarCode existCarCode = carCodeService.selectByCode(code);
				if (existCarCode != null) {
					vo.setData("code");
					vo.setMsg("车型代码已经存在");
					vo.setSuccess(false);
					return vo;
				} else {
					carCode = new CarCode();
					carCode.setCode(code);
					carCode.setRemark(remark);
					carCodeService.save(getCurrentUserName(), carCode);

					vo.setMsg("新增成功");
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			logger.error("地址保存失败", ex);
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
			CarCode carCode = carCodeService.selectOne(Long.parseLong(id));

			if (carCode != null) {
				carCodeService.deleteByPrimaryKey(getCurrentUserName(), carCode);
			} else {
				vo.setMsg("删除失败，记录不存在");
				vo.setSuccess(false);
				return vo;
			}

		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("车型代码删除失败", ex);

			vo.setMsg("删除失败，系统异常");
			vo.setSuccess(false);
			return vo;
		}
		return vo;
	}
}