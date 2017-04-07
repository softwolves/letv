package day01;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * 使用当前类来管理数据库连接
 * @author Administrator
 *
 */
public class DBUtil {
	private static String driver;
	private static String url;
	private static String username;
	private static String password;
	
	static{
		try {
			//加载配置文件
			Properties prop = new Properties();
			prop.load(new FileInputStream(
						"config.properties")
				     );
			driver = prop.getProperty("dirver");
			url = prop.getProperty("url");
			username = prop.getProperty("username");
			password = prop.getProperty("password");
			System.out.println(driver);
			System.out.println(url);
			System.out.println(username);
			System.out.println(password);
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取一个数据库连接
	 * @return
	 * @throws ClassNotFoundException 
	 * @throws SQLException 
	 */
	public static Connection getConnection() throws ClassNotFoundException, SQLException{
		//1加载驱动
		Class.forName(driver);
		
		//2获取连接
		Connection conn 
			= DriverManager.getConnection(
				url,username,password
			);
		
		return conn;
	}
	/**
	 * 关闭数据库连接
	 * @param conn
	 */
	public static void closeConnection(Connection conn){
		if(conn != null){
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		Connection conn = DBUtil.getConnection();
		System.out.println("获取成功!");
	}
}






