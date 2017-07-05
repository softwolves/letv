package day02;
import java.util.Scanner; //1.
//Scanner的演示
public class ScannerDemo {
	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in); //2.
		System.out.println("请输入年龄:");
		int age = scan.nextInt(); //3.
		System.out.println("请输入单价:");
		double price = scan.nextDouble();
		
		System.out.println(age);
		System.out.println(price);
	}
}













