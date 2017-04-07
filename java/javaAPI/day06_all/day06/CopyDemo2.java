package day06;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;

/**
 * 若想提高读写效率，需要通过提高每次读写的数据量
 * 来减少读写的次数达到。
 * 读写硬盘的次数越多，读写效率越差。
 * @author Administrator
 *
 */
public class CopyDemo2 {
	public static void main(String[] args) throws IOException {
		RandomAccessFile src
			= new RandomAccessFile(
				"zhj.flv","r"	
			);
		RandomAccessFile desc
			= new RandomAccessFile(
				"zhj_copy1.flv","rw"	
			);
		
		/*
		 * 一次读取一组字节的方法:
		 * int read(byte[] data)
		 * 一次性读取给定数组data的length个字节，
		 * 并且将读取的字节全部存入到data数组中.
		 * 返回值为实际读取到的字节量，若为-1，则表示
		 * 本次没有读取到任何字节(文件末尾)
		 */
		//10k
		byte[] buf = new byte[1024*10];
		int len = -1;
		
		long start = System.currentTimeMillis();
		while((len = src.read(buf))!=-1){
			/*
			 * void write(byte[] data)
			 * 将给定的字节数组中的所有字节一次性写出
			 * 
			 * void write(byte[] d,int s,int len)
			 * 将给定数组中从下标为s处的字节开始的连续len
			 * 个字节一次性写出
			 */
			desc.write(buf,0,len);
		}
		long end = System.currentTimeMillis();
		System.out.println("复制完毕!耗时:"+(end-start)+"ms");
		
		src.close();
		desc.close();
	}
}






