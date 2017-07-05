package oo.day06;
//成员内部类的演示
public class InnerClassDemo {
	public static void main(String[] args) {
		Mama m = new Mama();
		//Baby b = new Baby(); //编译错误，内部类对外不具备可见性
	}
}

class Mama{ //外部类
	private String name;
	Baby createBaby(){
		return new Baby();
	}
	class Baby{ //内部类
		public void showMamaName(){
			System.out.println(name);
			System.out.println(Mama.this.name);
			//System.out.println(this.name); //编译错误
		}
	}
}











