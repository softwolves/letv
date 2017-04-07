package day06;
import java.util.Scanner;
//猜字符游戏
public class Guessing {
	
	//主方法
	public static void main(String[] args) {
		/*
		//单独测试方法的代码
		char[] c1 = {'A','B','C','D','E'};
		char[] c2 = {'N','B','M','A','E'};
		int[] result = check(c1,c2);
		//输出result[0]和result[1]
		
		char[] chs = generate(); 
		System.out.println(chs);
		*/
		
		Scanner scan = new Scanner(System.in);
		int level;
		do{
			System.out.println("请输入等级(5、7、9):");
			level = scan.nextInt();
		}while(level!=5 && level!=7 && level!=9);
		
		char[] chs = generate(level); //获取随机字符数组
		System.out.println(chs); //作弊
		int count = 0; //猜错的次数
		while(true){ //自造死循环
			System.out.println("猜吧!"); //"abCDe"----"ABCDE"
			String str = scan.next().toUpperCase(); //获取用户输入的字符串并转换为大写字母
			if(str.equals("EXIT")){
				System.out.println("下次再来吧!");
				break;
			}
			char[] input = str.toCharArray(); //将字符串转换成字符数组
			int[] result = check(chs,input); //对比:随机字符数组与用户输入的字符数组
			if(result[0]==chs.length){ //猜对了
				int score = 100*chs.length-10*count; //一个字符100分，猜错一次扣10分
				System.out.println("恭喜你，猜对了，得分为:"+score);
				break; //结束循环
			}else{ //猜错了
				count++; //猜错次数增1
				System.out.println("字符对个数:"+result[1]+"，位置对个数:"+result[0]);
			}
		}
	}
	
	//生成随机字符数组
	public static char[] generate(int level){
		char[] chs = new char[level]; //随机字符数组
		
		char[] letters = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
				'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
				'W', 'X', 'Y', 'Z' }; //字符可选范围数组
		boolean[] flags = new boolean[letters.length]; //开关数组，默认为false，表示未存过
		for(int i=0;i<chs.length;i++){ //遍历随机字符数组
			int index; //随机下标
			do{
				index = (int)(Math.random()*letters.length); //生成随机下标(0到25之间)
			}while(flags[index]==true); //若下标对应的开关为true时，表示已存过，则重新生成index
			                            //当下标对应的开关为false时，表示未存过，条件为假循环结束
			chs[i] = letters[index]; //基于index下标去letters中获取数据，并赋值给chs中的每一个元素
			flags[index] = true; //修改index下标对应的开关为true，表示已存过
		}
		
		return chs;
	}

	//对比:随机字符数组与用户输入的字符数组
	public static int[] check(char[] chs,char[] input){
		int[] result = new int[2]; //对比结果 result[0]为位置对 result[1]为字符对，默认都是0
		for(int i=0;i<chs.length;i++){ //遍历随机字符数组
			for(int j=0;j<input.length;j++){ //遍历用户输入的字符数组
				if(chs[i]==input[j]){ //字符对
					result[1]++; //字符对个数增1
					if(i==j){ //位置对
						result[0]++; //位置对个数增1
					}
					break; //与input字符匹配后，input的其余字符不再参与比较了
				}
			}
		}
		return result;
	}
	
}




















