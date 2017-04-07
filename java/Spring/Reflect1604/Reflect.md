# 反射

是Java中动态特性API。可以完成如下功能：

1. 动态加载类
2. 动态创建对象
3. 动态获取类信息（属性、方法构、造器等）
4. 动态调用方法
5. 动态获取、设置属性的值
6. 动态处理“注解”信息。

> 常见框架的底层都采用了反射API。

反射的优缺点：

1. 优点：动态执行，可以在事先不知道类名，方法名情况下加载类，创建对象，执行方法，访问属性。
2. 缺点：编程复杂，性能稍差。

## 静态执行

	Person p = new Person();
	String name = p.getName();
	System.out.println(name);

## 动态执行
	
在运行期间再确定具体的执行规则，再运行期间再确定软件的执行次序，成为动态执行

##反射API

被测试的案例类 Foo

案例：

	public class Foo {
		
		@MyLove
		public void f(){
			System.out.println("f");
		}
		
		public String test(){
			System.out.println("Hello");
			return "World!";
		}	
		public void test(int n){
			System.out.println("test(int)");
		}

		public void test2(){
			System.out.println("test2"); 
		}
	}

注解：

	@Retention(RetentionPolicy.RUNTIME)
	public @interface MyLove {

	}

### 动态加载类

再运行期间，根据动态给定的类名，动态加载类到方法区。

api 代码：

	Class.forName(类名);

案例：
	
	Scanner in=new Scanner(System.in);
	System.out.print("输入类名：");
	String className=in.nextLine();
	//利用反射API，动态加载类到方法区
	Class cls=Class.forName(className);
	//cls 引用的对象就是通向方法区的通道
	//cls可以获取一切方法区中的信息
	System.out.println(cls.getName());
 
### 反射动态创建对象

Class 提供的newInstance方法可以动态的调用类信息中的无参数构造器创建类的实例。

案例

	Scanner in=new Scanner(System.in);
	System.out.print("输入类名：");
	String className=in.nextLine();
	//利用反射API，动态加载类到方法区
	Class cls=Class.forName(className);
	//cls 引用的对象就是通向方法区的通道
	//cls可以获取一切方法区中的信息
	System.out.println(cls.getName());
	//动态调用类信息再的无参数构造器，
	// 创建对象. 在不知道类名时候使用！！
	Object obj = cls.newInstance();
	System.out.println(obj); 

### 动态获取方法信息

Class 类提供了 getDeclaredMethods() 方法，这个方法可以获取类信息中的方法信息。

案例:

	Scanner in=new Scanner(System.in);
	System.out.print("输入类名：");
	String className=in.nextLine();
	//动态加载类
	Class cls=Class.forName(className);
	//动态获取类中的方法信息
	Method[] methods=
		cls.getDeclaredMethods();
	//methods数组中的每个元素，都代表一个
	//方法信息。
	for(Method m:methods){
		//m代码每个方法信息
		System.out.println(m);
	}

### 动态获取方法的详细信息

Method类提供了获取方法的详细信息方法：包括获取注解信息，方法参数信息，方法返回值信息等

案例：

	Scanner in=new Scanner(System.in);
	System.out.print("输入类名：");
	String className=in.nextLine();
	//动态加载类
	Class cls=Class.forName(className);
	//动态获取类中的方法信息
	Method[] methods=
		cls.getDeclaredMethods();
	//methods数组中的每个元素，都代表一个
	//方法信息。
	for(Method m:methods){
		//m代码每个方法信息
		System.out.println(m);
		//获取方法的注解信息
		Annotation[] ans=
			m.getAnnotations();
		//获取方法的参数列表信息
		Class[] params=
			m.getParameterTypes();
		System.out.println(
			Arrays.toString(ans));
		System.out.println(
			Arrays.toString(params));
	}	

> 处理注解: 使用反射API在运行期间处理注解！！！

### 使用反射API调用方法

注意：

1. 对象上必须包含m方法！！！
	- 否则会出现运行异常！！！
2. 方法必须包含相应参数
	- 否则出现异常

	
	Method m = ...
	m.invoke(对象, 参数列表);
	//再对象上执行m方法，向方法传递参数（参数列表）
	
案例：
需求：
	
有一个类，包含很多以test为开头的方法， 要求编写代码执行这个类中以test为开头的方法。
这个类有无参数构造器， 这些方法都是无返回，无参数，非静态方法。

分析：

1. 不知道类名
2. 不知道方法名

必须使用动态反射API实现上述功能

代码：

	Scanner in = new Scanner(System.in);
	System.out.print("输入类名：");
	String className = in.nextLine();
	//动态加载类
	Class cls = Class.forName(className);
	//找到全部的方法信息
	Method[] methods=
		cls.getDeclaredMethods();
	//找到全部以test为开头的无参数方法
	//String str = "ABC";
	Object obj = cls.newInstance();
	for(Method m:methods){
		String name=m.getName();
		Class[] params=
			m.getParameterTypes();
		//找到了test开头的无参数方法
		if(name.startsWith("test") &&
			params.length==0){
			System.out.println(m); 
			Object val=m.invoke(obj);
			System.out.println(val);
		}
	}

### 案例：模拟Spring框架

常见框架的底层都采用反射技术。Spring底层也是反射技术。

案例：

	<?xml version="1.0" encoding="UTF-8"?>
	<!-- demo/application.xml -->
	<beans>
		<bean id="foo" class="demo.Foo">
		</bean>
		<bean id="date" class="java.util.Date"></bean>
		<!-- .... -->
	</beans>

	
	public class ApplicationContext {
		private Map<String, Object> beans=
				new HashMap<String, Object>();
		public ApplicationContext(String xml)
			throws Exception {
			//初始化Bean容器：根据配置文件，
			//创建每个bean对象
			SAXReader reader=new SAXReader();
			//从包里面读取文件
			InputStream in=
				ApplicationContext.class
				.getClassLoader()
				.getResourceAsStream(xml);
			Document doc=reader.read(in);
			Element root=doc.getRootElement();
			List<Element> els=root.elements();
			for(Element e:els){
				//e 就是xml 中的 bean 元素
				String id=e.attributeValue("id");
				String className=
					e.attributeValue("class");
				//利用反射动态创建bean对象
				Class cls=Class.forName(className);
				Object obj=cls.newInstance();
				//将创建的bean对象保存到beans集合中
				beans.put(id, obj);
			}
			
		}
		
		public Object getBean(String id){
			//返回容器中某个bean对象
			return beans.get(id); 
		}
	}


测试案例：

	public class Demo05 {
		public static void main(String[] args) 
			throws Exception{
			
			String xml="demo/application.xml";
			ApplicationContext ctx = 
				new ApplicationContext(xml);
			Foo foo=(Foo)ctx.getBean("foo");
			Date date=(Date)ctx.getBean("date");
			System.out.println(foo);
			System.out.println(date);
		}

	}









