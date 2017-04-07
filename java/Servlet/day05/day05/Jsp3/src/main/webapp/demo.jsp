<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/my-tag" prefix="k"%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>EL和JSTL</title>
	</head>
	<body>
		<h1>JSTL</h1>
		<!-- 1. if -->
		<p>
			<c:if test="${stu.sex=='M' }">男</c:if>
			<c:if test="${stu.sex=='F' }">女</c:if>
		</p>
		<!-- 2. choose -->
		<p>
			<c:choose>
				<c:when test="${stu.sex=='M' }">男</c:when>
				<c:otherwise>女</c:otherwise>
			</c:choose>
		</p>
		<!-- 3. forEach -->
		<!-- 每次循环，JSTL会创建一个对象，专门用来
			记录循环下标、循环次数等值。若想获取这个
			对象，则使用varStatus声明该对象的名称。 -->
		<p>
			<c:forEach items="${stu.interests }" 
				var="i" varStatus="s">
				${i },${s.index },${s.count } <br>
			</c:forEach>
		</p>
		<p>
			<k:sysdate format="HH:mm:ss"/>
		</p>
		
		
		<h1>EL</h1>
		<!-- 1.获取Bean属性 -->
		<!-- request.getAttribute("stu").getName() -->
		<p>姓名:${stu.name }</p>
		<!-- request.getAttribute("stu").getAge() -->
		<p>年龄:${stu["age"] }</p>
		<!-- request.getAttribute("stu")
				.getCourse().getId() -->
		<p>课程:${stu.course.id }</p>
		<!-- 2.进行运算 -->
		<p>年龄+5:${stu.age+5 }</p>
		<p>大于20:${stu.age>20 }</p>
		<p>介于10到20间:${stu.age>10 && stu.age<20 }</p>
		<p>判空:${empty stu }</p>
		<p>判空:${stu==null }</p>
		<!-- 3.获取请求参数 -->
		<p>参数:${param.x }</p>
		<!-- 4.EL从Bean中取值的规则：
			1）它默认从4个隐含对象(范围)中依次取值；
			2）这4个对象依次为：
				page、request、session、application
			3）举例：
				有EL表达式 user，则EL按照如下规则取值
				page.getAttribute("user")
				request.getAttribute("user")
				session.getAttribute("user")
				application.getAttribute("user")
			4）特例：
				若想打破该默认规则，希望从指定的对象
				(范围)中取值，则需要指定是哪个对象：
				sessionScope.user -->
			<p>${requestScope.stu }</p>
	</body>
</html>




