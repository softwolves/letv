package web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * 	1.Filter用来处理多个请求之间的共性业务。
 *    如记录日志、过滤敏感词等。
 *	2.使用Filter解决问题，不用修改任何Servlet，
 *	   只需要新建Filter并配置即可，可以极大程度
 *    的降低业务代码和Servlet之间的耦合度。
 */
public class FirstFilter implements Filter {

	//在Tomcat关闭时自动销毁Filter
	public void destroy() {
		System.out.println("销毁FirstFilter");
	}

	public void doFilter(ServletRequest req, 
		ServletResponse res, FilterChain chain)
		throws IOException, ServletException {
		System.out.println("FirstFilter前");
		//调用doFilter()是让请求继续执行，
		//若没有调用此方法则请求中断，直接响应。
		//请求继续执行，会调用后续的Filter，
		//并最终调用Servlet。在此过程中Filter
		//与Filter之间的有序调用的，并且任何
		//Filter将请求中断，都会导致后续的Filter
		//无法执行，他们关系像链条一样，环环相扣，
		//因此该对象叫做过滤链FilterChain。
		//详见过滤器调用过程图。
		chain.doFilter(req, res);
		System.out.println("FirstFilter后");
	}

	//Filter在Tomcat启动时只创建并初始化一次，
	//所以它是单例的。
	public void init(FilterConfig arg0) throws ServletException {
		System.out.println("初始化FirstFilter");
	}

}



