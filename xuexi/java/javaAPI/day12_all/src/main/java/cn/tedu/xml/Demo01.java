package cn.tedu.xml;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.List;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

public class Demo01 {

	public static void main(String[] args) 
		throws Exception {
		SAXReader reader = new SAXReader();
		FileInputStream in =
			new FileInputStream("demo.xml");
		//读取XML文件到doc对象
		Document doc=reader.read(in);
		//doc 是全部的XML文件的内容
		//doc 引用的是内存中的对象。
		//System.out.println(doc.asXML()); 
		
		//获取XML的根元素
		//访问XML中数据的唯一入口。
		Element root = doc.getRootElement();
		//System.out.println(root.asXML()); 
		
		//用名字查找返回第一个满足条件的子元素
		//Element e = root.element("book");
		//System.out.println(e.asXML());
		
//		List<Element> list=root.elements();
//		for(Element e:list){
//			//System.out.println(e.asXML());
//			System.out.println(e.getName()); 
//		}
		
		Element e = root.element("book");
		Element n = e.element("name");
		System.out.println(n.asXML());
		System.out.println(n.getText()); 
		
		Attribute attr = e.attribute("id");
		System.out.println(attr.asXML());
		System.out.println(attr.getName());
		System.out.println(attr.getValue()); 
		
		
		//如果修改了doc, 就能实现修改XML并写文件
		Element newOne=root.addElement("book");
		newOne.addElement("name")
			.setText("18岁给我一个姑娘");
		newOne.addElement("author")
			.setText("冯唐"); 
		newOne.addAttribute("id", "b5");
		newOne.addAttribute("lang", "中文"); 
		
		//找到子元素并且删除这个子元素
		Element book = root.element("book");
		root.remove(book);
		
		Element b2 = root.element("book");
		//修改元素的内容
		Element author = b2.element("author");
		author.setText("佚名"); 
		//修改属性
		Attribute id = b2.attribute("id");
		id.setValue("b8"); 
		
		//写XML Document 对象 到文件中
		FileOutputStream out = 
			new FileOutputStream("ok.xml");
		//dom4j 提供了格式工具，可以输出时候
		//对doc进行化妆，搞漂亮（Pretty）一些
		OutputFormat fmt = 
			OutputFormat.createPrettyPrint();
		//XMLWriter 是dom4j 提供的高级流，
		//需要依赖低级的字节流。
		XMLWriter writer = 
			new XMLWriter(out, fmt);
		//将doc对象（XML）写到流中
		writer.write(doc);
		writer.close();
		
		
		
	}
}





