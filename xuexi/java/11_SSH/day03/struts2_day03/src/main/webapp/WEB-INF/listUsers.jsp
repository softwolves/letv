<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" 
	uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<h1>用户列表</h1>
	<table border="1">
		<tr>
			<th>编号</th><th>用户名</th>
		</tr>
		<c:forEach var="user" 
			items="${list}">
			<tr>
				<td>${user.id}</td>
				<td>${user.name}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>






