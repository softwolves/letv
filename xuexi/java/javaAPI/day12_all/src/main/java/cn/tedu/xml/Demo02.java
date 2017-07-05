package cn.tedu.xml;

import java.io.FileOutputStream;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;

public class Demo02 {

	public static void main(String[] args) 
		throws Exception{
		//创建新的XML Document 对象
		Document doc = 
			DocumentHelper.createDocument();
		System.out.println(doc.asXML()); 
		//为doc添加根元素
		Element root =
			doc.addElement("students");
		System.out.println(doc.asXML()); 
		
		//为根元素添加子元素
		Element s1 = 
				root.addElement("student");
		s1.addElement("name").setText("Tom");
		s1.addAttribute("id", "s1");
		//...
		System.out.println(doc.asXML());
		//将doc写到文件
		FileOutputStream out =
			new FileOutputStream("stu.xml");
		OutputFormat fmt = 
			OutputFormat.createPrettyPrint();
		XMLWriter writer = 
			new XMLWriter(out, fmt);
		writer.write(doc);
		writer.close();
	}

}







