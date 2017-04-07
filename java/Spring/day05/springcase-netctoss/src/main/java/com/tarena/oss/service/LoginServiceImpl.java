package com.tarena.oss.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.tarena.oss.dao.AdminDAO;
import com.tarena.oss.entity.Admin;
/*
 * 业务实现类
 */
@Service("loginService")
public class LoginServiceImpl implements 
LoginService{
	@Resource(name="adminDAO")
	private AdminDAO dao;
	
	public Admin checkLogin(
			String adminCode, 
			String pwd) {
		/*
		 * 查询数据库,如果有满足条件的
		 * 记录，返回一个完整的Admin对象
		 * (表示登录成功)。否则，抛出相应
		 * 的应用异常。
		 */
		Admin admin = 
				dao.findByAdminCode(adminCode);
		if(admin == null){
			//帐号不存在
			throw new ApplicationException(
					"帐号不存在");
		}
		if(!admin.getPassword().equals(pwd)){
			throw new ApplicationException(
					"密码错误");
		}
		//登录成功
		return admin;
	}

}
