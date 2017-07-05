package web;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet {

	@Override
	protected void service(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		//获取传入的参数
		String user = req.getParameter("user");
		
		//将其存入cookie，便于后续功能中显示它。
		//1个cookie只能存一组键值对，而且值
		//必须是字符串。
		Cookie c1 = new Cookie("user",user);
		//设置cookie过期时间，
		//超时浏览器会自动删除它。
		c1.setMaxAge(6000);
		//将此cookie发送给浏览器，由其保存。
		res.addCookie(c1);
		
		//Cookie默认不能直接存中文，否则报错。
		//需要对中文编码(ASKII)后才能保存。
		Cookie c2 = new Cookie("city",
			URLEncoder.encode("北京", "utf-8"));
		res.addCookie(c2);
		
		//重定向到主页
		res.sendRedirect("index");
	}
	
}




