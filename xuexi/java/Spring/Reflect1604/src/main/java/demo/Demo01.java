package demo;

import java.util.Scanner;

/**
 * 讲类动态加载到方法区
 */
public class Demo01 {
	public static void main(String[] args) 
		throws Exception {
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
	}
}






