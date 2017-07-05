package oo.day05;
//接口的演示
public class InterfaceDemo {
	public static void main(String[] args) {
		//Inter5 o1 = new Inter5(); //编译错误，接口不能被实例化
		Inter6 o2 = new Eoo(); //向上造型
		Inter5 o3 = new Eoo(); //向上造型
		/*
		 * 接口的练习:
		 * 1.创建接口Inter1，包含常量NUM和抽象方法show()
		 * 2.创建接口Inter2，包含a()和b()
		 *   创建类Aoo，实现Inter2接口
		 * 3.创建接口Inter3，包含c()
		 *   创建类Boo，实现Inter2和Inter3接口
		 * 4.创建抽象类Coo，包含抽象方法d()
		 *   创建类Doo，继承Coo并实现Inter2和Inter3接口
		 * 5.创建接口Inter4，继承Inter3，并包含e()
		 *   创建类Eoo，实现Inter4
		 * 6.main()方法中:
		 *     Inter4 o1 = new Inter4();-----???
		 *     Inter4 o2 = new Eoo();--------???
		 *     Inter3 o3 = new Eoo();--------???
		 */
	}
}











//演示接口间的继承
interface Inter5{
	void show();
}
interface Inter6 extends Inter5{
	void say();
}
class Eoo implements Inter6{
	public void say(){}
	public void show(){}
}


//演示又继承类又实现接口
interface Inter3{
	void show();
}
interface Inter4{
	void say();
}
abstract class Doo{
	abstract void test();
}
class Eoo1 extends Doo implements Inter3,Inter4{
	public void show(){}
	public void say(){}
	void test(){}
}






//演示接口的实现
interface Inter2{
	void show();
	void say();
}
class Coo implements Inter2{
	public void show(){}
	public void say(){}
}




//演示接口的基础语法
interface Inter1{
	public static final double PI = 3.14159; //常量
	public abstract void show(); //抽象方法
	
	int NUM = 250; //默认public static final
	void say(); //默认public abstract
	
	//int count; //编译错误，常量必须声明同时初始化
	//void sayHi(){} //编译错误，接口中方法默认都是抽象的
}











