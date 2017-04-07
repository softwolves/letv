package day06;

import java.io.File;

/**
 * 获取一个目录下的所有子项
 * @author Administrator
 *
 */
public class FileDemo6 {
	public static void main(String[] args) {
		/*
		 * 获取当前目录下的所有子项
		 */
		File dir = new File(".");
		/*
		 * File[] listFiles()
		 * 获取当前目录下的所有子项
		 */
		File[] subs = dir.listFiles();
		for(File sub : subs){
			if(sub.isFile()){
				System.out.print("文件:");
			}else{
				System.out.print("目录:");
			}
			System.out.println(sub.getName());
		}
	}
}






