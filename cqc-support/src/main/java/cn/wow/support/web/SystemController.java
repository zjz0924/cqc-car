package cn.wow.support.web;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.wow.common.domain.Menu;
import cn.wow.common.service.MenuService;

@Controller
@RequestMapping(value = "system")
public class SystemController {
	
	@Autowired
	private MenuService menuService;

	@RequestMapping(value = "/index")
	public String index(HttpServletRequest httpServletRequest, Model model, String choose) {
		Menu menu = menuService.selectByAlias("system");
		
		if(StringUtils.isBlank(choose)){
			choose = "0";
		}
		
		model.addAttribute("choose", Integer.parseInt(choose));
		model.addAttribute("menu", menu);
		return "sys/index";
	}
	
}
