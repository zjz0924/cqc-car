package cn.wow.support.shiro.filter;

import java.util.Set;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.web.filter.PathMatchingFilter;
import org.springframework.beans.factory.annotation.Autowired;

import cn.wow.common.error.exceptions.MSAForbiddenException;
import cn.wow.support.utils.Contants;

/**
 * 可用于更新数据
 * @author zhenjunzhuo
 */
public class SysUserFilter extends PathMatchingFilter {

    @Override
    protected boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
    	HttpServletRequest httpServletRequest = (HttpServletRequest) request;
    	HttpServletResponse httpServletResponse = (HttpServletResponse) response;
    	HttpSession session = httpServletRequest.getSession();
    	
    	// 当前访问路径
		String uri = httpServletRequest.getRequestURI();

		// 没有权限的菜单别名
		Set<String> illegalMenu = (Set<String>) session.getAttribute(Contants.CURRENT_ILLEGAL_MENU);
		if(illegalMenu != null && illegalMenu.size() > 0){
			for(String alias: illegalMenu){
				if(uri.contains(alias)){
					httpServletResponse.sendError(403);
					break;
				}
			}
		}
        return true;
    }
}
