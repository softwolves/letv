<%@page pageEncoding="utf-8"
	import="java.util.*,entity.*,dao.*"%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>员工查询</title>
	</head>
	<body>
		<table border="1px" cellspacing="0" width="40%">
			<tr>
				<th>编号</th>
				<th>姓名</th>
				<th>职位</th>
				<th>工资</th>
			</tr>
			<%
				EmpDao dao = new EmpDao();
				List<Emp> list = dao.findAll();
				for(Emp e : list) {
			%>
				<tr>
					<td><%=e.getEmpno() %></td>
					<td><%=e.getEname() %></td>
					<td><%=e.getJob() %></td>
					<td><%=e.getSal() %></td>
				</tr>
			<%		
				}
			%>
		</table>
	</body>
</html>






