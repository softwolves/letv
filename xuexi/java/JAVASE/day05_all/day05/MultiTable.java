package day05;
//九九乘法表
public class MultiTable {
	public static void main(String[] args) {
		for(int num=1;num<=9;num++){ //控制行
			for(int i=1;i<=num;i++){ //控制列
				System.out.print(i+"*"+num+"="+i*num+"\t");
			}
			System.out.println(); //换行
		}
		/*
		 * num=3
		 *   i=1 1*3=3
		 *   i=2 2*3=6
		 *   i=3 3*3=9
		 *   i=4  换行
		 * num=2
		 *   i=1 1*2=2
		 *   i=2 2*2=4
		 *   i=3  换行
		 * num=1
		 *   i=1 1*1=1
		 *   i=2  换行
		 */
	}
}













