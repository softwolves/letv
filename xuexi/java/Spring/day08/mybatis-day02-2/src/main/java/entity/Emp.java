package entity;
/**
 * 实体类的属性名必须与表的字段名一致
 * (名称相同，大小写无所谓)。
 *
 */
public class Emp {
	private Integer id;
	private String ename;
	private Integer age;
	
	@Override
	public String toString() {
		return "Emp [id=" + id + ", ename=" + ename + ", age=" + age + "]";
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	
}
