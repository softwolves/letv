package com.tedu;

import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionContext;

public class Login2Action 
	implements SessionAware, RequestAware{
	
	private Map<String, Object> session;
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	
	private Map<String, Object> request;
	public void setRequest(
			Map<String, Object> req) {
		this.request = req;
	}
	
	private User user;
	public void setUser(User user) {
		this.user = user;
	}
	public User getUser() {
		return user;
	}
	public String execute(){
		/*
		 * 利用ActionContext 对象可以
		 * 获取当前环境中的所有信息
		 * 	 session
		 *   request
		 *   application 
		 *   ...
		 */
		//ActionContext context = 
		//		ActionContext.getContext();
		//HttpSession.setAttribute(k,v);
		//Map<String, Object> session=
		//		context.getSession();
		//session.put("name", "Jerry");
		
		System.out.println(user); 
		//登录逻辑
		//1. 获取表单信息
		//2. 调用业务层 验证表单信息
		//3. 登录成功
		//   1. 保存用户信息到session！！！
		//   2. 转发到登录成功页面
		//4. 登录失败
		//   1. 返回到登录页面
		if(user.getId().equals("robin")
			&& user.getPwd().equals("123")){
			//登录成功
			//将用户信息保存到session
			session.put("loginUser", user);
			//转发到ok.jsp
			return "success";	
		}
		//登录失败：转发返回login2.jsp
		request.put("message",
				"你想好了！！！");
		return "error";
	}
	
}



