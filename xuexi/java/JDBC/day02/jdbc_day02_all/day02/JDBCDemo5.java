package day02;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Scanner;

import day01.DBUtil;

/**
 * 要求用户输入id，和余额值，修改该id对应用户的余额信息。
 * @author Administrator
 *
 */
public class JDBCDemo5 {
	public static void main(String[] args) {
		Connection conn = null;
		try {
			Scanner scanner = new Scanner(System.in);
			System.out.println("请输入id:");
			int id = Integer.parseInt(scanner.nextLine());
			System.out.println("请输入金额:");
			int account = Integer.parseInt(scanner.nextLine());
			
			conn = DBUtil.getConnection();
			String sql 
				= "UPDATE userinfo "
				+ "SET account=? "
				+ "WHERE id=?";
			PreparedStatement ps 
				= conn.prepareStatement(sql);
			
			ps.setInt(2, id);
			ps.setInt(1, account);
			int i = ps.executeUpdate();
			if(i>0){
				System.out.println("修改成功!");
			}else{
				System.out.println("修改失败!");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection(conn);
		}
	}
}
