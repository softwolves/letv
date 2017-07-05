package day07;

import java.io.Serializable;
import java.util.List;

/**
 * 使用该类测试对象流的对象读写操作
 * 
 * 所有需要被ObjectOutputStream写出的对象
 * 都必须实现Serializable接口。
 * @author Administrator
 *
 */
public class Person implements Serializable{
	/**
	 *  当一个类实现了Serializalble接口后，应当
	 *  定义一个常量serialVersionUID.该常量的值
	 *  表示当前类的版本号。
	 *  该版本号的值直接影响着反序列化的结果。
	 *  若不指定该常量，那么当前类的实例在被
	 *  ObjectOutputStream进行序列化时会自动生成一个
	 *  版本号并包含在序列化后的字节中。而生成的版本号是
	 *  根据当前类的结构，只要当前类的属性以及类型没有发
	 *  生改变，版本号是不会变得，但是一旦改变，那么版本号
	 *  是会变化的。
	 *  为了可以控制反序列化的结果，版本号应当自行定义。
	 *  
	 *  版本号对于反序列化的影响：
	 *  当使用ObjectInputStream进行对象反序列化时，首先
	 *  会检查该字节中描述的对象的版本号是多少，然后在和该对象
	 *  所属的类当前的版本号比对，若一致，则可以进行反序列化，
	 *  若不一致则反序列化会抛出异常，不再允许进行反序列化。
	 *  
	 *  若待反序列化的字节描述的对象的结构与其所属类现有的
	 *  结构不一致时，若版本号一致，则会启用兼容模式，即:
	 *  仍然有的属性就还原，已经没有的属性则忽略。
	 */
	private static final long serialVersionUID = 1L;
	private String name;
	private int age;
	private String gender;
	/*
	 * 一个对象在进行序列化后得到的字节量往往比当前
	 * 对象本身存储的内容要大很多。当该对象的某些属性
	 * 在序列化时不需要，那么可以使用transient关键字
	 * 将其忽略，这样当前对象在序列化后的字节中就不再
	 * 包含这些属性的值了。从而达到了对象"瘦身"的效果。
	 * transient关键字除了序列化时标示属性忽略外，没有
	 * 其他任何作用。
	 *
	 */
	private transient List<String> otherInfo;
	public Person(){
		
	}
	public Person(String name, int age, String gender, List<String> otherInfo) {
		super();
		this.name = name;
		this.age = age;
		this.gender = gender;
		this.otherInfo = otherInfo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public List<String> getOtherInfo() {
		return otherInfo;
	}
	public void setOtherInfo(List<String> otherInfo) {
		this.otherInfo = otherInfo;
	}
	
	public String toString(){
		return name+","+age+","+gender+","+otherInfo;
	}
}





