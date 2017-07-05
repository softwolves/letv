package test;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestCase {
	@Test
	//测试DataSource
	public void test1() throws SQLException{
		ApplicationContext ac = 
	new ClassPathXmlApplicationContext(
			"spring-mvc.xml");
		DataSource ds = 
				ac.getBean("ds",
						DataSource.class);
		System.out.println(
				ds.getConnection());
		
		
	}
}
