package web;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FindDeptServlet extends HttpServlet {

	@Override
	protected void service(
		HttpServletRequest arg0, 
		HttpServletResponse arg1) throws ServletException, IOException {
		//使用context获取web.xml中预置的参数，
		//该对象中的数据可以被所有的Servlet共用。
		ServletContext ctx = getServletContext();
		System.out.println(
			ctx.getInitParameter("size"));
		//使用context获取tomcat启动时初始化的变量，
		//并将其+1，再设置回context。
		Object obj = ctx.getAttribute("count");
		int c = new Integer(obj.toString())+1;
		ctx.setAttribute("count", c);
		//获取context中最新的变量
		System.out.println(
			ctx.getAttribute("count"));
		
	}

	
	
}




