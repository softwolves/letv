<%@page pageEncoding="utf-8"%>
<!-- 1.JSP中可以直接写HTML -->
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>第1个JSP</title>
	</head>
	<body>
		<!-- 2.3JSP声明：定义的函数。 -->
		<%!
			public int pf(int n) {
				return n*n;
			}
		%>
		<ul>
			<!-- 2.JSP中可以写Java -->
			<!-- 2.1JSP脚本：完整的Java代码行。 -->
			<%
				for(int i=0;i<20;i++) {
			%>
				<!-- 2.2JSP表达式：要输出的变量。 -->
				<li><%=pf(i) %></li>
			<%
				}
			%>
		</ul>
		<!-- 将date.jsp引入到此处，相当于将
			其内容复制到此处。 -->
		<%@include file="date.jsp" %>
	</body>
</html>










