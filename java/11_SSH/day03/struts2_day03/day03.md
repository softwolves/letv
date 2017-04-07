# Struts

## 值栈 ValueStack

1. 从控制器向页面传输值的缓存区
2. ValueStack 包含当前环境相关的全部 对象
	- request
	- session
	- application 等
3. ValueStack 包含两个区域
	- root: 一个List（栈）存储值  
	- context: 一个区域是Map存储环境相关的全部 对象  

> 提示： 在Struts2中ValueStack是软件的消息中心的作用。软件的数据和相关环境信息都缓存在这个对象中。其作用于JSP中的 pageContext 类似。

> JSP 页面中使用 <s:debug/> 标签可以展示 ValueStack 的内容

## OGNL 表达式

OGNL 可以在网页 struts 标签中使用，在Struts2中用于读写ValueStack的数据。

1. 读取root区域数据
	- 从栈顶到栈底逐一搜索 Bean 属性，找到属性就输出
2. 读写 context 区域使用 #key 的方式查找
	- #session.loginName

> 提示：OGNL与ValueStack配合可以从控制器向页面传递数据。

## ValueStack与EL

Struts2 中的拦截了EL表达式，使其从ValueStack中获取数据，也就是说使用EL就可以很好的访问ValueStack.

案例：

DemoAction.java
	
	@Controller
	public class DemoAction {
		
		String message;
		public String getMessage() {
			return message;
		}
		
		public String test(){
			ActionContext context = 
				ActionContext.getContext();
			ValueStack stack=context.getValueStack();
			
	 		Person p = new Person(
					1, "Jerry", "Hello Jerry");
			//将数据添加到值栈中			
			stack.push(p); 
			
			context.getSession()
				.put("loginName", "Robin");
			
			message = "demo";
			System.out.println(
				"Demo Action test()");
			return "success";
		}
	}

Person.class

	public class Person {
		int id;
		String pname;
		String message;
		public Person() {
		}
		
		public Person(int id, String pname, String message) {
			super();
			this.id = id;
			this.pname = pname;
			this.message = message;
		}
	
	
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getPname() {
			return pname;
		}
		public void setPname(String pname) {
			this.pname = pname;
		}
		public String getMessage() {
			return message;
		}
		public void setMessage(String message) {
			this.message = message;
		}
	}

struts.xml(局部)

	<package name="test"
		namespace="/test"
		extends="json-default">
		<action name="demo"
			class="demoAction"
			method="test">
			<result name="success">
				/WEB-INF/msg.jsp
			</result>
		</action>
	</package>

msg.jsp

	<%@ page language="java" 
		contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<!-- 引入struts2 标签库 -->
	<%@taglib prefix="s" uri="/struts-tags" %>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title></title>
	</head>
	<body>
		<h1>test</h1>
		<!-- 利用OGNL表达式读取值栈中的数据 -->
		<s:property value="message"/> <br>
		<s:property value="#session.loginName"/><br>
		<!-- 利用EL表达式读取值栈中的数据 -->
		${message} <br>
		${loginName} 
		<!-- s:debug 标签可以输出 ValueStack 中的数据 -->
		<s:debug></s:debug>
	</body>
	</html>

## Spring Struts2 MyBatis 整合应用

Spring Struts2 MyBatis 可以结合在一起整合应用

整合过程：

