package day07;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * java.io.ObjectOutputStream
 * 对象输出流。是一个高级流。使用该流可以很方便的将
 * java中的任意对象转换为字节后写出。
 * @author Administrator
 *
 */
public class OOSDemo {
	public static void main(String[] args) throws IOException {
		Person p = new Person();
		p.setName("苍老师");
		p.setAge(22);
		p.setGender("女");
		List<String> otherInfo
			= new ArrayList<String>();
		
		otherInfo.add("是一名演员");
		otherInfo.add("喜欢写毛笔字");
		otherInfo.add("促进中日文化交流");
		otherInfo.add("擅长爱情电影，和动作电影");
		p.setOtherInfo(otherInfo);
		System.out.println(p);
		
		FileOutputStream fos
			= new FileOutputStream("person.obj");
		/*
		 * 对象输出流，可以方便的将对象转换为字节后写出，
		 * 这里由于该对象流处理的是文件输出流，所以经过
		 * 该流写出的对象首先会先转换为一组字节，然后再
		 * 经由文件输出流写入到了文件中。
		 * 
		 * 对象->oos->变为一组字节->fos->写入到了文件
		 */
		ObjectOutputStream oos
			= new ObjectOutputStream(fos);
		/*
		 * 该方法就是将对象写出的。会将该对象
		 * 转换为一组字节，这是OOS的独有方法。
		 * 
		 * 将对象转换为一组字节的过程:对象序列化
		 * 将数据从内存搬到硬盘的过程称为:持久化
		 */
		oos.writeObject(p);
		System.out.println("写出完毕!");
		oos.close();
		
	}
}



