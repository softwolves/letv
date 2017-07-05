package demo;

import java.lang.reflect.Method;
import java.util.Scanner;

/**
 * 找到一个类中全部的以test为开头
 * 的无参数方法
 */
public class Demo03 {
	public static void main(String[] args) 
		throws Exception {
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
		
	}
}








