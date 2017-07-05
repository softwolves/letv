package demo;

import java.util.Date;

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
