package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import entity.Admin;
import util.DBUtil;

public class AdminDao {
	
	/**
	 * Alt+Shift+J
	 * 
	 * 根据账号查询用户
	 * 
	 * @param code 账号
	 * @return 用户
	 */
	public Admin findByCode(String code) {
		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			String sql = 
				"select * from admin_info_lhh "
				+ "where admin_code=?";
			PreparedStatement ps = 
				conn.prepareStatement(sql);
			ps.setString(1, code);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				Admin a = new Admin();
				a.setAdminId(rs.getInt("admin_id"));
				a.setAdminCode(rs.getString("admin_code"));
				a.setPassword(rs.getString("password"));
				a.setName(rs.getString("name"));
				a.setEmail(rs.getString("email"));
				a.setTelephone(rs.getString("telephone"));
				a.setEnrolldate(rs.getTimestamp("enrolldate"));
				return a;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(
				"查询用户失败", e);
		} finally {
			DBUtil.closeConnection();
		}
		return null;
	}
	
	public static void main(String[] args) {
		AdminDao dao = new AdminDao();
		Admin a = dao.findByCode("caocao");
		System.out.println(
			a.getAdminId() + "," +
				a.getName());
	}

}








