package cn.wow.support.web;

import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.RolePermission;
import cn.wow.common.service.AccountService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.RolePermissionService;
import cn.wow.support.utils.Contants;

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
	private AccountService accountService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private RolePermissionService rolePermissionService;

	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, Model model) {
		Account currentAccount = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);

		model.addAttribute("currentAccount", currentAccount);
		model.addAttribute("menuList", getPermission(currentAccount, request));
		
		return "index/index";
	}
	
	/**
	 * 获取当前角色的菜单
	 */
	public List<Menu> getPermission(Account account, HttpServletRequest request) {
		List<Menu> currentRoleMenu = (List<Menu>) request.getSession().getAttribute("currentRoleMenu");

		if (account != null && (currentRoleMenu == null || currentRoleMenu.size() < 1)) {
			List<Menu> menuList = menuService.getMenuList();
			Set<String> legalMenu = new HashSet<String>();

			RolePermission permission = rolePermissionService.selectOne(account.getRoleId());
			if (permission != null && StringUtils.isNotBlank(permission.getPermission())) {
				String[] vals = permission.getPermission().split(",");

				for (String per : vals) {
					String[] array = per.split("-");
					String key = array[0];
					String value = array[1];

					if (!"0".equals(value)) {
						legalMenu.add(key);
					}
				}

				Iterator<Menu> it = menuList.iterator();
				while (it.hasNext()) {
					Menu menu = it.next();
					List<Menu> subList = menu.getSubList();
					
					if (subList != null && subList.size() > 0) {
						Iterator<Menu> subIt = subList.iterator();
						while (subIt.hasNext()) {
							if (!legalMenu.contains(subIt.next().getAlias())) {
								subIt.remove();
							}
						}
						
						if (subList == null || subList.size() < 1) {
							it.remove();
						}
					} else {
						if (!legalMenu.contains(menu.getAlias())) {
							it.remove();
						}
					}
				}
			}

			request.getSession().setAttribute("currentRoleMenu", menuList);
			return menuList;
		}

		return currentRoleMenu;
	}

}
