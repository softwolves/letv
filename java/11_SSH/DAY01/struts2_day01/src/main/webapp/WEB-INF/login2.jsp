<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" 
	uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<!-- /WEB-INF/login2.jsp -->
<html>
<head>
<meta charset="utf-8">
<title>登录</title>
</head>
<body>
	<h1>登录</h1>
	<c:url var="url" 
		value="/user/login2.action"/>
	<form action="${url}" method="post">
		<h2>${message}</h2>
		<div>
			<label>用户名:</label>
			<input type="text" 
			name="user.id" value="${user.id}"/>
		</div>		
		<div>
			<label>密码</label>
			<input type="password" name="user.pwd">
		</div>
		<div>
			<input type="submit" value="登录">		
		</div>
	</form>
</body>
</html>







