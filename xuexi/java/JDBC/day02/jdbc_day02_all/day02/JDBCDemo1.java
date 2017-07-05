package day02;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

import day01.DBUtil;

/**
 * 登录功能
 * @author Administrator
 *
 */
public class JDBCDemo1 {
	public static void main(String[] args) {
		Connection conn = null;
		try {
			Scanner scanner = new Scanner(System.in);
			System.out.println("欢迎登录");
			System.out.println("请输入用户名:");
			String username = scanner.nextLine();
			
			System.out.println("请输入密码:");
			String password = scanner.nextLine();
			
			
			conn = DBUtil.getConnection();
			Statement state = conn.createStatement();
			
			System.out.println(password);
			/*
			 *  1' OR '1'='1
			 */
			String sql 
			 = "SELECT id,username,password,account,email "
			 + "FROM userinfo "
			 + "WHERE username='"+username+"' "
			 + "AND password='"+password+"'";
			
			System.out.println(sql);
			ResultSet rs = state.executeQuery(sql);
			
			if(rs.next()){
				int account = rs.getInt("account");
				System.out.println("欢迎您!"+username+",您的账户余额为:"+account);
			}else{
				System.out.println("用户名或密码不正确!");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection(conn);
		}
	}
}