pom.xml(局部):

 
	  	<dependency>
	  		<groupId>org.apache.struts</groupId>
	  		<artifactId>struts2-core</artifactId>
	  		<version>2.3.8</version>
	  	</dependency>
	  	<dependency>
	  		<groupId>org.apache.struts</groupId>
	  		<artifactId>struts2-spring-plugin</artifactId>
	  		<version>2.3.8</version>
	  	</dependency>
	  	<dependency>
	  		<groupId>org.apache.struts</groupId>
	  		<artifactId>struts2-json-plugin</artifactId>
	  		<version>2.3.8</version>
	  	</dependency>
	  	<dependency>
	  		<groupId>org.mybatis</groupId>
	  		<artifactId>mybatis</artifactId>
	  		<version>3.2.8</version>
	  	</dependency>
	  	<dependency>
	  		<groupId>org.mybatis</groupId>
	  		<artifactId>mybatis-spring</artifactId>
	  		<version>1.2.3</version>
	  	</dependency>
	  	<dependency>
	  		<groupId>commons-dbcp</groupId>
	  		<artifactId>commons-dbcp</artifactId>
	  		<version>1.4</version>
	  	</dependency>
	  	<dependency>
	  		<groupId>mysql</groupId>
	  		<artifactId>mysql-connector-java</artifactId>
	  		<version>5.1.36</version>
	  	</dependency>
	  	<dependency>
	  		<groupId>aspectj</groupId>
	  		<artifactId>aspectjweaver</artifactId>
	  		<version>1.5.4</version>
	  	</dependency>
	  	<dependency>
	  		<groupId>org.springframework</groupId>
	  		<artifactId>spring-aop</artifactId>
	  		<version>3.0.5.RELEASE</version>
	  	</dependency>
	  	<dependency>
	  		<groupId>org.springframework</groupId>
	  		<artifactId>spring-jdbc</artifactId>
	  		<version>3.0.5.RELEASE</version>
	  	</dependency>
	  	<dependency>
	  		<groupId>commons-codec</groupId>
	  		<artifactId>commons-codec</artifactId>
	  		<version>1.10</version>
	  	</dependency>
	  	<dependency>
	  		<groupId>aopalliance</groupId>
	  		<artifactId>aopalliance</artifactId>
	  		<version>1.0</version>
	  	</dependency>
	  	<dependency>
	  		<groupId>junit</groupId>
	  		<artifactId>junit</artifactId>
	  		<version>4.12</version>
		</dependency>

添加配置文件

