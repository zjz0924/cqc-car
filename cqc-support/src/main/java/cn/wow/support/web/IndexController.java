package cn.wow.support.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 首页控制器
 * 
 * @author zhenjunzhuo
 */
@Controller
@RequestMapping(value = "")
public class IndexController {

	private static Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, Model model) {
		
		return "index/index";
	}
	
	
	

}
