package test;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Before;
import org.junit.Test;

import dao.EmpDAO;
import entity.Emp;

public class TestCase2 {
	private SqlSession session;
	@Before
	public void init(){
		SqlSessionFactoryBuilder 
		ssfb = 
		new SqlSessionFactoryBuilder();
	SqlSessionFactory ssf = 
		ssfb.build(
		TestCase.class.getClassLoader().
		getResourceAsStream(
						"SqlMapConfig.xml"));
		//SqlSession是执行sql的容器。
		session = 
			ssf.openSession();
	}
	
	@Test
	//测试 Mapper映射器
	public void test1(){
		//getMapper方法会返回一个实现了
		//EmpDAO接口要求的对象。
		EmpDAO dao = 
				session.getMapper(
						EmpDAO.class);
		Emp e = new Emp();
		e.setEname("Eric");
		e.setAge(22);
		dao.save(e);
		session.commit();
		session.close();
	}
	
	@Test
	public void test2(){
		EmpDAO dao = 
				session.getMapper(EmpDAO.class);
		List<Emp> emps = 
				dao.findAll();
		System.out.println(emps);
	}
	
	@Test
	public void test3(){
		EmpDAO dao = 
				session.getMapper(EmpDAO.class);
		Emp emp = 
				dao.findById(21);
		System.out.println(emp);
	}
	
	@Test
	public void test4(){
		EmpDAO dao = 
				session.getMapper(EmpDAO.class);
		Emp emp = 
				dao.findById(21);
		emp.setAge(emp.getAge() * 2);
		dao.modify(emp);
		session.commit();
		session.close();
	}
	
	
	
	
	
	
}
