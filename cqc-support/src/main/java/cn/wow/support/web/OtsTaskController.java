package cn.wow.support.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import cn.wow.common.domain.Material;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.Parts;
import cn.wow.common.domain.Vehicle;
import cn.wow.common.service.InfoService;
import cn.wow.common.service.MenuService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;

@Controller
@RequestMapping(value = "ots")
public class OtsTaskController extends AbstractController {
	
	Logger logger = LoggerFactory.getLogger(PartsController.class);
	
	// 零部件图片上传图片
	@Value("${info.parts.url}")
	protected String partsUrl;
	
	// 原材料图片上传路径
	@Value("${info.material.url}")
	protected String materialUrl;
	
	@Autowired
	private MenuService menuService;
	@Autowired
	private InfoService infoService;

	/**
	 * 首页
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model, String choose) {
		HttpSession session = request.getSession();
		
		Menu menu = menuService.selectByAlias("otsTask");
		// 没有权限的菜单
		Set<Long> illegalMenu = (Set<Long>) session.getAttribute(Contants.CURRENT_ILLEGAL_MENU);
		
		if (menu != null && menu.getSubList() != null && menu.getSubList().size() > 0) {
			Iterator<Menu> it = menu.getSubList().iterator();
			while (it.hasNext()) {
				Menu subMenu = it.next();
				if (illegalMenu.contains(subMenu.getId())) {
					it.remove();
				}
			}
		}
		
		if(StringUtils.isBlank(choose)){
			choose = "0";
		}
		model.addAttribute("choose", Integer.parseInt(choose));
		
		ObjectMapper mapper = new ObjectMapper();  
        try {
			String json = mapper.writeValueAsString(menu.getSubList());
			model.addAttribute("menu", json);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}  
		return "task/ots/index";
	}
	
	
	/**
	 * 任务申请
	 */
	@RequestMapping(value = "/require")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "task/ots/require";
	}
	
	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, String v_code, String v_type, String v_proTime,
			String v_proAddr, String v_remark, String p_code, String p_name, String p_producer, String p_proTime,
			String p_place, String p_proNo, String p_technology, String p_matName, String p_matNo, String p_matColor,
			String p_matProducer, String p_remark, String m_matName, String m_matColor, String m_proNo,
			String m_matProducer, String m_matNo, String m_producerAdd, String m_remark,
			@RequestParam(value = "p_pic", required = false) MultipartFile pfile,
			@RequestParam(value = "m_pic", required = false) MultipartFile mfile) {
		
		AjaxVO vo = new AjaxVO();
		
		try {
			Date date = new Date();
			
			// 整车信息
			Vehicle vehicle = new Vehicle();
			vehicle = new Vehicle();
			vehicle.setType(v_type);
			vehicle.setCode(v_code);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			vehicle.setProTime(sdf.parse(v_proTime));
			vehicle.setProAddr(v_proAddr);
			vehicle.setRemark(v_remark);
			vehicle.setState(Contants.ONDOING_TYPE);
			vehicle.setCreateTime(date);
			
			// 零部件信息
			Parts parts = new Parts();
			parts.setType(Contants.STANDARD_TYPE);
			parts.setProTime(sdf.parse(p_proTime));
			parts.setRemark(p_remark);
			parts.setProducer(p_matProducer);
			parts.setPlace(p_place);
			parts.setProNo(p_proNo);
			parts.setTechnology(p_technology);
			parts.setMatName(p_matName);
			parts.setMatNo(p_matNo);
			parts.setMatColor(p_matColor);
			parts.setMatProducer(p_matProducer);
			parts.setName(p_name);
			parts.setCode(p_code);
			parts.setCreateTime(date);
			parts.setState(Contants.ONDOING_TYPE);
			if (pfile != null && !pfile.isEmpty()) {
				String pic = uploadImg(pfile, partsUrl);
				parts.setPic(pic);
			}
			
			// 原材料信息
			Material material = new Material();
			material.setType(Contants.STANDARD_TYPE);
			material.setRemark(m_remark);
			material.setProNo(m_proNo);
			material.setMatName(m_matName);
			material.setMatNo(m_matNo);
			material.setMatColor(m_matColor);
			material.setMatProducer(m_matProducer);
			material.setProducerAdd(m_producerAdd);
			material.setCreateTime(date);
			material.setState(Contants.ONDOING_TYPE);
			
			if (mfile != null && !mfile.isEmpty()) {
				String pic = uploadImg(mfile, materialUrl);
				material.setPic(pic);
			}
			
			infoService.insert(vehicle, parts, material, Contants.STANDARD_TYPE);
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("OTS任务申请失败", ex);
			
			vo.setSuccess(false);
			vo.setMsg("保存失败，系统异常");
		}
		
		vo.setSuccess(true);
		vo.setMsg("保存成功");
		return vo;
	}
}
