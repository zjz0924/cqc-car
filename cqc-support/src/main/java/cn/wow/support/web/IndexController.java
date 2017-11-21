package cn.wow.support.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.EmailRecord;
import cn.wow.common.service.EmailRecordService;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageMap;

/**
 * 首页控制器
 * 
 * @author zhenjunzhuo
 */
@Controller
@RequestMapping(value = "")
public class IndexController {

	private static Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	@Autowired
	private EmailRecordService emailRecordService;
	
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, Model model) {
		
		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
		
		if(account != null) {
			// 未读消息
			Map<String, Object> map = new PageMap(false);
			map.put("addr", account.getEmail());
			map.put("state", 1);
			List<EmailRecord> dataList = emailRecordService.selectAllList(map);
			
			int unread = 0;
			if (dataList != null && dataList.size() > 0) {
				unread = dataList.size();
			}
			model.addAttribute("unread", unread);
		}
		return "index/index";
	}
	
	
	

}
