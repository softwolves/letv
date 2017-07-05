<%@ page 
 contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript" 
src="js/ajax.js"></script>
<script type="text/javascript">
	/*
		检查用户名是否被占用。
		该函数利用ajax对象向服务器发送
		一个异步请求，利用服务器返回的
		数据（比如，用户名被占用）来更
		新当前页面。
	*/
	function check_uname(){
		//step1.获得ajax对象。
		var xhr = getXhr();
		//step2.利用ajax对象发送请求。
		xhr.open('get',
				'check_uname.do?username=' 
						+ $F('username'),true);
		xhr.onreadystatechange=handler;
		xhr.send(null);
	}
</script>
</head>
<body style="font-size:30px;">
	<form action="" method="post">
		用户名:<input id="username" name="username"
		onblur="check_uname();"/><br/>
		密码:<input type="password" 
		name="pwd"/><br/>
		<input type="submit" value="注册"/>
	</form>
</body>
</html>



