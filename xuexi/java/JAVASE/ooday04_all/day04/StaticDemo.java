package oo.day04;
//static的演示
public class StaticDemo {
	public static void main(String[] args) {
		Loo o1 = new Loo();
		o1.show();
		Loo o2 = new Loo();
		o2.show();
		System.out.println(Loo.b); //建议通过类名来访问
		System.out.println(o1.b);  //不建议通过引用来访问
		
		Moo.test(); //静态方法通过类名点来访问
		
		Noo o3 = new Noo();
		Noo o4 = new Noo();
		
	}
}


class Noo{
	static{
		System.out.println("静态块");
	}
	Noo(){
		System.out.println("构造方法");
	}
}










class Moo{ //演示静态方法
	int a;
	static int b;
	void show(){
		a = 1;
		b = 2;
	}
	static void test(){ //没有隐式的this
		//a = 1; //没有this意味着没有对象，而a必须通过对象来访问，所以此处不能访问
		b = 2;
	}
}

class Loo{ //演示静态变量
	int a;
	static int b;
	Loo(){
		a++;
		b++;
	}
	void show(){
		System.out.println("a="+a);
		System.out.println("b="+b);
	}
}













