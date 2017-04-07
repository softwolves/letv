<%@ page 
 contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>Insert title here</title>
<style>
	table{
		font-style:italic;
		font-size:24px;
		margin-left:300px;
		margin-top:80px;
	}
	.selected{
		color:red;
		font-size:26px;
	}
</style>
<script type="text/javascript" 
src="js/jquery-1.4.3.js"></script>
<script type="text/javascript">
	$(function(){
		$('#key').keyup(function(){
			$.ajax({
				url:'keyInfo.do',
				type:'post',
				data:'key=' + $('#key').val(),
				dataType:'text',
				success:function(data){
					//小米,小学生,小月月,小时代
					//分解
					var arr = data.split(',');
					$('#d1').empty();
					//在搜索输入框下面添加提示。
					for(i = 0; i < arr.length; i ++){
						var word = arr[i];
						$('#d1').append(   
								'<div class="item">' 
								+ word + '</div>');
					}
					//对这些提示绑订单击事件处理函数
					$('.item').click(function(){
						//将提示添加到搜索输入框
						$('#key').val($(this).text());
						//清空提示。
						$('#d1').empty();
					});
					//当鼠标经过提示时，加亮该提示。
					$('.item').hover(function(){
						$(this).addClass('selected');
					},function(){
						$(this).removeClass('selected');
					});
					
				}
			});
		});
	});
</script>
</head>
<body style="font-size:30px;">
	<table>
		<tr>
			<td><input id="key" name="key"/></td>
			<td><input type="button" 
			value="搜索"/></td>
		</tr>
		<tr>
			<td colspan="2">
				<div id="d1"></div>
			</td>
		</tr>
	</table>
</body>
</html>