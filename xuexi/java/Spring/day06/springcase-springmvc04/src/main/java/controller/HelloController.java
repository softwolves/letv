package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelloController {
	@ExceptionHandler
	public String handler(Exception e,
			HttpServletRequest request){
		//依据异常类型，进行不同的处理
		if(e instanceof 
				NumberFormatException){
			request.setAttribute("msg",
					"亲，请输入正确的数字");
			return "message";
		}else if(e instanceof 
				StringIndexOutOfBoundsException){
			request.setAttribute("msg",
					"数组越界啦");
			return "message";
		}
		return "error3";
	}
	
	@RequestMapping("/hello.do")
	public String hello(){
		System.out.println("hello()...");
		String str = "123a";
		Integer.parseInt(str);
		return "hello";
	}
	
	
	@RequestMapping("/hello2.do")
	public String hello2(){
		System.out.println("hello()...");
		String str = "abcd";
		str.charAt(10);
		return "hello";
	}
}
