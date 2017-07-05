package demo;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class ApplicationContext {
	private Map<String, Object> beans=
			new HashMap<String, Object>();
	public ApplicationContext(String xml)
		throws Exception {
		//初始化Bean容器：根据配置文件，
		//创建每个bean对象
		SAXReader reader=new SAXReader();
		//从包里面读取文件
		InputStream in=
			ApplicationContext.class
			.getClassLoader()
			.getResourceAsStream(xml);
		Document doc=reader.read(in);
		Element root=doc.getRootElement();
		List<Element> els=root.elements();
		for(Element e:els){
			//e 就是xml 中的 bean 元素
			String id=e.attributeValue("id");
			String className=
				e.attributeValue("class");
			//利用反射动态创建bean对象
			Class cls=Class.forName(className);
			Object obj=cls.newInstance();
			//将创建的bean对象保存到beans集合中
			beans.put(id, obj);
		}
		
	}
	
	public Object getBean(String id){
		//返回容器中某个bean对象
		return beans.get(id); 
	}
}



