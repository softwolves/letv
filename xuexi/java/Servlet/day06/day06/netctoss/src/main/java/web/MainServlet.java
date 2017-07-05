package web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CostDao;
import entity.Cost;

public class MainServlet extends HttpServlet {

	@Override
	protected void service(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		String path = req.getServletPath();
		if("/findCost.do".equals(path)) {
			//查询所有资费
			findCost(req, res);
		} else if("/toAddCost.do".equals(path)) {
			//打开增加资费页
			toAddCost(req, res);
		} else {
			throw new RuntimeException(
				"无效的访问路径.");
		}
	}
	
	protected void toAddCost(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		//转发到增加页面
		//当前：/netctoss/toAddCost.do
		//目标：/netctoss/WEB-INF/cost/add.jsp
		req.getRequestDispatcher(
			"WEB-INF/cost/add.jsp")
			.forward(req, res);
	}
	
	protected void findCost(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		//查询所有的资费
		CostDao dao = new CostDao();
		List<Cost> list = dao.findAll();
		//转发到查询页面
		//当前：/netctoss/findCost.do
		//目标：/netctoss/WEB-INF/cost/find.jsp
		req.setAttribute("costs", list);
		req.getRequestDispatcher(
			"WEB-INF/cost/find.jsp")
			.forward(req, res);
	}
	
}







