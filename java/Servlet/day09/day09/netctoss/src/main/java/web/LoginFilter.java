package web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter {

	public void destroy() {

	}

	public void doFilter(ServletRequest req, 
		ServletResponse res, FilterChain chain)
		throws IOException, ServletException {
		//Tomcat是基于HTTP协议的，它说创建的
		//request和response都是和HTTP相关的。
		//因此可以将他们进行转型。
		HttpServletRequest request = 
			(HttpServletRequest) req;
		HttpServletResponse response = 
			(HttpServletResponse) res;
		//判断当前请求是否为需要排除检查的请求，
		//如果是，则不对此请求进行检查。
		String p = request.getServletPath();
		for(String path : paths) {
			if(p.equals(path)) {
				//当前请求不需要检查，
				//让请求继续执行即可。
				chain.doFilter(request, response);
				return;
			}
		}
		//尝试从session中获取账号
		HttpSession session = request.getSession();
		String adminCode = (String)
			session.getAttribute("adminCode");
		if(adminCode == null) {
			//未登录，重定向到登录页面
			response.sendRedirect(
				request.getContextPath()+"/toLogin.do");
		} else {
			//已登录，请求继续执行
			chain.doFilter(request, response);
		}
	}

	//需要排除检查的请求路径
	private String[] paths;
	
	public void init(FilterConfig cfg) throws ServletException {
		String excludePath = 
			cfg.getInitParameter("excludePath");
		paths = excludePath.split(",");
	}

}




