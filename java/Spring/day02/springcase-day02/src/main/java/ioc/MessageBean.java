package ioc;

import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

/**
 * 演示 引用的方式注入bean
 *
 */
public class MessageBean {
	private List<String> cities;
	private Set<String> interest;
	private Map<String,Double> scores;
	private Properties db;
	private String name;
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public MessageBean() {
		System.out.println(
				"MessageBean的无参构造器...");
	}
	
	public List<String> getCities() {
		return cities;
	}
	@Override
	public String toString() {
		return "MessageBean [cities=" + cities + ", interest=" + interest + ", scores=" + scores + ", db=" + db
				+ ", name=" + name + "]";
	}

	public void setCities(List<String> cities) {
		this.cities = cities;
	}
	public Set<String> getInterest() {
		return interest;
	}
	public void setInterest(Set<String> interest) {
		this.interest = interest;
	}
	public Map<String, Double> getScores() {
		return scores;
	}
	public void setScores(Map<String, Double> scores) {
		this.scores = scores;
	}
	public Properties getDb() {
		return db;
	}
	public void setDb(Properties db) {
		this.db = db;
	}
	
}




