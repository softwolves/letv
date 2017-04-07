package day02;

import java.sql.Connection;
import java.sql.SQLException;

import day01.DBUtil;

public class JDBCDemo8 {
	public static void main(String[] args) throws Exception{
		Thread t1 = Thread.currentThread();
		try {
			Connection conn = DBUtil.getConnection();
		} catch (Exception e) {
			
		} finally{
			DBUtil.closeConnection();
		}
		
		
		
		
		
	}
}