web.xml(局部):

	  <listener>
	  	<listener-class>
	  	org.springframework.web.context.ContextLoaderListener
	  	</listener-class>
	  </listener>
	  <!-- 配置Spring配置文件的位置 -->
	  <context-param>
	  	<param-name>contextConfigLocation</param-name>
	  	<param-value>classpath:spring-*.xml</param-value>
	  </context-param>
	  
	  <filter>
	  	<filter-name>mvc</filter-name>
	  	<filter-class>	  	org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter
	  	</filter-class>
	  </filter>
	  <filter-mapping>
	  	<filter-name>mvc</filter-name>
	  	<url-pattern>/*</url-pattern>
	  </filter-mapping>

struts.xml

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE struts PUBLIC
		"-//Apache Software Foundation//DTD Struts Configuration 2.3//EN"
		"http://struts.apache.org/dtds/struts-2.3.dtd">
	<struts>
	</struts>

spring-context.xml(局部):

	<context:component-scan base-package="com.tedu"/>

spring-aop.xml（局部）：

	<!-- 开启AOP注解配置,支持切面,通知,切入点注解标记 -->
	<aop:aspectj-autoproxy />

spring-mybatis.xml（局部）：

	<!-- 定义DataSource -->
	<bean id="dbcp" 
	class="org.apache.commons.dbcp.BasicDataSource">
		<property name="username" value="root"></property>
		<property name="password" value="123456"></property>
		<property name="driverClassName"  value="com.mysql.jdbc.Driver"></property>
		<property name="url" value="jdbc:mysql:///cloud_note?useUnicode=true&amp;characterEncoding=utf8"></property>
	</bean>
	<!-- 定义SqlSessionFactoryBean -->
	<bean id="ssf" class="org.mybatis.spring.SqlSessionFactoryBean">
		<!-- 指定dataSource -->
		<property name="dataSource" ref="dbcp"></property>
		<!-- 指定SQL定义文件 -->
		<property name="mapperLocations" value="classpath:mapper/*.xml"></property>
	</bean>
	
	<!-- 定义MapperScanner -->
	<bean id="mapperScanner" 
	class="org.mybatis.spring.mapper.MapperScannerConfigurer">
		<!-- 指定Mapper接口 -->
		<property name="basePackage" value="com.tedu.cloudnote.dao"></property>
		<!-- 指定SqlSessionFactory,省略 -->
	</bean>
	
spring-transaction.xml（局部）：

	<!-- Spring事务控制 -->
	<!-- 定义事务管理bean -->
	<bean id="txManager" 
	class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
		<property name="dataSource" ref="dbcp"></property>
	</bean>
	<!-- 开启事务注解配置@transactional -->
	<tx:annotation-driven transaction-manager="txManager"/>

开发案例：

实体类：
	
	public class User implements Serializable{
		private String cn_user_id;
		private String cn_user_name;
		private String cn_user_password;
		private String cn_user_token;
		private String cn_user_nick;
		//追加关联属性,用于加载相关的多个Book
		private List<Book> books;
		
		public List<Book> getBooks() {
			return books;
		}
		public void setBooks(List<Book> books) {
			this.books = books;
		}
		public String getCn_user_id() {
			return cn_user_id;
		}
		public void setCn_user_id(String cn_user_id) {
			this.cn_user_id = cn_user_id;
		}
		public String getCn_user_name() {
			return cn_user_name;
		}
		public void setCn_user_name(String cn_user_name) {
			this.cn_user_name = cn_user_name;
		}
		public String getCn_user_password() {
			return cn_user_password;
		}
		public void setCn_user_password(String cn_user_password) {
			this.cn_user_password = cn_user_password;
		}
		public String getCn_user_token() {
			return cn_user_token;
		}
		public void setCn_user_token(String cn_user_token) {
			this.cn_user_token = cn_user_token;
		}
		public String getCn_user_nick() {
			return cn_user_nick;
		}
		public void setCn_user_nick(String cn_user_nick) {
			this.cn_user_nick = cn_user_nick;
		}
		@Override
		public String toString() {
			return "User [cn_user_id=" + cn_user_id + ", cn_user_name=" + cn_user_name + ", cn_user_password="
					+ cn_user_password + ", cn_user_token=" + cn_user_token + ", cn_user_nick=" + cn_user_nick + ", books="
					+ books + "]";
		}
	}

mapper接口 UserDao.java：

	public interface UserDao {
		public void save(User user);
		public User findByName(String name);
	}

mapper 映射文件 UserMapper.xml：

	<?xml version="1.0" encoding="UTF-8" ?>  
	<!DOCTYPE mapper PUBLIC "-//ibatis.apache.org//DTD Mapper 3.0//EN"      
	 "http://ibatis.apache.org/dtd/ibatis-3-mapper.dtd">
	<mapper namespace="com.tedu.cloudnote.dao.UserDao">
		<insert id="save" parameterType="com.tedu.cloudnote.entity.User">
			insert into cn_user	
			(cn_user_id,cn_user_name,
			cn_user_password,cn_user_nick) values 
			(#{cn_user_id},#{cn_user_name},	#{cn_user_password},#{cn_user_nick})
		</insert>
		<select id="findByName" parameterType="string"
			resultType="com.tedu.cloudnote.entity.User">
			select * from cn_user
			where cn_user_name = #{name}
		</select>
	</mapper> 

测试案例：
	
	@Test
	public void testUser(){
		ClassPathXmlApplicationContext ctx=
			new ClassPathXmlApplicationContext(
			"spring-aop.xml", 
			"spring-context.xml",
			"spring-mybatis.xml",
			"spring-transaction.xml");
		UserDao dao=ctx.getBean(
				"userDao", UserDao.class);
		User user=dao.findByName("tedu");
		System.out.println(user);
	}

业务层接口 UserService.java

	public interface UserService {
		public NoteResult addUser(
			String name,String nick,String password);
		public NoteResult checkLogin(
			String name,String password);
	}

业务层实现类 UserServiceImpl.java：

	@Service("userService")//扫描
	@Transactional
	public class UserServiceImpl implements UserService{
		@Resource
		private UserDao userDao;//注入
		
		@Transactional(readOnly=true)
		public NoteResult checkLogin(
				String name, String password) {
			NoteResult result = new NoteResult();
			//判断用户名
			User user = userDao.findByName(name);
			if(user==null){
				result.setStatus(1);
				result.setMsg("用户名不存在");
				return result;
			}
			//判断密码
			//将用户输入的明文加密
			try{
				String md5_pwd = NoteUtil.md5(password);
				if(!user.getCn_user_password()
						.equals(md5_pwd)){
					result.setStatus(2);
					result.setMsg("密码错误");
					return result;
				}
			}catch(Exception e){
				throw new NoteException(
					"密码加密异常", e);	
			}
			//登录成功
			result.setStatus(0);
			result.setMsg("登录成功");
			user.setCn_user_password("");//把密码屏蔽不返回
			result.setData(user);//返回user信息
			return result;
		}
	
		@Transactional
		public NoteResult addUser(
			String name, String nick, String password) {
			NoteResult result = new NoteResult();
			try{
				//检测是否重名
				User has_user = 
					userDao.findByName(name);
				if(has_user != null){
					result.setStatus(1);
					result.setMsg("用户名已被占用");
					return result;
				}
				//执行用户注册
				User user = new User();
				user.setCn_user_name(name);//设置用户名
				user.setCn_user_nick(nick);//设置昵称
				String md5_pwd = NoteUtil.md5(password);
				user.setCn_user_password(md5_pwd);//设置加密密码
				String userId = NoteUtil.createId();
				user.setCn_user_id(userId);//设置用户ID
				userDao.save(user);
				//创建返回结果
				result.setStatus(0);
				result.setMsg("注册成功");
				//模拟异常
				String s = null;
				s.length();//抛一个空指针异常
				return result;
			}catch(Exception e){
				throw new NoteException("用户注册异常",e);
			}
			
		}
	}	

编写控制器的基础类, 抽象出控制器的公共代码，复用这些代码以后简化控制器子类：

	public abstract class BaseAction
		extends ActionSupport
		implements Serializable,
		SessionAware, RequestAware,
		ApplicationAware{
		
		protected Map<String, Object> request;
		protected Map<String, Object> session;
		protected Map<String, Object> application;
		
		public void setRequest(
				Map<String, Object> request) {
			this.request=request;
		}
	
		public void setSession(Map<String, Object> session) {
			this.session = session;
		}
	
		public void setApplication(Map<String, Object> application) {
			this.application = application;
		}
		
		@Resource
		protected UserService userService;
	
		/** JSON 返回值 **/
		protected NoteResult result;
		public NoteResult getResult() {
			return result;
		}
		public void setResult(NoteResult result) {
			this.result = result;
		}
	
	} 

