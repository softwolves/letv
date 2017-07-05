<!-- 
	pageEncoding：声明当前文件的编码。
	contentType：响应时通知浏览器输出的内容格式。
-->
<%@page pageEncoding="utf-8"
	contentType="text/html"
	import="java.util.*,java.text.*" %>
<%
	Date date = new Date();
	SimpleDateFormat sdf = 
		new SimpleDateFormat("HH:mm:ss");
	String now = sdf.format(date);
%>
<p><%=now %></p>














