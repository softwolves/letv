<%@ page 
 contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>Insert title here</title>
<style>
	table{
		font-size:24px;
		font-style:italic;
	}
</style>
<script type="text/javascript" 
src="js/jquery-1.4.3.js"></script>
<script type="text/javascript">
	$(function(){
		$('a.s1').toggle(f1,f2);
	});
	
	function f2(){
		$(this).next().empty();
	}
	
	function f1(){
		//找到航班号
		var flight = $(this).parent()
		.siblings().eq(0).text();
		
		//$(this).next().load(
			//'flight.do','flight=' + flight);
		$(this).next().load('flight.do',
				{'flight':flight});
	}
</script>
</head>
<body style="font-size:30px;">
	<table border="1" 
	cellpadding="0" cellspacing="0" 
	width="60%">
		<tr>
			<td>航班号</td>
			<td>机型</td>
			<td></td>
			<td>经济舱价格</td>
		</tr>
		<tr>
			<td>CA1204</td>
			<td><a href="#">波音747</a></td>
			<td>
				<a href="javascript:;" 
				class="s1">显示所有票价</a>
				<div></div>
			</td>
			<td>600</td>
		</tr>
		<tr>
			<td>MU3304</td>
			<td><a href="#">空客320</a></td>
			<td>
				<a href="javascript:;"
				class="s1">显示所有票价</a>
				<div></div>
			</td>
			<td>500</td>
		</tr>
	</table>
</body>
</html>