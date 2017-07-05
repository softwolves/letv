package com.tedu.cloudnote.web;

import java.io.Serializable;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.interceptor.ApplicationAware;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;
import com.tedu.cloudnote.service.UserService;
import com.tedu.cloudnote.util.NoteResult;

public abstract class BaseAction
	extends ActionSupport
	implements Serializable,
	SessionAware, RequestAware,
	ApplicationAware{
	
	protected Map<String, Object> request;
	protected Map<String, Object> session;
	protected Map<String, Object> application;
	
	public void setRequest(
			Map<String, Object> request) {
		this.request=request;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public void setApplication(Map<String, Object> application) {
		this.application = application;
	}
	
	@Resource
	protected UserService userService;

	/** JSON 返回值 **/
	protected NoteResult result;
	public NoteResult getResult() {
		return result;
	}
	public void setResult(NoteResult result) {
		this.result = result;
	}

}








