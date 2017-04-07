package day06;

import java.io.File;
import java.io.IOException;

/**
 * java.io.File
 * 使用File创建新文件
 * @author Administrator
 *
 */
public class FileDemo1 {
	public static void main(String[] args) throws IOException {
		/*
		 * 在当前项目根目录下创建test.txt文件
		 * 直接给名字则默认在当前目录下。
		 */
		File file = new File("test.txt");
		/*
		 * boolean exists()
		 * 判断当前 File表示的文件或目录是否已经
		 * 存在了。
		 */
		if(!file.exists()){
			//创建该文件
			file.createNewFile();
			System.out.println("创建完毕!");
		}else{
			System.out.println("该文件已存在!");
		}
	}
}






