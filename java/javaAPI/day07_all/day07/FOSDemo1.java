package day07;

import java.io.IOException;
import java.io.RandomAccessFile;

/**
 * 文件输出流
 * java.io.FileOutputStream
 * 是一个低级流，用于向指定文件中写出字节。
 * @author Administrator
 *
 */
public class FOSDemo1 {
	public static void main(String[] args) throws IOException {
		/*
		 * 向文件fos.txt中写出数据
		 * 写出一个字符串：
		 * 摩擦摩擦，似魔鬼的步伐。  
		 */
		String str = "你好";
		/*
		 * String->byte[]
		 * 
		 * byte[] getBytes()
		 * 将当前字符串按照系统默认的字符集转换为
		 * 对应的一组字节。
		 * 
		 * byte[] getBytes(String csn)
		 * 根据给定的字符集将当前字符串转换为一组
		 * 字节。常见的字符集:
		 * GBK:国标编码，中文占2字节
		 * UTF-8:unicode的一个子集，其中中文
		 *       占3个字节
		 * ISO8859-1:欧洲编码集，不支持中文。
		 */
		byte[] data = str.getBytes("GBK");
		
		//RandomAccessFile形式
		RandomAccessFile raf
			= new RandomAccessFile(
				"fos.txt","rw"	
			);
		//先把指针移动到文件末尾，可以实现追加操作
		raf.seek(raf.length());
		raf.write(data);
		raf.close();
		
		//FileOutputStream形式
//		FileOutputStream fos
//			= new FileOutputStream("fos.txt");
//		fos.write(data);
//		fos.close();
		
		
	}
}






