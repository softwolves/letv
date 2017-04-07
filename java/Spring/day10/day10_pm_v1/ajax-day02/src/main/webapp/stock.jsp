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
src="js/ajax.js"></script>
<script type="text/javascript"
src="js/prototype-1.6.0.3.js"></script>
<script type="text/javascript">
	function showStock(){
		setInterval(quoto,4000);
	}
	function quoto(){
		var xhr = getXhr();
		xhr.open('get','quoto.do',true);
		xhr.onreadystatechange=function(){
			if(xhr.readyState == 4 && 
					xhr.status == 200){
				var txt = xhr.responseText;
				//将json字符串转换成js对象
				var arr = txt.evalJSON();
				var trs = '';
				for(i = 0; i < arr.length; i ++){
					var s = arr[i];
					trs += '<tr><td>' + s.code 
					+ '</td><td>' + s.name 
					+ '</td><td>' + s.price
					+ '</td></tr>';
				}
				//为body添加新的行。
				$('tb1').innerHTML = trs;
			}
		};
		xhr.send(null);
	}
</script>
</head>
<body style="font-size:30px;" 
onload="showStock();">
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