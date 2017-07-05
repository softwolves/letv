package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Stock;
import net.sf.json.JSONArray;

public class ActionServlet extends HttpServlet{
	public void service(HttpServletRequest 
			request,
			HttpServletResponse response) 
	throws ServletException,IOException{
		String uri = 
				request.getRequestURI();
		String action = 
			uri.substring(
					uri.lastIndexOf("/"),
					uri.lastIndexOf("."));
		response.setContentType(
				"text/html;charset=utf-8");
		PrintWriter out = 
				response.getWriter();
		if("/quoto".equals(action)){
			//返回几只股票的信息
			List<Stock> stocks = 
					new ArrayList<Stock>();
			Random r = new Random();
			for(int i = 0; i < 8; i ++){
				Stock s = new Stock();
				s.setCode("60001" + (i + 1));
				s.setName("山东高速" + i);
				s.setPrice(r.nextInt(100));
				stocks.add(s);
			}
			//fromObject可以接收数组或者List。
			JSONArray jsa = 
					JSONArray.fromObject(stocks);
			String json = jsa.toString();
			System.out.println(json);
			out.println(json);
		}
	}
	
	
	
	
	
}
