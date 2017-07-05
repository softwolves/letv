<%@page pageEncoding="utf-8"%>
<img src="images/logo.png" alt="logo" class="left"/>
<!-- 用EL从cookie中取值：cookie.key.value
	其中key是变化的，而cookie、value固定不变。 -->
<%-- <span>${cookie.adminCode.value }</span>--%>
<!-- 也可以用EL从session中取值，EL默认的取值范围
	分别是page、request、session、application -->
<span>${adminCode }</span>
<!-- 
	adminCode -> request.getAttribute("adminCode")
	cost.name - > request.getAttribute("cost").getName()
	
	默认情况下EL先调用getAttribute()，
	获得对象后再访问bean属性(get方法)。
	
	因此若EL为contextPath则等价于
	request.getAttribute("contextPath")。
	
	要想访问4个隐含对象的bean属性(get方法)，
	那么需要把他们当做普通的bean获取到并调用。
	
	pageContext.request.contextPath
-->
<a href="${pageContext.request.contextPath }/logout.do">[退出]</a>




