package day05;

import java.util.HashMap;
import java.util.Map;

/**
 * java.util.Map
 * Map看起来像是一个多行两列的表格。
 * 以key-value对的形式存放元素。
 * 在Map中key不允许重复(重复是依靠key的equals判断)
 * 常用的实现类为:HashMap
 * @author Administrator
 *
 */
public class MapDemo1 {
	public static void main(String[] args) {
		Map<String,Integer> map 
			= new HashMap<String,Integer>();
		
		/*
		 * V put(K k,V v)
		 * 将给定的key-value对存入Map
		 * 由于Map要求key不允许重复，所以使用Map
		 * 已有的key存入一个新的value时的操作是
		 * 替换value,那么返回值为该key原来对应的
		 * value。若是一个新的key,则返回值为null。
		 * 
		 */
		Integer value = map.put("语文", 99);
		System.out.println("old:"+value);
		map.put("数学", 98);
		map.put("英语", 97);
		map.put("物理", 96);
		map.put("化学", 99);
		System.out.println(map);
		
		value = map.put("语文", 98);
		System.out.println(map);
		System.out.println("old:"+value);
		
		
		/*
		 * V get(K k)
		 * 根据给定的key获取对应的value，若当前
		 * Map中没有给定的key，则返回值为null
		 */
		value = map.get("数学");
		System.out.println("数学:"+value);
		value = map.get("体育");
		System.out.println("体育:"+value);
		
		/*
		 * V remove(K k)
		 * 删除给定的key所对应的key-value对。
		 * 返回值为被删除的key-value对中的value。
		 */
		System.out.println("删除数学");
		value = map.remove("数学");
		System.out.println(map);
		System.out.println("old:"+value);
		
	}
}







