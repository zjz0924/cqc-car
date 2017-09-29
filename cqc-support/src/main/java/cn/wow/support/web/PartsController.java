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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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

	private final static String DEFAULT_PAGE_SIZE = "10";

	@Autowired
	private PartsService partsService;
	
	@Value("${info.parts.url}")
	protected String partsUrl;
	
	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model) {
		model.addAttribute("defaultPageSize", DEFAULT_PAGE_SIZE);
		model.addAttribute("resUrl", resUrl);
		return "info/parts/parts_list";
	}

	/**
	 * 获取数据
	 */
	@ResponseBody
	@RequestMapping(value = "/getList")
	public Map<String, Object> getList(HttpServletRequest request, Model model, String code, String type,
			String startProTime, String endProTime, String name, String producer, String proNo, String matName,
			String matNo, String matProducer) {

		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "code asc");

		if (StringUtils.isNotBlank(code)) {
			map.put("qcode", code);
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
		if (StringUtils.isNotBlank(name)) {
			map.put("name", name);
		}
		if (StringUtils.isNotBlank(producer)) {
			map.put("producer", producer);
		}
		if (StringUtils.isNotBlank(proNo)) {
			map.put("proNo", proNo);
		}
		if (StringUtils.isNotBlank(matName)) {
			map.put("matName", matName);
		}
		if (StringUtils.isNotBlank(matNo)) {
			map.put("matNo", matNo);
		}
		if (StringUtils.isNotBlank(matProducer)) {
			map.put("matProducer", matProducer);
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
		model.addAttribute("resUrl", resUrl);
		return "info/parts/parts_detail";
	}

	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, String id, String code, String name, Integer type, String proTime,
			String remark, String producer, String place, String proNo, String technology,
			String matName, String matNo, String matColor, String matProducer, @RequestParam(value = "pic", required = false) MultipartFile file) {
		AjaxVO vo = new AjaxVO();
		Parts parts = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		try {
			if (StringUtils.isNotBlank(id)) {
				parts = partsService.selectOne(Long.parseLong(id));

				if (parts != null) {
					parts.setType(type);
					if(StringUtils.isNotBlank(proTime)){
						parts.setProTime(sdf.parse(proTime));
					}
					parts.setRemark(remark);
					parts.setProducer(producer);
					parts.setPlace(place);
					parts.setProNo(proNo);
					parts.setTechnology(technology);
					parts.setMatName(matName);
					parts.setMatNo(matNo);
					parts.setMatColor(matColor);
					parts.setMatProducer(matProducer);
					parts.setName(name);
					
					if (file != null && !file.isEmpty()) {
						String pic = uploadImg(file, partsUrl);
						parts.setPic(pic);
					}
					
					partsService.update(getCurrentUserName(), parts);
				}
				vo.setMsg("编辑成功");
			} else {
				Parts dbVehicle = partsService.selectByCodeAndType(code, type);

				if (dbVehicle != null) {
					vo.setData("code");
					vo.setMsg("代码已存在");
					vo.setSuccess(false);
					return vo;
				} else {
					parts = new Parts();
					parts.setType(type);
					
					if(StringUtils.isNotBlank(proTime)){
						parts.setProTime(sdf.parse(proTime));
					}
					parts.setRemark(remark);
					parts.setProducer(matProducer);
					parts.setPlace(place);
					parts.setProNo(proNo);
					parts.setTechnology(technology);
					parts.setMatName(matName);
					parts.setMatNo(matNo);
					parts.setMatColor(matColor);
					parts.setMatProducer(matProducer);
					parts.setName(name);
					parts.setCode(code);
					parts.setCreateTime(new Date());
					
					if (file != null && !file.isEmpty()) {
						String pic = uploadImg(file, partsUrl);
						parts.setPic(pic);
					}
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
