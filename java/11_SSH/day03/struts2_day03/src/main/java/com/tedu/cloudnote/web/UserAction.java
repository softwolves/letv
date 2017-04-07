package com.tedu.cloudnote.web;

import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.tedu.cloudnote.entity.User;
import com.tedu.cloudnote.util.NoteResult;

@Controller
@Scope("prototype")
public class UserAction extends BaseAction{

	private String username;
	private String password;
	public void setPassword(String password) {
		this.password = password;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String login(){
		NoteResult result = 
				userService.checkLogin(
				username, password);
		this.result=result;
		if(result.getStatus()==0){
			User user=(User)result.getData();
			session.put("loginUser", user);
		}
		return "success";
	}
	
	private List<Map<String, Object>> list;
	public List<Map<String, Object>> getList() {
		return list;
	}
	public String list(){
		try{
			list=userService.findAll();
			return SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return ERROR;
		}
	}
}





