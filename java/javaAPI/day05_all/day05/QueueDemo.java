package day05;

import java.util.LinkedList;
import java.util.Queue;

/**
 * java.util.Queue
 * 队列
 * 队列也可以存放一组元素，但是存取元素必须
 * 遵循:先进先出原则。
 * @author Administrator
 *
 */
public class QueueDemo {
	public static void main(String[] args) {
		/*
		 * LinkedList也实现了队列接口，因为它可以
		 * 保存一组元素，并且首尾增删快。正好符合队列
		 * 的特点。
		 */
		Queue<String> queue 
			= new LinkedList<String>();
		/*
		 * boolean offer(E e)
		 * 入队操作，向队尾追加一个新元素。
		 */
		queue.offer("one");
		queue.offer("two");
		queue.offer("three");
		queue.offer("four");
		queue.offer("five");
		queue.offer("six");
		System.out.println(queue);
		/*
		 * E poll()
		 * 出队操作，从队首获取元素，获取后该元素
		 * 就从队列中被删除了。
		 */
		String str = queue.poll();
		System.out.println(str);
		System.out.println(queue);
		
		/*
		 * E peek()
		 * 引用队首元素，但是不做出队操作
		 */
		//[two,three,four]
		str = queue.peek();
		System.out.println(str);//two
		System.out.println(queue);//[two,three,four]
	
		System.out.println("遍历开始");
		System.out.println("size:"+queue.size());
//		for(int i=queue.size();i>0;i--){
//			str = queue.poll();
//			System.out.println("元素:"+str);
//		}
		while(queue.size()>0){
			str = queue.poll();
			System.out.println("元素:"+str);
		}
		
		System.out.println("遍历完毕");
		System.out.println(queue);
	
	}
}




