package cn.wow.support.shiro.filter;

import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.RolePermission;
import cn.wow.common.service.AccountService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.OperationLogService;
import cn.wow.common.service.RolePermissionService;
import cn.wow.common.utils.operationlog.ClientInfo;
import cn.wow.common.utils.operationlog.OperationType;
import cn.wow.common.utils.operationlog.ServiceType;
import cn.wow.support.utils.Contants;

public class FormAuthenticationExtendFilter extends FormAuthenticationFilter {
	private static Logger logger = LoggerFactory.getLogger(FormAuthenticationExtendFilter.class);

	@Autowired
	private AccountService accountService;
	@Autowired
	private OperationLogService operationLogService;
	@Autowired
	private RolePermissionService rolePermissionService;
	@Autowired
	private MenuService menuService;

	@Override
	protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request,
			ServletResponse response) throws Exception {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;

		String successUrl = "/index";

		/* //成功登录后返回成功跳转页面，指定跳转地址 */
		WebUtils.issueRedirect(request, response, successUrl);

		// 成功登录后返回成功跳转页面
		// issueSuccessRedirect(request, response);

		String username = (String) SecurityUtils.getSubject().getPrincipal();
		if (StringUtils.isNotBlank(username)) {
			Account account = accountService.selectByAccountName(username);
			
			httpServletRequest.getSession().setAttribute(Contants.CURRENT_ACCOUNT, account);
			
			//菜单信息
			httpServletRequest.getSession().setAttribute(Contants.MENU_LIST, getPermission(account));
			
			// 判断用户客户端信息
			createOrUpdateClientInfo(username, request.getRemoteAddr(), httpServletRequest.getHeader("user-agent"));
			// 添加日志
			operationLogService.save(username, OperationType.LOGIN, ServiceType.ACCOUNT, "");
		}

		return false;
	}

	private void createOrUpdateClientInfo(String userName, String clientIp, String userAgent) {
		ClientInfo clientInfo = new ClientInfo();
		clientInfo.setClientIp(clientIp);
		clientInfo.setUserAgent(userAgent);
		operationLogService.createOrUpdateUserClientInfo(userName, clientInfo);
	}
	
	
	/**
	 * 获取当前角色的菜单
	 */
	private List<Menu> getPermission(Account account) {
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
						Menu subMenu = subIt.next();
						if (!legalMenu.contains(subMenu.getAlias())) {
							subMenu.setAuthorized(false);
						}
					}

					if (subList == null || subList.size() < 1) {
						menu.setAuthorized(false);
					}
				} else {
					if (!legalMenu.contains(menu.getAlias())) {
						menu.setAuthorized(false);
					}
				}
			}
		}else{
			for (Menu menu : menuList) {
				menu.setAuthorized(false);
			}
		}

		return menuList;
	}

}
