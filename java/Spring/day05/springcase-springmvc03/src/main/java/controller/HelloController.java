package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelloController {
	@RequestMapping("/hello.do")
	public String hello(){
		System.out.println("hello()...");
		return "hello";
	}
	
	@RequestMapping("/demo/hello.do")
	public String hello2(){
		System.out.println("hello2()...");
		return "hello";
	}
	
}
