package day05;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

/**
 * 遍历Map
 * 遍历Map有三种方式:
 * 遍历所有的key
 * 遍历所有的key-value对
 * 遍历所有的value(相对不常用)
 * @author Administrator
 *
 */
public class MapDemo2 {
	public static void main(String[] args) {
		Map<String,Integer> map
			= new HashMap<String,Integer>();
		map.put("语文", 99);
		map.put("数学", 98);
		map.put("英语", 97);
		map.put("物理", 96);
		map.put("化学", 99);
		System.out.println(map);
		
		/*
		 * 遍历所有的key
		 * Set<K> keySet()
		 * 该方法会将当前Map中所有的key存入一个
		 * Set集合后返回。那么遍历该集合就等于遍历
		 * 了所有的key
		 */
		Set<String> keySet = map.keySet();
		for(String key : keySet){
			System.out.println("key:"+key);
		}
		
		/*
		 * 遍历每一组键值对
		 * Map中每一组键值对都是由Map的内部类:
		 * java.util.Map.Entry的一个实例表示的。
		 * Entry有两个方法：getKey,getValue，可以
		 * 分别获取这一组键值对中的key与value。
		 * 
		 * Set<Entry> entrySet
		 * 该方法会将Map中每一组键值对(Entry实例)
		 * 存入一个Set集合后返回。
		 */
		Set<Entry<String,Integer>> entrySet 
							= map.entrySet();
		
		for(Entry<String,Integer> e:entrySet){
			String key = e.getKey();
			Integer value = e.getValue();
			System.out.println(key+":"+value);
		}
		
		/*
		 * 遍历所有的value
		 * Collection values()
		 * 该方法会将当前Map中所有的value存入一个
		 * 集合后返回。
		 */
		Collection<Integer> values = map.values();
		for(Integer value : values){
			System.out.println("value:"+value);
			
		}
		
	}
}







