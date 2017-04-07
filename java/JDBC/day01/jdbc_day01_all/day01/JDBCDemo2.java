package day01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/**
 * 执行DDL语句
 * 创建表userinfo
 * 含有的字段:
 * id NUMBER(5)            id
 * username VARCHAR2(40)   用户名
 * password VARCHAR2(40)   密码
 * account NUMBER(8)       账户余额
 * email VARCHAR2(100)     电子邮箱
 * @author Administrator
 *
 */
public class JDBCDemo2 {
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
				= "CREATE TABLE userinfo(" +
				  "   id NUMBER(5), " +
				  "   username VARCHAR2(40), " +
				  "   password VARCHAR2(40), " +
				  "   account NUMBER(8), " + 
				  "   email VARCHAR2(100)"+
				  ")";
			System.out.println(sql);
			
			state.execute(sql);
			System.out.println("表创建完毕!");
			
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}






