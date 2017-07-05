package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

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
		//1.1接收请求行
		System.out.println(
			"请求类型:"+req.getMethod());
		System.out.println(
			"Servlet路径:"+req.getServletPath());
		System.out.println(
			"协议类型:"+req.getProtocol());
		//1.2接收消息头
		//消息头中的数据按照键值对来存储，是可以遍历的。
		//headNames是key的迭代器
		Enumeration<String> e = req.getHeaderNames();
		while(e.hasMoreElements()) {
			String key = e.nextElement();
			String value = req.getHeader(key);
			System.out.println(
					key + ":" + value);
		}
		//1.3接收实体内容
		//本次请求没有发送业务数据，实体内容为空
		
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








