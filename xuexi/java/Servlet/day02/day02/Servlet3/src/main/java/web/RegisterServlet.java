package web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {

	@Override
	protected void service(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		//1.接收请求数据
		String name = req.getParameter("userName");
		String pwd = req.getParameter("password");
		String sex = req.getParameter("sex");
		String[] interests = 
			req.getParameterValues("interest");
		//2.处理业务
		System.out.println(name);
		System.out.println(pwd);
		System.out.println(sex);
		if(interests != null) {
			for(String interest : interests) {
				System.out.println(interest);
			}
		}
		//3.发送响应数据
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		out.println("<p>注册成功</p>");
		out.close();
	}

	
	
}








