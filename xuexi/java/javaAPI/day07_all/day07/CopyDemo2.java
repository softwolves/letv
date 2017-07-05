package day07;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * 使用缓冲流提高读写效率
 * 
 * 缓冲流是高级流。
 * 
 * 高级流:高级流是用来处理其他流的，目的是简化我们
 *       的读写操作。高级流不独立存在，因为没有意义。
 * 低级流:低级流是真实负责读写数据的流。数据源明确。
 * 
 *       
 * @author Administrator
 *
 */
public class CopyDemo2 {
	public static void main(String[] args) throws IOException {
		FileInputStream fis
			= new FileInputStream("zhj.flv");
		BufferedInputStream bis
			= new BufferedInputStream(fis);
		
		
		FileOutputStream fos
			= new FileOutputStream("zhj_cp1.flv");
		BufferedOutputStream bos
			= new BufferedOutputStream(fos);
		
		int d = -1;
		long start = System.currentTimeMillis();
		/*
		 * 缓冲流内部有一个字节数组，作为缓冲区，当第一次
		 * 调用read方法读取一个字节时，缓冲流实际上读取了
		 * 若干字节，并存入其内部的字节数组中，然后返回第一
		 * 个字节，当我们再次调用read方法时，它就不会再去
		 * 读取了，而是字节将字节数组中第二个字节返回。直到
		 * 当前字节数组中所有字节全部返回后，才会在下次read
		 * 方法时再次读取若干字节并存入字节数组。
		 * 所以缓冲流也是依靠一次读写多个字节，减少读写次数
		 * 来提高的读写效率。
		 * 
		 */
		while((d=bis.read())!=-1){
			bos.write(d);
		}
		long end = System.currentTimeMillis();
		
		System.out.println("复制完毕!耗时:"+(end-start)+"ms");
		fis.close();
		fos.close();
	}
}









