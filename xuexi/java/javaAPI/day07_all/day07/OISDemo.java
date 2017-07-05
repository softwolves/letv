package day07;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;

/**
 * java.io.ObjectInputStream
 * 对象输入流，高级流，使用该流可以很方便的将读取到的
 * 字节转换为对应的对象。前提是读取的字节必须是经由
 * ObjectOutputStream序列化对象后得到的。
 * @author Administrator
 *
 */
public class OISDemo {
	public static void main(String[] args) throws IOException, ClassNotFoundException {
		FileInputStream fis
			= new FileInputStream(
				"person.obj"
			);
		
		ObjectInputStream ois
			= new ObjectInputStream(fis);
		/*
		 * Object readObject()
		 * 该方法会通过fis将字节从文件中读取出来，
		 * 然后[反序列化]成对象后返回。
		 */
		Person p = (Person)ois.readObject();
		
		System.out.println(p);
		
		ois.close();
		
	}
}





