package interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * 拦截器
 *
 */
public class SomeInterceptor implements 
HandlerInterceptor{

	/**
	 * 整个请求已经处理完毕，最后
	 * 执行的一个方法。
	 * ex: 处理器(Controller)方法运行时
	 * 抛出的异常。
	 */
	public void afterCompletion(
			HttpServletRequest req, 
			HttpServletResponse res,
			Object arg2, Exception ex)
			throws Exception {
		System.out.println(
				"afterCompletion()...");
	}
	

	/**
	 * 处理器的方法已经执行完毕，正准备返回
	 * ModelAndView给前端控制器之前，执行
	 * postHandle方法。
	 */
	public void postHandle(
			HttpServletRequest req, 
			HttpServletResponse res, 
			Object arg2, ModelAndView arg3)
			throws Exception {
		System.out.println("postHandle()...");
	}

	/**
	 * 前端控制器收到请求之后，会先调用
	 * preHandle方法。
	 * 如果该方法返回值为true,表示继续向
	 * 后调用，否则请求处理结束。
	 * arg2: 处理器的方法对象。
	 */
	public boolean preHandle(
			HttpServletRequest req, 
			HttpServletResponse res, 
			Object arg2) throws Exception {
		System.out.println(
				"preHandle()...");
		return true;
	}

}




