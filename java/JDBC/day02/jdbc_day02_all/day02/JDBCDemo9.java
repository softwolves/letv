package day02;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Scanner;

import day01.DBUtil;

/**
 * 转账操作
 * 输入两个用户名，然后输出一个转账金额，操作为:
 * 第一个用户给第二个用户转账指定的金额。
 * 
 * jack
 * rose
 * 5000
 * 
 * 95000
 * 105000
 * 
 * UPDATE userinfo
 * SET account=account+?       转入
 * WHERE username=?
 * 
 * UPDATE userinfo
 * SET account=account-?       转出
 * WHERE username=?
 * 
 * @author Administrator
 *
 */
public class JDBCDemo9 {
	public static void main(String[] args) {
		try {
			Scanner scanner = new Scanner(System.in);
			System.out.println("请输入转出账号:");
			String outUser = scanner.nextLine();
			
			System.out.println("请输入转入账号:");
			String inUser = scanner.nextLine();
			
			System.out.println("请输入转账金额:");
			int account = Integer.parseInt(
							scanner.nextLine());
			/*
			 * JDBC中获取Connection时，默认是自动提交事务的，
			 * 也就是说只要执行一条SQL都会提交一次事务。
			 * 
			 */
			Connection conn = DBUtil.getConnection();
			/*
			 * 取消自动提交事务。
			 */
			conn.setAutoCommit(false);
			//转出操作
			String sqlOut 
				= "UPDATE userinfo "
				+ "SET account = account-? "
				+ "WHERE username=?";
			PreparedStatement psOut
				= conn.prepareStatement(sqlOut);
			psOut.setInt(1, account);
			psOut.setString(2, outUser);
			int n = psOut.executeUpdate();
			if(n>0){
				System.out.println("转出操作完毕");
			}else{
				System.out.println("转出操作失败");
				System.out.println("转账失败!");
				return;
			}
			//转入操作
			String sqlIn
				= "UPDATE userinfo "
				+ "SET account=account+? "
				+ "WHERE username=?";
			PreparedStatement psIn
				= conn.prepareStatement(sqlIn);
			psIn.setInt(1, account);
			psIn.setString(2, inUser);
			n = psIn.executeUpdate();
			if(n>0){
				System.out.println("转入操作完毕");
				System.out.println("转账完毕!");
				//提交事务
				conn.commit();
			}else{
				System.out.println("转入操作失败");
				System.out.println("转账失败");
				//回滚事务
				conn.rollback();
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection();
		}
	}
}








