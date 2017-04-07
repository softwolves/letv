package day02;

import java.sql.Connection;
import java.sql.PreparedStatement;

import day01.DBUtil;

/**
 * 使用PS批量插入数据
 * @author Administrator
 *
 */
public class JDBCDemo3 {
	public static void main(String[] args) {
		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			
			//向userinfo中插入1万条数据
			/*
			 * 使用Statement
			 */
//			Statement state = conn.createStatement();
//			for(int i=0;i<10000;i++){
//				String sql 
//					= "INSERT INTO userinfo "
//					+ "VALUES "
//					+ "(seq_userinfo_id.NEXTVAL,'user"+i+"','123456',5000,'user"+i+"@tedu.com')";
//				//每次执行，数据库会生成一个执行计划!
//				state.executeUpdate(sql);
//			}
			
			/*
			 * 使用PreparedStatement
			 */
			String sql 
				= "INSERT INTO userinfo "
				+ "VALUES "
				+ "(seq_userinfo_id.NEXTVAL,?,"
				+ "'123456',5000,?)";
			//只会生成一个执行计划!
			PreparedStatement ps
				= conn.prepareStatement(sql);
			
			for(int i=0;i<100;i++){
				ps.setString(1, "user"+i);
				ps.setString(2, "user"+i+"@tedu.com");
				ps.executeUpdate();
			}
			System.out.println("插入完毕!");
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection(conn);
		}
	}
}
