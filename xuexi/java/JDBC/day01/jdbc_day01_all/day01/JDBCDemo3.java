package day01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/**
 * 创建一个序列 seq_userinfo_id
 * 序列从1开始，步长为1
 * 
 * CREATE SEQUENCE seq_userinfo_id
 * START WITH 1
 * INCREMENT BY 1
 * @author Administrator
 *
 */
public class JDBCDemo3 {
	public static void main(String[] args) {
		try {
			//1 不同的数据库字符串内容不一致
			Class.forName(
				"oracle.jdbc.driver.OracleDriver");
			
			//2 url不同数据库格式不同
			Connection conn = DriverManager.getConnection(
				"jdbc:oracle:thin:@192.168.201.209:1521:orcl", 
				"fancq", 
				"zaq12wsx"
			);
			System.out.println("连接数据库成功!");
			
			//3
			Statement state = conn.createStatement();
			
			//4
			String sql 
				= "CREATE SEQUENCE seq_userinfo_id " +
				  "   START WITH 1 " +
				  "   INCREMENT BY 1 ";
			System.out.println(sql);
			
			state.execute(sql);
			System.out.println("序列创建完毕!");
			
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
