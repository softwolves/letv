package web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

	@Override
	protected void service(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		String user = req.getParameter("user");
		//首次访问该项目时，Tomcat会自动给这个
		//浏览器创建一个session，并使用request
		//引用这个session。
		HttpSession session = req.getSession();
		//session中可以存任意类型的数据
		session.setAttribute("user", user);
		//响应时服务器会自动给浏览器传session的ID
		res.sendRedirect("index");
	}
	
}







