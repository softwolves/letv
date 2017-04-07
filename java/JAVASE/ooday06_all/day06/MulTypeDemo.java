package oo.day06;
//多态的演示
public class MulTypeDemo {
	public static void main(String[] args) {
		Aoo o1 = new Boo(); //向上造型
		Boo o2 = (Boo)o1; //引用所指向的对象，就是该类型
		Inter1 o3 = (Inter1)o1; //引用所指向的对象，实现了该接口
		//Coo o4 = (Coo)o1; //ClassCastException类型转换异常
		if(o1 instanceof Coo){ //false
			Coo o5 = (Coo)o1;
		}
	}
}
interface Inter1{
}
class Aoo{
}
class Boo extends Aoo implements Inter1{
}
class Coo extends Aoo{
}



















