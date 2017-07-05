package controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

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
	
	@RequestMapping("/toLogin.do")
	public String toLogin(){
		System.out.println(
				"HelloController"
				+ "的toLogin()...");
		return "login";
	}
	
	@RequestMapping("/login.do")
	/*
	 * 读取请求参数的第一种方式：
	 * 使用request对象。
	 * 注：
	 * 前端控制器会将request对象作为参数
	 * 传进来。
	 */
	public String checkLogin(
			HttpServletRequest request){
		System.out.println("HelloController's "
				+ "checkLogin()...");
		String adminCode = 
				request.getParameter("adminCode");
		String pwd = 
				request.getParameter("pwd");
		System.out.println("adminCode:" 
				+ adminCode + " pwd:" + pwd);
		return "index";
	}
	
	
	@RequestMapping("/login2.do")
	/*
	 * 读取请求参数的第二种方式：
	 * 使用请求参数名作为方法的参数名。
	 * 注：如果不一致，可以使用@RequestParam注解。
	 */
	public String checkLogin2(
			String adminCode,
			@RequestParam("pwd") String pwd1){
		System.out.println("checkLogin2()...");
		System.out.println("adminCode:"
		+ adminCode + " pwd:" + pwd1);
		return "index";
	}
	
	@RequestMapping("/login3.do")
	/*
	 * 读取请求参数值的第三种方式：
	 * 封装成javabean。
	 */
	public String checkLogin3(Admin admin){
		System.out.println("checkLogin3()...");
		System.out.println("adminCode:"
		+ admin.getAdminCode() 
		+ " pwd:" + admin.getPwd());
		return "index";
	}
	
	
	@RequestMapping("/login4.do")
	/*
	 * 向页面传值的第一种方式：
	 * 使用request对象绑订数据。
	 */
	public String checkLogin4(
			Admin admin,
			HttpServletRequest request){
		System.out.println("checkLogin4()...");
		System.out.println("adminCode:"
		+ admin.getAdminCode());
		//向页面传值
		request.setAttribute("adminCode",
				admin.getAdminCode());
		//默认是转发
		return "index";
	}
	
	
	@RequestMapping("/login5.do")
	/*
	 * 向页面传值的第二种方式：
	 * 使用ModelMap作为方法的参数。
	 */
	public String checkLogin5(Admin admin,
			ModelMap data){
		System.out.println("checkLogin5()...");
		System.out.println("adminCode:"
		+ admin.getAdminCode());
		/*
		 * 等同于request.setAttribute
		 */
		data.addAttribute("adminCode",
				admin.getAdminCode());
		return "index";
	}
	
	
	@RequestMapping("/login6.do")
	/*
	 * 向页面传值的第三种方式：
	 * 使用session对象绑订数据。
	 */
	public String checkLogin6(Admin admin,
			HttpSession session){
		System.out.println("checkLogin6()...");
		System.out.println("adminCode:" 
		+ admin.getAdminCode());
		session.setAttribute("adminCode", 
				admin.getAdminCode());
		return "index";
	}
	
	@RequestMapping("/login7.do")
	/*
	 * 向页面传值的第四种方式：
	 * 使用ModelAndView对象作为方法的返回值。
	 */
	public ModelAndView checkLogin7(
			Admin admin){
		System.out.println("checkLogin7()...");
		System.out.println("adminCode:" 
		+ admin.getAdminCode());
		
		Map<String,Object> data = 
				new HashMap<String,Object>();
		//相当于request.setAttribute
		data.put("adminCode", 
				admin.getAdminCode());
		ModelAndView mav = 
				new ModelAndView("index",data);
		return mav;
	}
	
	@RequestMapping("/login8.do")
	/*
	 * 重定向的第一种方式：
	 * 如果处理方法的返回值是String,
	 * 需要在重定向地址前添加 "redirect:"。
	 */
	public String checkLogin8(){
		System.out.println(
				"checkLogin8()...");
		return "redirect:toIndex.do";
	}
	
	@RequestMapping("/login9.do")
	/*
	 * 重定向的第二种方式：
	 */
	public ModelAndView checkLogin9(){
		System.out.println("checkLogin9()...");
		RedirectView rv =
				new RedirectView(
						"toIndex.do");
		return new ModelAndView(rv);
	}
	
	@RequestMapping("/toIndex.do")
	public String toIndex(){
		System.out.println(
				"toIndex()...");
		return "index";
	}
	
	
}