编写登录功能控制器：
	
	@Controller
	@Scope("prototype")
	public class UserAction extends BaseAction{
	
		private String username;
		private String password;
		public void setPassword(String password) {
			this.password = password;
		}
		public void setUsername(String username) {
			this.username = username;
		}
		public String login(){
			NoteResult result = 
					userService.checkLogin(
					username, password);
			this.result=result;
			if(result.getStatus()==0){
				User user=(User)result.getData();
				session.put("loginUser", user);
			}
			return "success";
		}
	}

配置控制器到struts.xml

	<package name="login" namespace="/login"	extends="json-default">
		<action name="login" class="userAction" method="login">
			<result name="success" type="json">
				<param name="root">result</param>
			</result>
		</action>
	</package>

测试：
	
	请求： http://localhost:8080/struts2_day03/login/login.action?username=spring&password=123456

	返回结果：
	{"data":{"books":null,"cn_user_id":"022ada2e14f544dbb49468b7cb6f3d42","cn_user_name":"spring","cn_user_nick":"spring","cn_user_password":"","cn_user_token":null},"msg":"登录成功","status":0}

## 添加显示全部用户列表的功能	

步骤：
1. 修改MyBatis Mapper接口，添加查询方法 findAllUsers()
2. 修改Mapper配置文件，增加查询SQL
3. 修改业务接口，添加查询业务方法：  findAll()
4. 在业务实现类中实现业务接口方法。
5. 在UserAction中增加控制器方法list
6. 修改struts.xml 配置控制器流转过程，成功时候转发到listUsers.jsp
7. 创建listUsers.jsp 页面利用JSTL显示查询结果

