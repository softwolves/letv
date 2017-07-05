package web;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class MyListener 
	implements HttpSessionListener,
		HttpSessionAttributeListener {

	public void sessionCreated(HttpSessionEvent e) {
		System.out.println("session创建");
		System.out.println(e.getSession());
	}

	public void sessionDestroyed(HttpSessionEvent arg0) {
		System.out.println("session销毁");
	}

	public void attributeAdded(HttpSessionBindingEvent arg0) {
		System.out.println("向session添加数据");
	}

	public void attributeRemoved(HttpSessionBindingEvent arg0) {
		
	}

	public void attributeReplaced(HttpSessionBindingEvent arg0) {
		
	}

}



