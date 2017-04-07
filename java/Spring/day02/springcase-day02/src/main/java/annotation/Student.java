package annotation;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

/**
 * 
 * 演示 组件扫描
 * 	
 * 	默认的id是首字母小写之后的类名。
 */
@Component("stu")
@Scope("singleton")
@Lazy(true)
public class Student {
	
	@PostConstruct
	//初始化方法
	public void init(){
		System.out.println(
				"Student的init()...");
	}
	
	@PreDestroy
	//销毁方法
	public void destroy(){
		System.out.println(
				"Student的destroy()...");
	}

	public Student() {
		System.out.println(
				"Student的无参构造器...");
	}

}


