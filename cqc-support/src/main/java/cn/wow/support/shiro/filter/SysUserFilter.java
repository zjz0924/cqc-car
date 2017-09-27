package cn.wow.support.shiro.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.web.filter.PathMatchingFilter;
import org.springframework.beans.factory.annotation.Autowired;

import cn.wow.common.error.exceptions.MSAForbiddenException;

/**
 * 可用于更新数据
 * @author zhenjunzhuo
 */
public class SysUserFilter extends PathMatchingFilter {

    @Override
    protected boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
    	HttpServletRequest httpServletRequest = (HttpServletRequest) request;
    	HttpServletResponse httpServletResponse = (HttpServletResponse) response;
		
		String uri = httpServletRequest.getRequestURI();

		/*if(uri.contains("role")){
			// 会跳转到403页面
			httpServletResponse.sendError(403);
		}*/
		
        return true;
    }
}
