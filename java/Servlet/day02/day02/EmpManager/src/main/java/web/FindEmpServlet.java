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

public class FindEmpServlet extends HttpServlet {

	@Override
	protected void service(
		HttpServletRequest req, 
		HttpServletResponse res) throws ServletException, IOException {
		//查询全部员工
		EmpDao dao = new EmpDao();
		List<Emp> list = dao.findAll();
		//输出响应信息(根据员工拼table)
		res.setContentType(
			"text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
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

	
	
}







