package test;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import dao.EmpDAO;
import entity.Emp;

public class TestCase {
	@Test
	public void test1(){
		ApplicationContext ac =
	new ClassPathXmlApplicationContext(
			"spring-mvc.xml");
		EmpDAO  dao = 
				ac.getBean("empDAO",
						EmpDAO.class);
		List<Emp> emps = 
				dao.findAll();
		System.out.println(emps);
	}
}






