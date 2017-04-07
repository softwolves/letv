package web;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

/**
 * 此Servlet仅用于在tomcat启动时，
 * 初始化一些参数，给其他的Servlet使用。
 * 因此此类中只有init()，而不需要service()。
 */
public class InitServlet extends HttpServlet {

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		//向context里存入流量，它是一个变量，
		//默认值是0。
		ServletContext ctx = getServletContext();
		ctx.setAttribute("count", 0);
	}

	
	
}






