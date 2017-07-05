package demo;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Scanner;

/**
 * 动态获取类中的方法信息
 */
public class Demo02 {
	public static void main(String[] args)
		throws Exception{
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
			if(m.getName().startsWith("test")){
				System.out.println("找到："+m);
			}
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
	}
}










