<%@ page 
 contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>Insert title here</title>
<style>
	#d1{
		width:400px;
		height:350px;
		margin-left:300px;
		margin-top:50px;
		background-color:black;
	}
	#d2{
		color:yellow;
		background-color:red;
		height:32px;
	}
	table{
		color:white;
		font-style:italic;
		font-size:24px;
	}
</style>
<script type="text/javascript" 
src="js/jquery-1.4.3.js"></script>
<script type="text/javascript">
	$(function(){
		setInterval(quoto,3000);
	});
	function quoto(){
		$.post('quoto.do',function(data){
			/*
			data是服务器返回的数据，如果是
			json字符串，会自动转换成对应的
			javascript对象或者javascript对象
			组成的数组。
			*/
			$('#tb1').empty();
			for(i = 0; i < data.length; i ++){
				var s = data[i];
				$('#tb1').append(
					'<tr><td>' + s.code 
					+ '</td><td>' + s.name 
					+ '</td><td> ' + s.price 
					+ '</td></tr>');
			}
		},'json');
	}
</script>
</head>
<body style="font-size:30px;">
	<div id="d1">
		<div id="d2">股票实时行情</div>
		<div id="d3">
			<table width="100%">
				<thead>
					<tr>
						<td>代码</td>
						<td>名称</td>
						<td>价格</td>
					</tr>
				</thead>
				<tbody id="tb1">
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>