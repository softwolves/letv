package day03;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import day01.DBUtil;
import day02.UserInfo;

/**
 * DATA ACCESS OBJECT
 * 数据连接对象
 * 该类是将数据库中的数据与java中的对象进行了映射
 * 使得业务逻辑对数据库的操作可以完全面向对象化。从而
 * 屏蔽了与数据库的直接操作。
 * 在项目分成中，DAO处于数据持久层
 * @author Administrator
 *
 */
public class UserInfoDAO {
	public UserInfo findById(int id){
		/*
		 * SELECT id,username,password,account,email 
		 * FROM userinfo
		 * WHERE id=?
		 */
		return null;
	}
	
	public boolean update(UserInfo userInfo){
		/*
		 * UPDATE userinfo
		 * SET username=?,password=?,account=?,email=?
		 * WHERE id=?
		 */
		return false;
	}
	
	public boolean deleteById(int id){
		/*
		 * DELETE FROM userinfo
		 * WHERE id=?
		 */
		return false;
	}
	
	/**
	 * 分页查询用户信息
	 * @param page
	 * @param pageSize
	 * @return
	 */
	public List<UserInfo> findAllByPage(int page,int pageSize){
		try {
			int start = (page-1)*pageSize+1;
			int end = pageSize*page;
			Connection conn = DBUtil.getConnection();
			String sql 
				= "SELECT * "
				+ "FROM(SELECT ROWNUM rn,t.* "
				+ "     FROM(SELECT id,username, "
				+ "                 password,account,email "
				+ "          FROM userinfo "
				+ "          ORDER BY id) t "
				+ "     WHERE ROWNUM<=?) "
				+ "WHERE rn>=?";
			PreparedStatement ps
				= conn.prepareStatement(sql);
			ps.setInt(1, end);
			ps.setInt(2, start);
			ResultSet rs = ps.executeQuery();
			List<UserInfo> list = new ArrayList<UserInfo>();
			while(rs.next()){
				int id = rs.getInt("id");
				String username = rs.getString("username");
				String password = rs.getString("password");
				int account = rs.getInt("account");
				String email = rs.getString("email");
				UserInfo userInfo = new UserInfo(id, username, password, account, email);
				list.add(userInfo);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection();
		}
		return null;
	}
	
	/**
	 * 将所有用户信息返回
	 * @return
	 */
	public List<UserInfo> findAll(){
		try {
			Connection conn = DBUtil.getConnection();
			Statement state = conn.createStatement();
			String sql 
				= "SELECT id,username,password,"
				+ "		  account,email "
				+ "FROM userinfo";
			ResultSet rs = state.executeQuery(sql);
			List<UserInfo> list = new ArrayList<UserInfo>();
			while(rs.next()){
				int id = rs.getInt("id");
				String username = rs.getString("username");
				String password = rs.getString("password");
				int account = rs.getInt("account");
				String email = rs.getString("email");
				UserInfo userInfo = new UserInfo(id, username, password, account, email);
				list.add(userInfo);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection();
		}
		return null;
	}
	
	/**
	 * 将给定的UserInfo对象所表示的用户信息保存
	 * 到数据库中
	 * @param userinfo
	 * @return
	 */
	public boolean save(UserInfo userinfo){
		try {
			Connection conn = DBUtil.getConnection();
			String sql 
				= "INSERT INTO userinfo "
				+ "(id,username,password,account,email) "
				+ "VALUES "
				+ "(seq_userinfo_id.NEXTVAL,?,?,?,?)";
			PreparedStatement ps
				= conn.prepareStatement(sql);
			
			ps.setString(1, userinfo.getUsername());
			ps.setString(2, userinfo.getPassword());
			ps.setInt(3, userinfo.getAccount());
			ps.setString(4, userinfo.getEmail());
			
			int n = ps.executeUpdate();
			if(n>0){
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection();
		}
		return false;
	}
}









