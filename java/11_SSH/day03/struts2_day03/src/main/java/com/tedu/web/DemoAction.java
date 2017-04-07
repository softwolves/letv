package com.tedu.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.util.ValueStack;

@Controller
public class DemoAction {
	
	String message;
	public String getMessage() {
		return message;
	}
	
	public String test(){
		ActionContext context = 
			ActionContext.getContext();
		ValueStack stack=context.getValueStack();
		
 		Person p = new Person(
				1, "Jerry", "Hello Jerry");
		stack.push(p); 
		
		context.getSession()
			.put("loginName", "Robin");
		
		message = "demo";
		System.out.println(
			"Demo Action test()");
		return "success";
	}
}
