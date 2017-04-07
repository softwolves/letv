package day05;
/**
 * 该类用于作为集合的元素
 * @author Administrator
 *
 */
public class Point implements Comparable<Point>{
	private int x;
	private int y;
	public Point(int x, int y) {
		super();
		this.x = x;
		this.y = y;
	}
	public int getX() {
		return x;
	}
	public void setX(int x) {
		this.x = x;
	}
	public int getY() {
		return y;
	}
	public void setY(int y) {
		this.y = y;
	}
	public String toString(){
		return "("+x+","+y+")";
	}
	/**
	 * 当实现了Comparable接口后，需要重写下面的方法
	 * 该方法的作用是定义当前对象与给定参数对象比较大小
	 * 的规则。
	 * 返回值为一个int值，该值表示大小关系。它不关注具
	 * 体的取值是多少，而关注的是取值范围。
	 * 当返回值>0时:当前对象比参数对象大
	 * 当返回值<0时:当前对象比参数对象小
	 * 当返回值=0时:两个对象相等。
	 */
	public int compareTo(Point o) {
		/*
		 * 比较规则，点到原点的距离长的大
		 */
		int len = this.x*this.x+this.y*this.y;
		int olen = o.x*o.x+o.y*o.y;
		return len-olen;
	}
	
	
}



