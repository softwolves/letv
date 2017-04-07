package day06;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;

/**
 * java.io.RandomAccessFile
 * 该类是用于读写文件数据的。读写数据是基于指针的操作，
 * 即:总是在指针当前位置进行读写。
 * RandomAccessFile有两种创建模式:
 * 只读模式:仅用于读取文件数据
 * 读写模式:对文件可以编辑(可读，可写)
 * @author Administrator
 *
 */
public class RandomAccessFileDemo1 {
	public static void main(String[] args) throws IOException {
		/*
		 * 针对raf.dat文件进行读写数据
		 * 
		 * 构造方法：
		 * RandomAccessFile(String path,String mode)
		 * RandomAccessFile(File file,String mode)
		 * 模式对应的字符串:
		 * "r":只读
		 * "rw"读写
		 */
		RandomAccessFile raf
			= new RandomAccessFile("raf.dat","rw");
		/*
		 * void write(int d)
		 * 将给定的int值的"低八位"2进制信息写入文件中
		 *                            vvvvvvvv
		 * 00000000 00000000 00000000 00000001
		 */
		raf.write(1);
		System.out.println("写出完毕!");
		//读写完毕后一定close
		raf.close();
	}
}







