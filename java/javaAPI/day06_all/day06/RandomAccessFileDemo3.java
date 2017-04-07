package day06;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;

/**
 * RandomAccessFile提供了可以方便读写
 * java中不同数据类型数据的方法。
 * @author Administrator
 *
 */
public class RandomAccessFileDemo3 {
	public static void main(String[] args) throws IOException {
		RandomAccessFile raf
			= new RandomAccessFile(
				"raf.dat","rw"	
			);
		/*
		 * long getFilePointer()
		 * 该方法可以获取当前RandomAccessFile的
		 * 指针位置。
		 * 刚创建的RAF指针位置在文件开始处，以下标
		 * 形式表示，所以第一个字节位置为0.
		 */
		long pos = raf.getFilePointer();
		System.out.println("pos:"+pos);
		
		int imax = Integer.MAX_VALUE;
		/*
		 * 一次性写出4个字节，将给定的int值对应的
		 * 32位2进制全部写出
		 */
		raf.writeInt(imax);
		System.out.println("pos:"+raf.getFilePointer());
		
		
		//一次性写出8个字节
		double d = 123.123;
		raf.writeDouble(d);
		System.out.println("pos:"+raf.getFilePointer());
		
		
		//一次性写出8个字节
		long l = 1234;
		raf.writeLong(l);
		System.out.println("pos:"+raf.getFilePointer());
		
		/*
		 * void seek(long pos)
		 * 将指针移动到指定位置处
		 */
		System.out.println("将指针移动到文件开始处");
		raf.seek(0);
		System.out.println("pos:"+raf.getFilePointer());
		/*
		 * int readInt()
		 * 连续读取4个字节，并转换为int值返回。
		 * 若读取到文件末尾会抛出EOFException
		 */
		int i = raf.readInt();
		System.out.println(i);
		System.out.println("pos:"+raf.getFilePointer());
		
		
		//读取long值
		raf.seek(12);
		l = raf.readLong();
		System.out.println(l);
		System.out.println("pos:"+raf.getFilePointer());
		
		//读取double值
		raf.seek(4);
		d = raf.readDouble();
		System.out.println(d);
		System.out.println("pos:"+raf.getFilePointer());
		raf.close();
		
	}
}









