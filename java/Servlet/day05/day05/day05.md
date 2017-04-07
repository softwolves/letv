# JSP隐含(内置)对象
## 1. request(*)
- HttpServletRequest

## 2. response
- HttpServletResponse

## 3. out
- JSPWriter
- 相当于PrintWriter

## 4. config
- ServletConfig

## 5. application
- ServletContext

## 6. exception
- Throwable
- 网页中的异常，当发生异常时才可用

## 7. session(*)
- HttpSession

## 8. page
- 指代当前页面，相当于this

## 9. pageContext(*)
- 可以给页面提供数据
- 事实上该对象内引用了其他8个隐含对象

## 使用示例
- <%=request.getParameter("user")%>
- <%String user = request.getParameter("user");%>

# 补充
## Bean属性

	//对象的属性
	private String userName;
	
	//Bean属性就是get/set方法后的字符串。
	//当前案例中bean属性就是name。
	public void setName(String name) {
		this.userName = name;
	}
	
	public String getName() {
		return this.userName;
	}