package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EmpDao;
import entity.Emp;

/**
 * 此Servlet用来处理一切普通的请求(增删改查)，
 * 要求他们都以.do为后缀。
 * 
 * 路径规范：
 * 	查询员工：/findEmp.do
 * 	增加保存员工：/addEmp.do
 */
public class MainServlet extends HttpServlet {

	@Override
	protected void service(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		//获取Servlet网名
		String path = req.getServletPath();
		//对其进行判断
		if("/findEmp.do".equals(path)) {
			findEmp(req, res);
		} else if("/addEmp.do".equals(path)) {
			addEmp(req, res);
		} else {
			throw new RuntimeException(
				"找不到这个资源.");
		}
	}

	protected void findEmp(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		//查询全部员工
		EmpDao dao = new EmpDao();
		List<Emp> list = dao.findAll();
		//输出响应信息(根据员工拼table)
		res.setContentType(
			"text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		//当前：/EmpManager/findEmp
		//目标：/EmpManager/add_emp.html
		out.println("<input type='button' value='增加' onclick='location.href=\"add_emp.html\"'/>");
		out.println("<table border='1px' width='40%' cellspacing='0'>");
		out.println("	<tr>");
		out.println("		<th>编号</th>");
		out.println("		<th>姓名</th>");
		out.println("		<th>职位</th>");
		out.println("		<th>工资</th>");
		out.println("	</tr>");
		for(Emp e : list) {
			out.println("<tr>");
			out.println("	<td>"+e.getEmpno()+"</td>");
			out.println("	<td>"+e.getEname()+"</td>");
			out.println("	<td>"+e.getJob()+"</td>");
			out.println("	<td>"+e.getSal()+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
		out.close();
	}	
	
	protected void addEmp(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		//接收表单中的数据
		String ename = req.getParameter("ename");
		String job = req.getParameter("job");
		String sal = req.getParameter("sal");
		//将这些数据存入库中
		Emp e = new Emp();
		e.setEname(ename);
		e.setJob(job);
		if(sal != null && !sal.equals("")) {
			e.setSal(new Double(sal));
		}
		EmpDao dao = new EmpDao();
		dao.save(e);
		//输出响应信息
//			res.setContentType(
//				"text/html;charset=utf-8");
//			PrintWriter out = res.getWriter();
//			out.println("<p>保存成功</p>");
//			out.close();
		//重定向到查询功能
		//当前：/EmpManager/addEmp.do
		//目标：/EmpManager/findEmp.do
		res.sendRedirect("findEmp.do");
	}
	
}









