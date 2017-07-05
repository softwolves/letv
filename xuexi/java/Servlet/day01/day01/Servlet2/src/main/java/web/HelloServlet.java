package web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloServlet extends HttpServlet {

	@Override
	protected void service(
		HttpServletRequest req, 
		HttpServletResponse res) 
		throws ServletException, IOException {
		//1.使用request接收请求数据
		
		//2.使用response发送响应数据
		//2.1设置状态行
		//该数据由Tomcat自动设置
		//2.2设置消息头
		res.setContentType("text/html");
		//2.3设置实体内容
		PrintWriter out = res.getWriter();
		out.println("<h1>Hello</h1>");
		out.close();
	}

	

}








