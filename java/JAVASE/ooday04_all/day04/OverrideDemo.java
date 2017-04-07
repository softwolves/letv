package oo.day04;
//重写的演示
public class OverrideDemo {
	public static void main(String[] args) {
		/*
		Aoo o1 = new Aoo();
		o1.show(); //父类show
		Boo o2 = new Boo();
		o2.show(); //子类show
		Aoo o3 = new Boo();
		o3.show(); //子类show
		*/
		
		//重载看引用，重写看对象
		Goo goo = new Goo();
		Eoo o = new Foo(); //向上造型
		goo.test(o);
		
		/*
		 * 1.创建类Eoo，包含show()，输出"父类show"
		 * 2.创建类Foo继承Eoo，重写show()，输出"子类show"
		 * 3.创建类Goo，包含:
		 *    void test(Eoo o){
		 *      输出"父型参数"
		 *      o.show();
		 *    }
		 *    void test(Foo o){
		 *      输出"子型参数"
		 *      o.show();
		 *    }
		 * 4.main()方法中:
		 *    Goo goo = new Goo();
		 *    Eoo o = new Foo(); //向上造型
		 *    goo.test(o);
		 */
	}
}

class Goo{
	void test(Eoo o){
		System.out.println("父型参数");
		o.show();
	}
	void test(Foo o){
		System.out.println("子型参数");
		o.show();
	}
}
class Eoo{
	void show(){
		System.out.println("父类show");
	}
}
class Foo extends Eoo{
	void show(){
		System.out.println("子类show");
	}
}















/*
 * 重写需要遵循"两同两小一大"原则:一般都是一模一样的
 * 1.两同:
 *   1)方法名称相同
 *   2)参数列表相同
 * 2.两小:
 *   1)子类方法的返回值类型小于或等于父类的
 *     1.1)void和基本类型时，必须相同
 *     1.2)引用类型时，小于或等于
 *   2)子类方法抛出的异常小于或等于父类的-------异常
 * 3.一大:
 *   1)子类方法的访问权限大于或等于父类的----访问修饰符
 */

//父类大，子类小
class Coo{
	void sayHi(){}
	double show(){return 0.0;}
	Coo test(){return null;}
	Doo say(){return null;}
}
class Doo extends Coo{
	void sayHi(){} //void时必须相同
	double show(){return 1;} //基本类型时必须相同
	Doo test(){return null;} //小于父类
	//Coo say(){return null;} //编译错误，引用类型时必须小于或等于
}









class Aoo{
	void show(){
		System.out.println("父类show");
	}
}
class Boo extends Aoo{
	void show(){
		super.show(); //调用父类的show方法
		System.out.println("子类show");
	}
}









