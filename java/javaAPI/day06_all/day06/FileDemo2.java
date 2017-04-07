package day06;

import java.io.File;

/**
 * 删除一个文件
 * @author Administrator
 *
 */
public class FileDemo2 {
	public static void main(String[] args) {
		/*
		 * 删除当前目录下的test.txt
		 */
		File file = new File("test.txt");
		if(file.exists()){
			//删除File表示的文件或目录
			file.delete();
			System.out.println("删除完毕!");
		}else{
			System.out.println("该文件不存在!");
		}
	}
}







