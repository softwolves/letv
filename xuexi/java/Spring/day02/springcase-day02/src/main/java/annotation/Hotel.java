package annotation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 * 演示 使用@Autowired来完成依赖注入
 * （构造器方式）
 */
@Component("hotel")
public class Hotel {
	private Waiter wt;
	
	public Hotel() {
		System.out.println(
				"Hotel的无参构造器...");
	}
	
	@Autowired
	public Hotel(@Qualifier("wt") Waiter wt) {
		System.out.println(
				"Hotel的带参构造器...");
		this.wt = wt;
	}

	@Override
	public String toString() {
		return "Hotel [wt=" + wt + "]";
	}
	
}
