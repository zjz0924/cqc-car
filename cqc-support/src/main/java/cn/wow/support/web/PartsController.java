package cn.wow.support.web;

import java.text.SimpleDateFormat;
import java.util.Date;
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

import cn.wow.common.domain.Parts;
import cn.wow.common.service.PartsService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.pagination.PageMap;

/**
 * 零部件信息
 * 
 * @author zhenjunzhuo 2017-09-28
 */
@Controller
@RequestMapping(value = "parts")
public class PartsController extends AbstractController {

	Logger logger = LoggerFactory.getLogger(PartsController.class);

	private final static String DEFAULT_PAGE_SIZE = "20";

	@Autowired
	private PartsService partsService;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model) {
		model.addAttribute("defaultPageSize", DEFAULT_PAGE_SIZE);
		return "info/parts/parts_list";
	}

	/**
	 * 获取数据
	 */
	@ResponseBody
	@RequestMapping(value = "/getList")
	public Map<String, Object> getList(HttpServletRequest request, Model model, String code, String type,
			String startProTime, String endProTime) {

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
		if (StringUtils.isNotBlank(type)) {
			map.put("type", type);
		}
		if (StringUtils.isNotBlank(startProTime)) {
			map.put("startProTime", startProTime);
		}
		if (StringUtils.isNotBlank(endProTime)) {
			map.put("endProTime", endProTime);
		}

		List<Parts> dataList = partsService.selectAllList(map);

		// 分页
		Page<Parts> pageList = (Page<Parts>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	/**
	 * 详情
	 */
	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id) {
		if (StringUtils.isNotBlank(id)) {
			Parts parts = partsService.selectOne(Long.parseLong(id));

			model.addAttribute("facadeBean", parts);
		}
		return "info/parts/parts_detail";
	}

	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, String id, String code, Integer type, String proTime,
			String proAddr, String remark, String producer, String place, String proNo, String technology,
			String matName, String matNo, String matColor, String matProducer, String pic) {
		AjaxVO vo = new AjaxVO();
		Parts parts = null;

		try {
			if (StringUtils.isNotBlank(id)) {
				parts = partsService.selectOne(Long.parseLong(id));

				if (parts != null) {
					parts.setType(type);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					parts.setProTime(sdf.parse(proTime));
					parts.setRemark(remark);
					partsService.update(getCurrentUserName(), parts);
				}
				vo.setMsg("编辑成功");
			} else {
				Parts dbVehicle = partsService.selectByCode(code);

				if (dbVehicle != null) {
					vo.setData("code");
					vo.setMsg("编码已存在");
					vo.setSuccess(false);
					return vo;
				} else {
					parts = new Parts();
					parts.setType(type);
					parts.setCode(code);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					parts.setProTime(sdf.parse(proTime));
					parts.setRemark(remark);
					parts.setCreateTime(new Date());
					partsService.save(getCurrentUserName(), parts);

					vo.setMsg("添加成功");
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			logger.error("零部件信息保存失败", ex);
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
			Parts parts = partsService.selectOne(Long.parseLong(id));

			if (parts != null) {
				partsService.deleteByPrimaryKey(getCurrentUserName(), parts);
			} else {
				vo.setMsg("删除失败，记录不存在");
				vo.setSuccess(false);
				return vo;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("零部件信息删除失败", ex);

			vo.setMsg("删除失败，系统异常");
			vo.setSuccess(false);
			return vo;
		}
		return vo;
	}

}
