package web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HiServlet extends HttpServlet {
	
	private Double sal = 1000.0;

	@Override
	protected void service(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		synchronized(this) {
			//加薪
			sal += 100.0;
			//假设网络延迟8S
			try {
				Thread.sleep(8000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			//输出给浏览器
			res.setContentType(
					"text/html;charset=utf-8");
			PrintWriter out = res.getWriter();
			out.println("<p>工资:"+sal+"</p>");
			out.close();
		}
	}

	
	
}






