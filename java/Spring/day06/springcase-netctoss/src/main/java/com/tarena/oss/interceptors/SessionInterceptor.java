package com.tarena.oss.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * 用来做session验证的拦截器
 */
public class SessionInterceptor implements 
HandlerInterceptor{

	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
	}

	public boolean preHandle(
			HttpServletRequest req, 
			HttpServletResponse res,
			Object arg2) throws Exception {
		System.out.println("preHandle()...");
		HttpSession session  =
				req.getSession();
		Object obj = 
				session.getAttribute("admin");
		if(obj == null){
			//没有登录，重定向到登录页面。
			res.sendRedirect("toLogin.do");
			return false;
		}
		//登录成功。
		return true;
	}
	
}





