package com.tedu.cloudnote.dao;

import java.util.List;
import java.util.Map;

import com.tedu.cloudnote.entity.User;

public interface UserDao {
	public void save(User user);
	public User findByName(String name);
	public List<Map<String, Object>> 
		findAllUsers();
}



