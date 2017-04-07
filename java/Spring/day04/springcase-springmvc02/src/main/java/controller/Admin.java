package controller;
/**
 * 1. 属性名要与请求参数名一致。
 * 2. 这些属性要有对应的get/set方法。
 *
 */
public class Admin {
	private String adminCode;
	private String pwd;
	public String getAdminCode() {
		return adminCode;
	}
	public void setAdminCode(String adminCode) {
		this.adminCode = adminCode;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
}
