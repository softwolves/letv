package annotation;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * 演示 使用@Resource来完成依赖注入。
 *
 */
@Component("manager")
public class Manager {
	private Waiter wt;
	@Value("#{config.pagesize}")
	//@Value也可以添加到对应的set方法前面。
	private String pageSize;
	@Value("马云")
	//@Value也可以用来注入基本类型的值
	private String name;
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPageSize() {
		return pageSize;
	}

	public void setPageSize(String pageSize) {
		this.pageSize = pageSize;
	}

	public Manager() {
		System.out.println(
				"Manager的无参构造器...");
	}

	@Override
	public String toString() {
		return "Manager [wt=" + wt + ", pageSize=" + pageSize + ", name=" + name + "]";
	}

	public Waiter getWt() {
		return wt;
	}

	@Resource(name="wt")
	/*
	 * name属性指定被注入的bean的id,
	 * 如果不指定，会按照byType的方式
	 * 来注入。
	 */
	public void setWt(Waiter wt) {
		System.out.println("Manager的setWt()...");
		this.wt = wt;
	}
	
}
