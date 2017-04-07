package com.tedu;

public class HelloAction {
	private String message;
	public String getMessage() {
		return message;
	}
	/**
	 * 方法名必须是execute
	 */
	public String execute(){
		message = "Hi";
		System.out.println("Hello World!"); 
		//返回值时候success
		return "success";
	}
}
