package day04;
//for的演示
public class ForDemo {
	public static void main(String[] args){
		int sum = 0; 
		for(int num=1;num<=100;num++){
			if(num%10!=3){
				sum+=num; 
			}
		}
		System.out.println("sum="+sum);
		
		/*
		int sum = 0; 
		for(int num=1;num<=100;num++){
			if(num%10==3){ //不要个位为3的
				continue;
			}
			sum+=num; 
		}
		System.out.println("sum="+sum);
		*/
		/*
		 * sum=0
		 * num=1 sum=1
		 * num=2 sum=1+2
		 * num=3
		 * num=4 sum=1+2+4
		 * ...
		 * num=13 
		 * num=14 sum=...
		 * ...
		 * num=23
		 */
		
		
		
		
		
		
		
		
		
		
		/*
		int sum = 0;
		int num=1;
		for(;num<=100;num++){
			sum+=num; 
		}
		System.out.println("sum="+sum);
		*/
		
		/*
		int sum = 0; 
		for(int num=1;num<=100;){
			sum+=num; 
			num++;
		}
		System.out.println("sum="+sum);
		*/
		/*
		int sum = 0;
		int num=1;
		for(;num<=100;){
			sum+=num; 
			num++;
		}
		System.out.println("sum="+sum);
		*/
		
		/*
		for(;;){ //死循环
			System.out.println("我要学习......");
		}
		*/
		
		/*
		for(int i=1,j=6;i<6;i+=2,j-=2){
		}
		*/
		/*
		 * i=1,j=6
		 * i=3,j=4
		 * i=5,j=2
		 * i=7,j=0
		 */
		
		/*
		for(int count=0;count<10;count++){
			System.out.println("行动是成功的阶梯");
		}
		System.out.println("over");
		
		for(int num=1;num<=9;num++){
			System.out.println(num+"*9="+num*9);
		}
		System.out.println("over");
		*/
		
		/*
		//累加和: 1+2+3+...+99+100=5050
		int sum = 0; //和
		for(int num=1;num<=100;num++){
			sum+=num; //累加
		}
		System.out.println("sum="+sum);
		*/
		/*
		 *       sum=0
		 * num=1 sum=1
		 * num=2 sum=1+2
		 * num=3 sum=1+2+3
		 * num=4 sum=1+2+3+4
		 * ...
		 * num=100 sum=1+2+3+4+...+100
		 * num=101
		 */
	}
}













