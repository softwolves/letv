package annotation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 * 演示 使用@Autowired来完成
 * 依赖注入(set方法)。
 */
@Component("rest")
public class Restaurant {
//	@Autowired
//	@Qualifier("wt")
	/*
	 * 这两个注解也可以直接添加到属性前面。
	 * 此时，对应的set方法可以不要。
	 */
	private Waiter wt;
	
	public Restaurant() {
		System.out.println(
				"Restaurant的无参构造器...");
	}

	@Override
	public String toString() {
		return "Restaurant [wt=" + wt + "]";
	}

	public Waiter getWt() {
		return wt;
	}

	@Autowired  
	/*
	 * 如果没有使用@Qualifier来指定被注入的
	 * bean的id,则spring容器默认会按照byType
	 * 的方式来完成注入。
	 */
	public void setWt(@Qualifier("wt") Waiter wt) {
		System.out.println(
				"Restaurant的setWt()...");
		this.wt = wt;
	}
	
}
