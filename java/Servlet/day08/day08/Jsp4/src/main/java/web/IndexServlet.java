package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IndexServlet extends HttpServlet {

	@Override
	protected void service(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		//从cookie中获取数据
		Cookie[] cookies = req.getCookies();
		if(cookies != null) {
			res.setContentType(
				"text/html;charset=utf-8");
			PrintWriter out = res.getWriter();
			for(Cookie c : cookies) {
				//修改某cookie
				if(c.getName().equals("user")) {
					c.setValue(c.getValue()+"~");
					//设置超时时间
					c.setMaxAge(6000);
					//设置有效路径
					c.setPath(req.getContextPath());
					res.addCookie(c);
				}
				//显示这些数据
				out.println("<p>");
				out.println(
					c.getName()+":"+
					URLDecoder.decode(
					c.getValue(), "utf-8"));
				out.println("</p>");
			}
			out.close();
		}
	}
	
}




