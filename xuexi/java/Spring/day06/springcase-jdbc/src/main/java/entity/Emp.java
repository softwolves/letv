package entity;

public class Emp {
	private Integer id;
	private String ename;
	private Integer age;
	public Integer getId() {
		return id;
	}
	@Override
	public String toString() {
		return "Emp [id=" + id + ", ename=" + ename + ", age=" + age + "]";
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
