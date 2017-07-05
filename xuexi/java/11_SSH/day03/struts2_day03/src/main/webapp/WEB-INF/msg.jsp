<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>test</h1>
	<s:property value="message"/> <br>
	<s:property value="#session.loginName"/><br>
	${message} <br>
	${loginName} 
	<s:debug></s:debug>
</body>
</html>



