package com.tarena.oss.dao;

import com.tarena.oss.entity.Admin;

/**
 * DAO接口
 *	注意：接口方法不要涉及任何具体的技术。
 */
public interface AdminDAO {
	public Admin findByAdminCode(String 
			adminCode);
}




