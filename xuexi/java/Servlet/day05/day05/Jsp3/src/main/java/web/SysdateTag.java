package web;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class SysdateTag extends SimpleTagSupport {

	private String format;
	
	public String getFormat() {
		return format;
	}

	public void setFormat(String format) {
		this.format = format;
	}

	@Override
	public void doTag() throws JspException, IOException {
		//创建系统时间
		Date date = new Date();
		//格式化该时间
		SimpleDateFormat sdf = 
			new SimpleDateFormat(format);
		String now = sdf.format(date);
		//输出时间
		//该方法声明返回类型为JspContext，
		//而实现时返回的实际类型为PageContext，
		//PageContext extends JspContext
		PageContext ctx = 
			(PageContext) getJspContext();
		JspWriter out = ctx.getOut();
		out.println(now);
		//此处不能关闭流，因为其他标签也要使用
		//该流，tomcat最终会自动关闭它。
	}

	
	
}






