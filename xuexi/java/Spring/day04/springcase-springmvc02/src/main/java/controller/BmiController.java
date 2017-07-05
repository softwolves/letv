package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BmiController {
	@RequestMapping("/toBmi.do")
	public String toBmi(){
		return "bmi";
	}
	
	
	@RequestMapping("/bmi.do")
	public String bmi(
			HttpServletRequest request){
		System.out.println("bmi()...");
		String height = 
				request.getParameter("height");
		String weight = 
				request.getParameter("weight");
		System.out.println("height:" + height 
				+ " weight:" + weight);
		double bmi = 
				Double.parseDouble(weight) /
				Double.parseDouble(height) /
				Double.parseDouble(height);
		String status = "正常";
		if(bmi < 19){
			status = "过轻";
		}else if(bmi > 24){
			status = "过重";
		}
		request.setAttribute("status", status);
		return "view";
	}
	
	
	
	
}
