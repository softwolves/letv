package ssh_day03;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.junit.Test;

import com.tedu.entity.User;

public class TestCase {
	@Test
	public void test1(){
		Configuration cfg =
			new Configuration();
		//读取数据库连接参数
		cfg.configure("hibernate.cfg.xml");
		SessionFactory factory =
				cfg.buildSessionFactory();
		//获取Session对象
		Session session = 
				factory.openSession();
		//session 可以自动生成SQL查询DB
		String id = "022ada2e14f544dbb49468b7cb6f3d42";
		User u=(User)session.get(
				User.class, id);
		System.out.println(u); 
		session.close();
	}
}




