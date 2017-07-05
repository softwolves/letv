package day02;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Scanner;

import day01.DBUtil;

/**
 * 
 * 根据ID删除用户
 * 
 * DELETE FROM userinfo
 * WHERE id=?
 * 
 * @author Administrator
 *
 */
public class JDBCDemo4 {
	public static void main(String[] args) {
		Connection conn = null;
		try {
			Scanner scanner = new Scanner(System.in);
			System.out.println("请输入要删除的用户ID");
			int id = Integer.parseInt(scanner.nextLine());
			
			conn = DBUtil.getConnection();
			
			String sql 
				= "DELETE FROM userinfo "
				+ "WHERE id=?";
			
			PreparedStatement ps
				= conn.prepareStatement(sql);
			
			ps.setInt(1, id);
			
			int i = ps.executeUpdate();
			if(i>0){
				System.out.println("删除成功!");
			}else{
				System.out.println("删除失败!");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection(conn);
		}
	}
}




