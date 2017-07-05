package day05;
/**
 * 当一个类的实例作为HashMap的key时，它的
 * equals方法与hashcode方法的重写直接影响着
 * 散列表(HashMap)的查询性能。
 * 在API文档中Object对这两个方法的重写做了说明:
 * 当我们重写一个类的equals方法时，就应当连同重写
 * hashcode方法。
 * 这两个方法重写应当遵循:
 * 1:一致性，当两个对象equals比较为true时，hashcode
 *   方法返回的数字必须相等。反过来虽然不是必须的，但
 *   也应当遵循，否则在HashMap中会形成链表影响查询性能。
 *   所以两个对象hashcode值相同，equals比较也应当为true
 * 2:稳定性:hashcode方法多次调用后返回的数字应当相同，不应
 *   是一个变化的值，除非参与equals比较的属性值发生了改变。  
 * @author Administrator
 *
 */
public class Key {
	private int x;
	private int y;
	public Key(int x, int y) {
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
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + x;
		result = prime * result + y;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Key other = (Key) obj;
		if (x != other.x)
			return false;
		if (y != other.y)
			return false;
		return true;
	}
	
	
}







