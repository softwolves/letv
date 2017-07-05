package test;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import ioc.MessageBean;

/**
 * 测试类
 *
 */
public class TestCase {
	@Test
	//测试引用方式注入集合类型的值。
	public void test1(){
		//启动spring容器
		ApplicationContext ac = 
		new ClassPathXmlApplicationContext(
		"applicationContext.xml");
		//通过容器获得一个bean实例
		MessageBean mb = 
				ac.getBean("msg",
						MessageBean.class);
		System.out.println(mb);
	}
	
	@Test
	//测试 读取properties文件的内容。
	public void test2(){
		//启动spring容器
		ApplicationContext ac = 
		new ClassPathXmlApplicationContext(
		"applicationContext.xml");
		//通过容器获得一个bean实例
		System.out.println(
				ac.getBean("config"));
	}
	
	@Test
	//测试 spring表达式读取其它bean的属性。
	public void test3(){
		//启动spring容器
		ApplicationContext ac = 
		new ClassPathXmlApplicationContext(
		"applicationContext.xml");
		//通过容器获得一个bean实例
		System.out.println(
				ac.getBean("eb"));
	}
	
	
	
	
	
	
}
