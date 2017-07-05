package day03;

import java.sql.Connection;
import java.sql.PreparedStatement;

import day01.DBUtil;

/**
 * 当大批量执行SQL语句时，影响效率的三个因素:
 * 1:事务，事务越多速度越慢
 * 2:网络调用，网络调用越多速度越慢
 * 3:Statement，PreparedStatement的选用，
 *   因为执行计划越多效率越慢
 * @author Administrator
 *
 */
public class JDBCDemo2 {
	public static void main(String[] args) {
		try {
			Connection conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			String sql 
				= "INSERT INTO userinfo "
				+ "VALUES "
				+ "(seq_userinfo_id.NEXTVAL, "
				+ "?,'123456',5000,?)";
			PreparedStatement ps
				= conn.prepareStatement(sql);
			for(int i=0;i<100;i++){
				ps.setString(1, "test"+i);
				ps.setString(2, "test"+i+"@tedu.cn");
				ps.addBatch();
			}
			ps.executeBatch();
			ps.clearBatch();
			conn.commit();
			System.out.println("执行完毕!");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection();
		}
	}
}








