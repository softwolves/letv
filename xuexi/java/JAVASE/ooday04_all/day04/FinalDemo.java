package oo.day04;
//final的演示
public class FinalDemo {
	public static void main(String[] args) {
	}
}

//演示final修饰类
final class Roo{}
//class Soo extends Roo{} //编译错误，final的类不能被继承
class Too{}
final class Uoo extends Too{} //正确，final的类可以继承别的类


class Poo{ //演示final修饰方法
	final void show(){}
	void test(){}
}
class Qoo extends Poo{
	//void show(){} //编译错误，final的方法不能被重写
	void test(){}
}

/*
 * final修饰成员变量，两种方式初始化:
 *   1)声明的同时初始化
 *   2)构造方法中初始化
 * final修饰局部变量，只要在用之前初始化即可
 */
class Ooo{ //演示final修饰变量
	final int a = 5; //声明同时初始化
	final int b;
	Ooo(){
		b = 8; //构造方法中初始化
	}

	void show(){
		final int c; //用之前赋值即可，不用可以不赋值
		//a = 55; //编译错误，final的变量不能被改变
	}
}











