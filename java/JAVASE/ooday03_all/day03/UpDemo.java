package oo.day03;
//向上造型的演示
public class UpDemo {
	public static void main(String[] args) {
		Coo o1 = new Coo();
		o1.c = 1;
		o1.say();
		//o1.d = 2; //编译错误，父不能访问子的
		
		Doo o2 = new Doo();
		o2.d = 1;
		o2.show();
		o2.c = 2;
		o2.say(); //正确，子可以访问父
		
		Coo o3 = new Doo(); //向上造型
		o3.c = 1;
		o3.say();
		//o3.d = 2; //编译错误，能点出来什么，看引用的类型
	}
}

class Coo{
	int c;
	void say(){}
}
class Doo extends Coo{
	int d;
	void show(){}
}

















