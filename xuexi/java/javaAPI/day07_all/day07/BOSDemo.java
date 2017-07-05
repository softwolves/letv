package day07;

import java.io.BufferedOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * 使用缓冲输出流写出数据的注意事项
 * @author Administrator
 *
 */
public class BOSDemo {
	public static void main(String[] args) throws IOException {
		FileOutputStream fos
			= new FileOutputStream("bos.txt");
		BufferedOutputStream bos
			= new BufferedOutputStream(fos);
		
		bos.write("你好!".getBytes());
		/*
		 * 强制将当前缓冲流的缓冲区内容全部写出。
		 * 需要注意，频繁flash会提高写出次数，降低
		 * 写出效率。但是写出的即时性得以保证。
		 */
		bos.flush();
		//close前会自动flush,关流只需管最外层高级流
		bos.close();
	}
}







