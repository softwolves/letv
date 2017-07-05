package oo.day02;
//T类与J类的测试类
public class TJTest {
	public static void main(String[] args) {
		T t = new T(2,5);
		System.out.println("原始位置:");
		t.print();
		
		t.drop();
		System.out.println("下落后位置:");
		t.print();
		
		t.moveLeft();
		System.out.println("左移后位置:");
		t.print();
	}
}














