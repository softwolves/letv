package com.tarena.oss.service;
/**
 * 应用异常:
 * 	不是程序的问题，是不满足业务规则 
 * 引起的错误，比如用户输入了不正确的
 * 密码。
 *
 */
public class ApplicationException 
extends RuntimeException {

	public ApplicationException() {
		super();
	}

	public ApplicationException(
			String message) {
		super(message);
	}

	

}
