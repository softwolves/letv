package day07;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * FOS的覆盖写模式与追加写模式
 * @author Administrator
 *
 */
public class FOSDemo2 {
	public static void main(String[] args) throws IOException {
		/*
		 * 以默认形式创建的FOS，若写出的文件已经存在，
		 * 这会将该文件所有内容全部清除后重新开始写操作。
		 * 覆盖写操作。
		 * 
		 * 追加写操作:在当前文件末尾开始写入写内容。只需
		 * 要使用重载构造方法，第二个参数传入true即可。
		 */
		FileOutputStream fos
			= new FileOutputStream("fos.txt",true);
		
		fos.write("你好".getBytes("GBK"));
		
		System.out.println("写出完毕!");
		fos.close();
	}
}







