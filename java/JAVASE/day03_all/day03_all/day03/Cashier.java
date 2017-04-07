package day03;
import java.util.Scanner;
//柜台收银程序
public class Cashier {
	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		System.out.println("请输入单价:");
		double unitPrice = scan.nextDouble();
		System.out.println("请输入数量:");
		double amount = scan.nextDouble();
		System.out.println("请输入金额:");
		double money = scan.nextDouble();
		
		//计算总价(单价*数量)
		double totalPrice = unitPrice*amount;
		if(totalPrice>=500){ //满500
			totalPrice*=0.8; //打8折
		}
		
		if(money>=totalPrice){ //够
			double change = money-totalPrice; //计算找零(给的钱-总价)
			System.out.println("总价为"+totalPrice+"，找零为:"+change);
		}else{ //不够
			System.out.println("ERROR!您给的钱不够");
		}
		
	}
}