> 提示：采用Map封装查询结果，使查询更加灵活方便

### 1. 修改MyBatis Mapper接口，添加查询方法 findAllUsers()

UserDao.java

	public interface UserDao {
		public void save(User user);
		public User findByName(String name);
		public List<Map<String, Object>> 
			findAllUsers();
	}

### 2. 修改Mapper配置文件，增加查询SQL

userMapper.xml(局部):

	<select id="findAllUsers" resultType="java.util.Map">
		select cn_user_id as id, cn_user_name as name
		from cn_user 
	</select>


### 3. 修改业务接口，添加查询业务方法：  findAll()

UserService.java

	public interface UserService {
		public NoteResult addUser(
			String name,String nick,String password);
		public NoteResult checkLogin(
			String name,String password);
		
		List<Map<String, Object>> findAll();
	}
	

### 4. 在业务实现类中实现业务接口方法。

UserServiceImpl.java

	@Transactional(readOnly=true)
	public List<Map<String,Object>> 
		findAll() {
		return userDao.findAllUsers();
	}

### 5. 在UserAction中增加控制器方法list

UserAction.java

	private List<Map<String, Object>> list;
	public List<Map<String, Object>> getList() {
		return list;
	}
	public String list(){
		try{
			list=userService.findAll();
			return SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return ERROR;
		}
	}


### 6. 修改struts.xml 配置控制器流转过程，成功时候转发到listUsers.jsp

struts.xml: 

	<package name="user" namespace="/user" extends="json-default">
		<action name="list" class="userAction" method="list">
			<result name="success">/WEB-INF/listUsers.jsp</result>
			<result name="error">/WEB-INF/error.jsp</result>	
		</action>
	</package>

### 7. 创建listUsers.jsp 页面利用JSTL显示查询结

listUsers.jsp:
	
	<%@ page language="java" 
		contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@taglib prefix="c" 
		uri="http://java.sun.com/jsp/jstl/core" %>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	</head>
	<body>
		<h1>用户列表</h1>
		<table border="1">
			<tr>
				<th>编号</th><th>用户名</th>
			</tr>
			<c:forEach var="user" 
				items="${list}">
				<tr>
					<td>${user.id}</td>
					<td>${user.name}</td>
				</tr>
			</c:forEach>
		</table>
	</body>
	</html>

# Hibernate (冬眠)

其想法是将Java的实体对象映射存储到数据库的表中， 只需要将实体与表的映射关系定义好，Hibernate会自动的生成数据库的SQL语句。

Hibernate 称为 ORM（对象关系映射） 框架。

> Hibernate 是一种不要写SQL的框架。

## 使用Hibernate

使用步骤：
1. 导入Hibernate的相关包
2. 导入数据库的驱动程序
3. 添加Hibernate主配置文件
4. 添加Hibernate映射配置文件
5. 添加实体类
6. 调用Hibernate API 就可以自动生成SQL访问数据库了

### 1. 导入Hibernate的相关包

> 由于是开源软件，其包的依赖关系不够完善，有的Hibernate 版本在导入以后会出现 ClassNotFound 异常。请尝试更换其他版本。

Hibernate pom.xml 坐标：

	<dependency>
		<groupId>org.hibernate</groupId>
		<artifactId>hibernate-core</artifactId>
		<version>3.6.9.Final</version>
	</dependency>
	<dependency>
		<groupId>javassist</groupId>
		<artifactId>javassist</artifactId>
		<version>3.8.0.GA</version>
	</dependency>

### 2. 导入数据库的驱动程序

JDBC 驱动 pom.xml 坐标

	<dependency>
		<groupId>mysql</groupId>
		<artifactId>mysql-connector-java</artifactId>
		<version>5.1.36</version>
	</dependency>


3. 添加Hibernate主配置文件

