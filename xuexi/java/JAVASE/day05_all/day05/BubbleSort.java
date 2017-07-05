package day05;
//冒泡排序
public class BubbleSort {
	public static void main(String[] args) {
		/*
		 * 1)声明整型数组arr，包含10个元素
		 * 2)给arr中每个元素赋值为0到99的随机数，并输出
		 * 3)冒泡算法对arr升序排列
		 * 4)输出arr中的每个元素
		 */
		int[] arr = new int[10];
		for(int i=0;i<arr.length;i++){
			arr[i] = (int)(Math.random()*100);
			System.out.println(arr[i]);
		}
		for(int i=0;i<arr.length-1;i++){
			for(int j=0;j<arr.length-1-i;j++){
				if(arr[j]>arr[j+1]){
					int t=arr[j];
					arr[j]=arr[j+1];
					arr[j+1]=t;
				}
			}
		}
		System.out.println("排序后:");
		for(int i=0;i<arr.length;i++){
			System.out.println(arr[i]);
		}
	}
}













