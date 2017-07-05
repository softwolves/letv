package day05;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 排序自定义类型元素的集合
 * @author Administrator
 *
 */
public class SortListDemo1 {
	public static void main(String[] args) {
		List<Point> list
			= new ArrayList<Point>();
		
		list.add(new Point(4,2));
		list.add(new Point(2,3));
		list.add(new Point(1,4));
		list.add(new Point(6,7));
		list.add(new Point(9,3));
		list.add(new Point(8,1));
		
		System.out.println(list);
		/*
		 * sort方法要求集合元素必须实现Comparable
		 * 接口，该接口用于规定实现类是可以比较的。
		 * 其有一个抽象方法是用来定义比较大小的规则。
		 * 
		 * 我们想使用sort方法排序集合，但是该方法要求
		 * 我们的集合元素必须实现Comparable接口并且
		 * 定义比较规则，这种我们想使用某个功能，而它
		 * 要求我们修改程序的现象称为"侵入性"。
		 * 修改的代码越多，侵入性越强，越不利于程序
		 * 的扩展。
		 */
		Collections.sort(list);
		
		System.out.println(list);
		
	}
}







