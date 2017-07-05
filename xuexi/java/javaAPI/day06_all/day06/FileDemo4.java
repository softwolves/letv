package day06;

import java.io.File;

/**
 * 创建一个多级目录
 * @author Administrator
 *
 */
public class FileDemo4 {
	public static void main(String[] args) {
		/*
		 * 在当前目录下创建目录:
		 * a/b/c/d/e/f
		 */
		File dir = new File(
			"a" + File.separator +
			"b" + File.separator +
			"c" + File.separator +
			"d" + File.separator +
			"e" + File.separator +
			"f" 
		);
		if(!dir.exists()){
			/*
			 * 在创建当前目录的同时将所有不存在的
			 * 父目录一并创建出来。
			 */
			dir.mkdirs();
			System.out.println("创建完毕!");
		}else{
			System.out.println("目录已存在!");
		}
		
	}
}





