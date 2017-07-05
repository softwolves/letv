package web;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet {

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		System.out.println(
			config.getInitParameter("maxOnline"));
	}

	@Override
	protected void service(
		HttpServletRequest arg0, 
		HttpServletResponse arg1) throws ServletException, IOException {
		ServletConfig config = getServletConfig();
		System.out.println(
			config.getInitParameter("maxOnline"));
		System.out.println("这里进行登录");
	}

	
	
}




