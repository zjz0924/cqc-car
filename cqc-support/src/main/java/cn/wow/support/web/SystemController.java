package cn.wow.support.web;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "system")
public class SystemController {

	@RequestMapping(value = "/index")
	public String index(HttpServletRequest httpServletRequest, Model model) {
		
		return "sys/index";
	}
	
}
