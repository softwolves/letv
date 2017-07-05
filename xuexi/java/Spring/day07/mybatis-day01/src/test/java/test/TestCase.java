package test;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Before;
import org.junit.Test;

import entity.Emp;
import entity.Emp2;

public class TestCase {
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
	public void test1(){
		Emp emp = new Emp();
		emp.setEname("King");
		emp.setAge(22);
		session.insert("save", 
				emp);
		//插入，修改和删除操作，必须要提交事务。
		session.commit();
		//使用完必须关闭。
		session.close();
	}
	
	@Test
	public void test2(){
		List<Emp> emps = 
				session.selectList(
						"findAll");
		System.out.println(emps);
	}
	
	@Test
	public void test3(){
		Emp e = session.selectOne(
				"findById", 2);
		System.out.println(e);
	}
	
	@Test
	public void test4(){
		Emp e = session.selectOne(
				"findById", 2);
		e.setAge(e.getAge() * 2);
		session.update("modify", e);
		session.commit();
		session.close();
	}
	
	@Test
	public void test5(){
		session.delete("delete",2);
		session.commit();
		session.close();
	}
	
	@Test
	public void test6(){
		Map data = 
				session.selectOne(
						"findById2", 21);
		//oracle会将字段名变成大写形式。
		System.out.println(
				data.get("ENAME"));
		session.close();
	}
	
	@Test
	public void test7(){
		Emp2 emp2 = 
				session.selectOne(
						"findById3",
						21);
		System.out.println(emp2);
	}
	
	
	
	
	
}
