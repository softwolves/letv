package com.tarena.test;

import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.tedu.cloudnote.dao.UserDao;
import com.tedu.cloudnote.entity.User;

public class TestCase {
	@Test
	public void testUser(){
		ClassPathXmlApplicationContext ctx=
			new ClassPathXmlApplicationContext(
			"spring-aop.xml", 
			"spring-context.xml",
			"spring-mybatis.xml",
			"spring-transaction.xml");
		UserDao dao=ctx.getBean(
				"userDao", UserDao.class);
		User user=dao.findByName("tedu");
		System.out.println(user);
	}
}








