package day06;
import java.util.Scanner;

public class Homework1 {

	public static void main(String[] args) {
	System.out.println("欢迎玩游戏！");
	Scanner scan=new Scanner(System.in);
	int level;
	
	do{System.out.println("请输入游戏等级（5、7、9？）");
		 level=scan.nextInt();
	}while(level!=5&&level!=7&&level!=9);
        System.out.println(3333);
		char[]chs=generate(level);
		System.out.println(chs);
		System.out.println("猜吧");
		
		int score;
		int count=0;
	while(true){
		System.out.println("游戏开始输入所猜的"+level+"字母的序列（exit---退出）");
		String str=scan.next().toUpperCase();
		if(str.equals("EXIT")){
			System.out.println("白白");
			break;
		}
		
		char[]input=str.toCharArray();
		int[]result=check(input,chs);
		if(result[1]==level){
			score=100*level-count*10;
			System.out.println("恭喜你答对了你的得分是"+score);
			break;
		}else{
			count++;
			System.out.println("字母对了"+result[0]+"位置对了"+result[1]);
			
		}
		
	}
	}
	
	
	public static char[]generate(int level){
		System.out.println(2111);
		char[]shc=new char[level];
		char[]letters={'A','B','C','D','E'
				,'F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T',
				'U','V','W','X','Y','Z'};
		boolean[]flags=new boolean[letters.length];
		for(int i=0;i<shc.length;i++){
			int index; 
		do{	
		 index=(int)(Math.random()*(letters.length));
		}while(flags[index]==true);
		shc[i]=letters[index];
		flags[index]=true;
		}
		
		return shc;
	}
	
	
	
	
	
	
	
	public static int[] check(char[]input,char[]chs){
		int[]result=new int[2];
		for(int i=0;i<input.length;i++){
			for(int j=0;j<chs.length;j++){
				if(input[i]==chs[j]){
					result[0]++;
					if(i==j){
						result[1]++;
					}
					break;
				}
				
			}
		}
		return result;
	}

}
