package web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AdminDao;
import dao.CostDao;
import entity.Admin;
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
		} else if("/addCost.do".equals(path)) {
			//增加资费
			addCost(req, res);
		} else if("/toUpdateCost.do".equals(path)) {
			//打开修改资费页
			toUpdateCost(req, res);
		} else if("/toLogin.do".equals(path)) {
			//打开登录页
			toLogin(req, res);
		} else if("/toIndex.do".equals(path)) {
			//打开主页
			toIndex(req, res);
		} else if("/login.do".equals(path)) {
			//登录
			login(req, res);
		} else if("/logout.do".equals(path)) {
			//退出
			logout(req, res);
		} else {
			throw new RuntimeException(
				"无效的访问路径.");
		}
	}
	
	protected void logout(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		//销毁session
		req.getSession().invalidate();
		//重定向到登录
		res.sendRedirect("toLogin.do");
	}
	
	protected void login(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		//接收表单数据
		String adminCode = 
			req.getParameter("adminCode");
		String password = 
			req.getParameter("password");
		//验证账号密码
		AdminDao dao = new AdminDao();
		Admin admin = dao.findByCode(adminCode);
		if(admin == null) {
			//账号错误，转发到登录页
			req.setAttribute("error", "账号错误");
			req.getRequestDispatcher(
				"WEB-INF/main/login.jsp")
				.forward(req, res);
		} else if(!admin.getPassword().equals(password)) {
			//密码错误，转发到登录页
			req.setAttribute("error", "密码错误");
			req.getRequestDispatcher(
				"WEB-INF/main/login.jsp")
				.forward(req, res);
		} else {
			//将账号存入cookie
			Cookie cookie = new Cookie(
				"adminCode", adminCode);
			res.addCookie(cookie);
			//将账号存入session
			HttpSession session = req.getSession();
			session.setAttribute("adminCode", adminCode);
			//登录成功，重定向到主页
			res.sendRedirect("toIndex.do");
		}
	}
	
	protected void toIndex(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		req.getRequestDispatcher(
			"WEB-INF/main/index.jsp")
			.forward(req, res);
	}
	
	protected void toLogin(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		req.getRequestDispatcher(
			"WEB-INF/main/login.jsp")
			.forward(req, res);
	}
	
	protected void toUpdateCost(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		//接收传入的参数
		String id = req.getParameter("id");
		//查询要修改的数据
		CostDao dao = new CostDao();
		Cost cost = 
			dao.findById(new Integer(id));
		//转发到修改页面
		req.setAttribute("cost", cost);
		req.getRequestDispatcher(
			"WEB-INF/cost/update.jsp")
			.forward(req, res);
	}
	
	protected void addCost(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		//接收表单数据
		String name = req.getParameter("name");
		String baseDuration = 
			req.getParameter("baseDuration");
		String baseCost = 
			req.getParameter("baseCost");
		String unitCost = 
			req.getParameter("unitCost");
		String descr = req.getParameter("descr");
		String costType = req.getParameter("costType");
		//存储数据
		Cost c = new Cost();
		c.setName(name);
		if(baseDuration != null
			&& !baseDuration.equals("")) {
			c.setBaseDuration(
				new Integer(baseDuration));
		}
		if(baseCost != null
			&& !baseCost.equals("")) {
			c.setBaseCost(
				new Double(baseCost));
		}
		if(unitCost != null
			&& !unitCost.equals("")) {
			c.setUnitCost(
				new Double(unitCost));
		}
		c.setDescr(descr);
		c.setCostType(costType);
		CostDao dao = new CostDao();
		dao.save(c);
		//重定向到查询功能
		//当前：/netctoss/addCost.do
		//目标：/netctoss/findCost.do
		res.sendRedirect("findCost.do");
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







