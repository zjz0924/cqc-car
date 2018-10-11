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

import cn.wow.common.domain.Address;
import cn.wow.common.domain.Dictionary;
import cn.wow.common.service.AddressService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageMap;

@Controller
@RequestMapping(value = "address")
public class AddressController extends AbstractController {

	private static Logger logger = LoggerFactory.getLogger(AddressController.class);

	private final static String DEFAULT_PAGE_SIZE = "20";

	@Autowired
	private AddressService addressService;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model) {
		model.addAttribute("defaultPageSize", DEFAULT_PAGE_SIZE);
		return "address/address_list";
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
			map.put("name", name);
		}
		List<Address> dataList = addressService.selectAllList(map);

		// 分页
		Page<Address> pageList = (Page<Address>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id) {
		if (StringUtils.isNotBlank(id)) {
			Address address = addressService.selectOne(Long.parseLong(id));
			model.addAttribute("facadeBean", address);
		}
		return "address/address_detail";
	}

	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, String id, String name) {
		AjaxVO vo = new AjaxVO();
		Address address = null;

		try {
			if (StringUtils.isNotBlank(id)) {
				address = addressService.selectOne(Long.parseLong(id));

				if (address != null) {
					if (!name.equals(address.getName())) {
						Address existAddress = addressService.selectByName(name);

						if (existAddress != null) {
							vo.setData("name");
							vo.setMsg("地址已经存在");
							vo.setSuccess(false);
							return vo;
						}
					}
				}

				address.setName(name);
				addressService.update(getCurrentUserName(), address);

				vo.setMsg("编辑成功");
			} else {
				Address existAddress = addressService.selectByName(name);
				if (existAddress != null) {
					vo.setData("name");
					vo.setMsg("地址已经存在");
					vo.setSuccess(false);
					return vo;
				} else {
					address = new Address();
					address.setName(name);
					addressService.save(getCurrentUserName(), address);

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
			Address address = addressService.selectOne(Long.parseLong(id));

			if (address != null) {
				addressService.deleteByPrimaryKey(getCurrentUserName(), address);
			} else {
				vo.setMsg("删除失败，记录不存在");
				vo.setSuccess(false);
				return vo;
			}

		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("地址删除失败", ex);

			vo.setMsg("删除失败，系统异常");
			vo.setSuccess(false);
			return vo;
		}
		return vo;
	}
}