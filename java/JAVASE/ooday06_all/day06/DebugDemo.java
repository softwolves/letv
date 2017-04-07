package oo.day06;
//Debug的演示
public class DebugDemo {
	public static void main(String[] args) {
		/*
		int a=5,b=6;
		int n = plus(a,b);
		System.out.println(n);
		show();
		System.out.println("over");
		*/
		
		int num = 9;
		for(int i=2;i<num;i++){
			if(num%i==0){
				System.out.println(num+"不是质数");
				break;
			}else{
				System.out.println(num+"是质数");
				break;
			}
		}
		
		
		
		
		
		
	}
	
	
	
	
	
	
	public static int plus(int num1,int num2){
		int num = num1+num2;
		return num;
	}
	public static void show(){
		System.out.println(111);
		System.out.println(222);
		System.out.println(333);
		System.out.println(444);
	}
	
}











