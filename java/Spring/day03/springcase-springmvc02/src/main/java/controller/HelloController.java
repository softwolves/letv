package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 处理器类。
 * 
 * 1.不用实现Controller接口。<br/>
2.可以添加多个处理方法。也就是说，一个Controller可以处理多个
请求。<br/>
3.处理方法的名称不作要求(不必是HandleRequest),返回值可以是
String或者ModelAndView(如果返回值没有处理结果，只是返回一个
视图名的话，可以返回String)。
4.在类名前添加@Controller注解。<br/>
5.在类名前或者方法前添加@RequestMapping注解(告诉前端控制器，
请求地址与处理方法的对应关系)。
 */
@Controller
public class HelloController {
	
	@RequestMapping("/hello.do")
	public String hello(){
		System.out.println(
				"HelloController"
				+ "的hello()...");
		return "hello";
	}
	
}
