package day06;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;

/**
 * 从文件中读取字节
 * @author Administrator
 *
 */
public class RandomAccessFileDemo2 {
	public static void main(String[] args) throws IOException {
		/*
		 * 从raf.dat文件中读取字节
		 */
		RandomAccessFile raf
			= new RandomAccessFile(
				"raf.dat","r"
			);
		
		/*
		 * int read()
		 * 读取1个字节，并以int形式返回。
		 * 若返回值为-1,则表示读取到了文件末尾
		 * 即:EOF(end of file)
		 * 
		 * 00000000 00000000 00000000 00000001
		 */
		int d = raf.read();
		System.out.println(d);
		
		raf.close();
		
	}
}





