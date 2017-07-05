package com.tarena.oss.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tarena.oss.entity.Admin;
import com.tarena.oss.service.ApplicationException;
import com.tarena.oss.service.LoginService;

/**
 * 处理器类(二级控制器)
 *
 */
@Controller   
public class LoginController {
	@Resource(name="loginService")
	private LoginService service;
	
	@RequestMapping("/toLogin.do")
	public String toLogin(){
		return "login";
	}
	
	@ExceptionHandler
	//异常处理方法，用来处理其它方法所抛出的
	//异常。
	public String execute(Exception e,
			HttpServletRequest request){
		//应用异常
		if(e instanceof ApplicationException){
			request.setAttribute("login_failed",
					e.getMessage());
			return "login";
		}
		//系统异常
		return "error";
	}
	
	@RequestMapping("/login.do")
	public String login(
			HttpServletRequest request,
			HttpSession session){
		//读取帐号和密码
		String adminCode = 
				request.getParameter("adminCode");
		String pwd = 
				request.getParameter("pwd");
		System.out.println("adminCode:" 
				+ adminCode + " pwd:" + pwd);
		//调用业务层代码来处理登录
		
			Admin admin = 
					service.checkLogin(
							adminCode, pwd);
			//登录成功之后，绑订一些数据到
			//session对象上。
			session.setAttribute("admin", admin);
			return "redirect:toIndex.do";
	}
	
	@RequestMapping("/toIndex.do")
	public String toIndex(){
		
		return "index";
	}
	
	
	
}











