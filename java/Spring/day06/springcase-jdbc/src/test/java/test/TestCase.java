package test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import dao.EmpDAO;
import entity.Emp;

public class TestCase {
	private EmpDAO dao;
	@Before
	//测试方法(也就是被@Test修饰的方法)
	//执行之前，会先执行@Before修饰的方法)
	public void init(){
		ApplicationContext ac =
		new ClassPathXmlApplicationContext(
						"spring-mvc.xml");
		dao = 
				ac.getBean("empDAO",
						EmpDAO.class);
	}
	
	@Test
	public void test1(){
		Emp emp = new Emp();
		emp.setEname("Sally");
		emp.setAge(28);
		dao.save(emp);
	}
	
	@Test 
	public void test2(){
		List<Emp> emps = 
				dao.findAll();
		System.out.println(emps);
	}
	
	@Test
	public void test3(){
		Emp e = dao.findById2(1);
		System.out.println(e);
	}
	
	@Test
	public void test4(){
		Emp e = dao.findById2(1);
		e.setAge(e.getAge() * 2);
		dao.modify(e);
	}
	
	@Test
	public void test5(){
		dao.delete(1);
	}
	
	@Test
	public void test6(){
		System.out.println(
				dao.getTotalRows());
	}
	
	
	
}
