package day01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Scanner;

/**
 * 要求用户输入用户名，密码，以及邮箱
 * 然后实现注册功能(将该用户信息插入到userinfo表
 * 中，id使用序列生成)
 * @author Administrator
 *
 */
public class JDBCDemo6 {
	public static void main(String[] args) {
		try {
			Scanner scanner = new Scanner(System.in);
			System.out.println("欢迎注册!");
			System.out.println("请输入用户名:");
			String username = scanner.nextLine();
			
			System.out.println("请输入密码:");
			String password = scanner.nextLine();
			
			System.out.println("请输入邮箱地址:");
			String email = scanner.nextLine();
			
			
			
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
				  "(seq_userinfo_id.NEXTVAL,'"+username+"','"+password+"',5000,'"+email+"')";
			System.out.println(sql);
			
			int i = state.executeUpdate(sql);
			if(i>0){
				System.out.println("注册成功!");
			}else{
				System.out.println("注册失败!");
			}
			
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}





