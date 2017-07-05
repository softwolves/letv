package com.tedu;

public class LoginAction {
	private String username;
	private String password;
	//getxxx setxxx 称为：Bean 属性访问方法
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}

	public String execute(){
		System.out.println(
			username + "," + password);
		//完整的登录逻辑...待续
		return "success";
	}
}








