package web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class SecondFilter implements Filter {

	public void destroy() {
		System.out.println("销毁SecondFilter");
	}

	public void doFilter(ServletRequest arg0, 
		ServletResponse arg1, FilterChain chain)
		throws IOException, ServletException {
		System.out.println("SecondFilter前");
		chain.doFilter(arg0, arg1);
		System.out.println("SecondFilter后");
	}

	//Tomcat启动时自动调用此方法，并且在调用前，
	//会给此Filter创建一个config对象，然后调用
	//config读取web.xml中的参数，传入进来。
	public void init(FilterConfig cfg) throws ServletException {
		System.out.println("初始化SecondFilter");
		System.out.println(
			cfg.getInitParameter("city"));
	}

}





