package day02;
/**
 * 若一个类的每一个实例专门用来存储一系列
 * 数据，没没有任何业务逻辑方法，那么该类
 * 的每一个实例都是:值对象 VO ValueObject
 * 
 * 若当前类的每一个实例表示的是数据库中某张表的
 * 一条记录时，那么该类也成为:实体类
 * @author Administrator
 *
 */
public class UserInfo {
	private int id;
	private String username;
	private String password;
	private int account;
	private String email;
	
	public UserInfo(){
		
	}

	public UserInfo(int id, String username, String password, int account, String email) {
		this.id = id;
		this.username = username;
		this.password = password;
		this.account = account;
		this.email = email;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getAccount() {
		return account;
	}

	public void setAccount(int account) {
		this.account = account;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String toString(){
		return id+","+username+","+password+","+account+","+email;
	}
	
}
