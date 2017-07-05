package day06;
//方法的演示
public class MethodDemo {
	public static void main(String[] args) {
		//say();
		//say();
		
		//sayHi(); //编译错误，有参则必须传参
		//sayHi(250); //编译错误，参数类型不匹配
		//sayHi("zhangsan",25); //编译错误，参数个数不匹配
		//sayHi("zhangsan"); //String name="zhangsan"
		//sayHi("lisi"); //String name="lisi"
		//sayHi("wangwu"); //String name="wangwu"
		
		//double a = getNum(); //getNum()的值就是return后的那个数
		//System.out.println(a);
		
		//int m = plus(5,6); //int a=5,int b=6
		//System.out.println(m);
		
		int num1=5,num2=6;
		int m = plus(num1,num2); //int a=1,int b=6
		System.out.println(m);
		
		//a(); //方法嵌套调用
		
		System.out.println("over");
	}
	
	
	
	
	
	
	
	//有参有返回值
	public static int plus(int a,int b){
		//int num = a+b;
		//return num; //返回的是num里的那个数
		return a+b;
	}
	
	//无参有返回值
	public static double getNum(){
		//return; //编译错误，必须返回值一个值
		//return "Hi"; //编译错误，返回值类型不匹配
		return 8.88; //1.结束方法的执行  2.返回结果给调用方
	}
	
	//有参无返回值-------有参更灵活
	public static void sayHi(String name){
		System.out.println("大家好，我叫"+name);
		return; //1.结束方法的执行
	}
	
	//无参无返回值
	public static void say(){
		System.out.println("大家好，我叫WKJ");
	}
	
	public static void a(){
		System.out.println(111);
		b();
		System.out.println(222);
	}
	public static void b(){
		System.out.println(333);
	}
	
}












