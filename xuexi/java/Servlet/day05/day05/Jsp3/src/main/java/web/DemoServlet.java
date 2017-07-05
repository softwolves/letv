package web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Course;
import entity.Student;

public class DemoServlet extends HttpServlet {

	@Override
	protected void service(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		//模拟查询学生数据
		Student s = new Student();
		s.setName("cang");
		s.setAge(18);
		s.setSex("F");
		s.setInterests(
			new String[]{"讲课","拍片","玩"});
		Course c = new Course();
		c.setId(1);
		c.setCourseName("Java");
		c.setDays(80);
		s.setCourse(c);
		//转发到JSP
		//当前：/Jsp3/demo
		//目标：/Jsp3/demo.jsp
		req.setAttribute("stu", s);
		req.getRequestDispatcher(
			"demo.jsp").forward(req, res);
	}

	
	
}







