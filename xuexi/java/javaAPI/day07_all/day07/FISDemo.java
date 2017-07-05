package day07;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * java.io.FileInputStream
 * 使用文件输入流，读取文件数据
 * @author Administrator
 *
 */
public class FISDemo {
	public static void main(String[] args) throws IOException {
		FileInputStream fis
			= new FileInputStream("fos.txt");
		
		byte[] data = new byte[100];
	
		int len = fis.read(data);
		System.out.println("读取到了"+len+"个字节");
		
		/*
		 * byte[]->String
		 * 下面的构造方法可以将给定的字节数组中指定范围
		 * 内的字节按照系统默认字符集转换为字符串，若不
		 * 指定范围，则是将字节数组中所有字节进行转换。
		 * 最后可以添加一个字符串参数，指定字符集。
		 */
		String str = new String(data,0,len,"GBK");
		System.out.println(str);
		fis.close();
		
	}
}




