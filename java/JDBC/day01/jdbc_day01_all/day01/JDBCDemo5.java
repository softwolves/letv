package day01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/**
 * 执行DML操作
 * @author Administrator
 *
 */
public class JDBCDemo5 {
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
			
			String sql 
				= "INSERT INTO userinfo " + 
				  "(id,username,password,account,email) "+ 
				  "VALUES "+
				  "(seq_userinfo_id.NEXTVAL,'jack','123456',5000,'jack@tedu.cn')";
			System.out.println(sql);
			/*
			 * 默认情况下，JDBC自动提交事务，所以每次执行
			 * DML后事务就提交了。
			 */
			int i = state.executeUpdate(sql);
			if(i>0){
				System.out.println("插入成功!");
			}else{
				System.out.println("插入失败!");
			}
			
			
			
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}




