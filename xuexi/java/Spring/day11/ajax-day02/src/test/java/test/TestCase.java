package test;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import bean.Stock;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class TestCase {
	@Test
	//将java对象转换成json字符串
	public void test1(){
		Stock s = new Stock();
		s.setCode("600015");
		s.setName("山东高速");
		s.setPrice(10);
		JSONObject jo = 
				JSONObject.fromObject(s);
		String json = jo.toString();
		System.out.println(json);
	}
	
	@Test
	public void test2(){
		List<Stock> stocks = 
				new ArrayList<Stock>();
		for(int i = 0; i < 3; i ++){
			Stock s = new Stock();
			s.setCode("60001" + (i + 1));
			s.setName("山东高速" + i);
			s.setPrice(10 + i);
			stocks.add(s);
		}
		//fromObject可以接收数组或者List。
		JSONArray jsa = 
				JSONArray.fromObject(stocks);
		String json = jsa.toString();
		System.out.println(json);
	}
}





