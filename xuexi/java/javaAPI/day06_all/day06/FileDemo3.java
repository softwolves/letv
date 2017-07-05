package day06;

import java.io.File;

/**
 * 使用File创建一个目录
 * @author Administrator
 *
 */
public class FileDemo3 {
	public static void main(String[] args) {
		/*
		 * 在当前目录下创建一个名为demo的目录
		 */
		File dir = new File("demo");
		
		if(!dir.exists()){
			//创建该目录
			dir.mkdir();
			System.out.println("创建完毕!");
		}else{
			System.out.println("该目录已存在!");
		}
	}
}



