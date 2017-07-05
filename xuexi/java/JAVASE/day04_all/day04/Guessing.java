package day04;
import java.util.Scanner;
//猜数字游戏
public class Guessing {
	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		int num = (int)(Math.random()*1000+1); //生成1到1000之内的随机数
		System.out.println(num); //250
		
		int guess;
		do{
			System.out.println("猜吧!");
			guess = scan.nextInt(); //1,3
			if(guess==0){
				break;
			}
			if(guess>num){
				System.out.println("太大了");
			}else if(guess<num){
				System.out.println("太小了");
			}
		}while(guess!=num); //2
		if(guess==num){
			System.out.println("恭喜你，猜对了!");
		}else{
			System.out.println("下次再来吧!");
		}
		
		
		
		
		
		
		
		
		
		/*
		System.out.println("猜吧!");
		int guess = scan.nextInt(); //1.循环变量的初始化
		while(guess!=num){ //2.循环的条件
			if(guess==0){
				break;
			}
			if(guess>num){
				System.out.println("太大了");
			}else{
				System.out.println("太小了");
			}
			System.out.println("猜吧!");
			guess = scan.nextInt(); //3.循环变量的改变
		}
		if(guess==num){
			System.out.println("恭喜你，猜对了!");
		}else{
			System.out.println("下次再来吧!");
		}
		*/
	}
}









