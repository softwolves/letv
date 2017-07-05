package com.tedu.util;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {
	private static SessionFactory factory;
	static{
		//加载hibernate.cfg.xml主配置文件
		Configuration conf = new Configuration();
		conf.configure("hibernate.cfg.xml");
		//获取SessionFactory
		factory = conf.buildSessionFactory();
	}
	
	public static Session getSession(){
		//获取Session
		Session session = factory.openSession();
		return session;
	}
	
}
