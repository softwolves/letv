package ioc;
/**
 * 演示 spring表达式
 *
 */
public class ExampleBean {
	private String ename;
	private String city;
	private Double score;
	private String pageSize;
	
	
	public ExampleBean() {
		System.out.println(
				"ExampleBean的无参构造器...");
	}

	@Override
	public String toString() {
		return "ExampleBean [ename=" + ename + ", city=" + city + ", score=" + score + ", pageSize=" + pageSize + "]";
	}
	
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public Double getScore() {
		return score;
	}
	public void setScore(Double score) {
		this.score = score;
	}
	public String getPageSize() {
		return pageSize;
	}
	public void setPageSize(String pageSize) {
		this.pageSize = pageSize;
	}
}
