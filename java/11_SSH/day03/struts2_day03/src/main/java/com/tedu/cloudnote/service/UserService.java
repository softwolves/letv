package com.tedu.cloudnote.service;

import java.util.List;
import java.util.Map;

import com.tedu.cloudnote.util.NoteResult;

public interface UserService {
	public NoteResult addUser(
		String name,String nick,String password);
	public NoteResult checkLogin(
		String name,String password);
	
	List<Map<String, Object>> findAll();
}





