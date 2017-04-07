package day06;

import java.io.File;

/**
 * 删除目录
 * @author Administrator
 *
 */
public class FileDemo5 {
	public static void main(String[] args) {
		File dir = new File("demo");
		if(dir.exists()){
			/*
			 * 删除目录有一个要求，该目录必须是一个
			 * 空目录才可以将其删除。
			 */
			dir.delete();
			System.out.println("删除完毕!");
		}else{
			System.out.println("该目录不存在!");
		}
	}
}





