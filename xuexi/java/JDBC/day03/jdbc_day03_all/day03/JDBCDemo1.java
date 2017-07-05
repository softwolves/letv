package day03;

import java.sql.Connection;
import java.sql.Statement;

import day01.DBUtil;

/**
 * 批量执行SQL语句。
 * 批操作可以一次性向数据库服务端发送若干SQL语句，
 * 从而减少与数据库服务端的网络通讯，提高执行效率。
 * @author Administrator
 *
 */
public class JDBCDemo1 {
	public static void main(String[] args) {
		try {
			Connection conn = DBUtil.getConnection();
			Statement state = conn.createStatement();
			
			//向userinfo表中插入100条记录
			for(int i=0;i<100;i++){
				String sql 
					= "INSERT INTO userinfo "
					+ "VALUES "
					+ "(seq_userinfo_id.NEXTVAL, "
					+ "'test"+i+"','123456',5000, "
					+ "'test"+i+"@tedu.cn')";
				//立刻将SQL发送至数据库服务端
//				state.executeUpdate(sql);
				//添加一个批操作，相当于先缓存在本地。
				state.addBatch(sql);		
			}
			/*
			 * 执行批操作，将之前缓存的所有SQL语句
			 * 一次性发送给数据库服务端
			 * 这样做可以有效的减少网络调用次数，提高
			 * 与数据库服务端的通讯效率。
			 */
			state.executeBatch();
			//清空本地批操作列表
			state.clearBatch();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection();
		}
	}
}







