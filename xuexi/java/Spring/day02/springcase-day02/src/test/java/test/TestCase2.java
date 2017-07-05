package test;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import annotation.Hotel;
import annotation.Manager;
import annotation.Restaurant;
import annotation.Student;

public class TestCase2 {
	@Test
	//测试 组件扫描
	public void test1(){
		ApplicationContext ac = 
		new ClassPathXmlApplicationContext(
				"app.xml");
		Student stu = 
				ac.getBean("stu",Student.class);
		System.out.println(stu);
	}
	
	@Test
	//测试 作用域
	public void test2(){
		ApplicationContext ac = 
		new ClassPathXmlApplicationContext(
				"app.xml");
		Student stu = 
				ac.getBean("stu",Student.class);
		Student stu2 = 
				ac.getBean("stu",Student.class);
		System.out.println(stu == stu2);
	}
	
	@Test
	//测试 延迟加载
	public void test3(){
		ApplicationContext ac = 
		new ClassPathXmlApplicationContext(
				"app.xml");
		
	}
	
	@Test
	//测试 生命周期相关的方法。
	public void test4(){
		AbstractApplicationContext ac = 
		new ClassPathXmlApplicationContext(
				"app.xml");
		Student stu = 
				ac.getBean("stu",Student.class);
		System.out.println(stu);
		ac.close();
	}
	
	@Test
	//测试 @Autowired来完成注入。
	public void test5(){
		ApplicationContext ac = 
		new ClassPathXmlApplicationContext(
				"app.xml");
		Restaurant rest = 
				ac.getBean("rest",
						Restaurant.class);
		System.out.println(rest);
		Hotel hotel = 
				ac.getBean("hotel",Hotel.class);
		System.out.println(hotel);
	}
	
	@Test
	//测试 @Resource来完成注入。
	public void test6(){
		ApplicationContext ac = 
		new ClassPathXmlApplicationContext(
				"app.xml");
		Manager mg = ac.getBean("manager",
				Manager.class);
		System.out.println(mg);
	}
	
	@Test
	//测试 @Value。
	public void test7(){
		ApplicationContext ac = 
		new ClassPathXmlApplicationContext(
				"app.xml");
		Manager mg = ac.getBean("manager",
				Manager.class);
		System.out.println(mg);
	}
	
	
	
	
}