hibernate.cfg.xml:

	<?xml version='1.0' encoding='UTF-8'?>
	<!DOCTYPE hibernate-configuration PUBLIC
		"-//Hibernate/Hibernate Configuration DTD 3.0//EN"
		"http://www.hibernate.org/dtd/hibernate-configuration-3.0.dtd">
	<hibernate-configuration>
	
		<session-factory>
			<property name="dialect">
				org.hibernate.dialect.MySQLDialect
			</property>
			<property name="connection.url">
	jdbc:mysql://localhost:3306/cloud_note?useUnicode=true&amp;characterEncoding=utf8
			</property>
			<property name="connection.username">root</property>
			<property name="connection.password">123456</property>
			<property name="connection.driver_class">
				com.mysql.jdbc.Driver
			</property>
			
			<!-- 加载映射描述文件 -->
			<mapping resource="User.hbm.xml" />
	
		</session-factory>
	
	</hibernate-configuration>


### 4. 添加Hibernate映射配置文件

User.hbm.xml

	<?xml version="1.0" encoding="utf-8"?>
	<!DOCTYPE hibernate-mapping PUBLIC 
	 "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
	 "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
	<hibernate-mapping>
		<class name="com.tedu.entity.User" 
				table="cn_user">
			<!-- 定义主键映射 -->
			<id name="id" column="cn_user_id" 
				type="string">
			</id>
			<!-- 定义非主键映射 -->
			<property name="name" 
				column="cn_user_name" 
				type="string">
			</property>
			<property name="password" 
				column="cn_user_password"
				type="string">
			</property>
			<property name="token" 
				column="cn_user_token"
				type="string">
			</property>
			<property name="nick" 
				column="cn_user_nick"
				type="string">
			</property>
		</class>
	</hibernate-mapping>

### 5. 添加实体类

> 注意：建议有ID的实体类实现 equals 和 hashCode 方法！ 使用Eclipse生成即可。

User.java
	
	package com.tedu.entity;
	
	import java.io.Serializable;
	
	public class User implements Serializable{
		private String id;
		private String name;
		private String password;
		private String token;
		private String nick;
		
		public User() {
		}
	
		public User(String id, String name, String password, String token, String nick) {
			super();
			this.id = id;
			this.name = name;
			this.password = password;
			this.token = token;
			this.nick = nick;
		}
	
		public String getId() {
			return id;
		}
	
		public void setId(String id) {
			this.id = id;
		}
	
		public String getName() {
			return name;
		}
	
		public void setName(String name) {
			this.name = name;
		}
	
		public String getPassword() {
			return password;
		}
	
		public void setPassword(String password) {
			this.password = password;
		}
	
		public String getToken() {
			return token;
		}
	
		public void setToken(String token) {
			this.token = token;
		}
	
		public String getNick() {
			return nick;
		}
	
		public void setNick(String nick) {
			this.nick = nick;
		}
	
		@Override
		public String toString() {
			return "User [id=" + id + ", name=" + name + ", password=" + password + ", token=" + token + ", nick=" + nick
					+ "]";
		}
	
		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + ((id == null) ? 0 : id.hashCode());
			return result;
		}
	
		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			User other = (User) obj;
			if (id == null) {
				if (other.id != null)
					return false;
			} else if (!id.equals(other.id))
				return false;
			return true;
		}
		
	}
	

### 6. 调用Hibernate API 就可以自动生成SQL访问数据库了

	@Test
	public void test1(){
		Configuration cfg =	new Configuration();
		//读取数据库连接参数
		cfg.configure("hibernate.cfg.xml");
		SessionFactory factory = cfg.buildSessionFactory();
		//获取Session对象
		Session session = factory.openSession();
		//session 可以自动生成SQL查询DB
		String id = "022ada2e14f544dbb49468b7cb6f3d42";
		User u=(User)session.get( User.class, id);
		System.out.println(u); 
		session.close();
	}

-------------------------------------

## 作业

1. 搭建 Spring + Struts2 + MyBatis 环境
2. 用上述环境实现云笔记中登录功能















