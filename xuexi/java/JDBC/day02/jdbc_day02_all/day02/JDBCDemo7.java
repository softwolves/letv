package day02;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import day01.DBUtil;

/**
 * 遍历查询结果集
 * ResultSet
 * 
 * 通常对结果集的遍历是一次性的。若希望重复使用结果集
 * 中的数据，都是先将遍历结果集得到的结果以java对象
 * 的形式全部保存起来，然后重复使用。
 * JDBC提供了一种叫做可滚动结果集。意思是该结果集可以
 * 来回查看每一条记录。但是基本不用。
 * @author Administrator
 *
 */
public class JDBCDemo7 {	
	public static void main(String[] args) {
		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			Statement state = conn.createStatement();
			String sql 
				= "SELECT id,username,password,account,email "
				+ "FROM userinfo";
			
			ResultSet rs = state.executeQuery(sql);
			
			List<UserInfo> list = new ArrayList<UserInfo>();
			
			while(rs.next()){
				int id = rs.getInt("id");
				String username = rs.getString("username");
				String password = rs.getString("password");
				int account = rs.getInt("account");
				String email = rs.getString("email");
				UserInfo userInfo = new UserInfo(id,username,password,account,email);
				list.add(userInfo);
			}
			
			for(UserInfo u : list){
				System.out.println(u);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection(conn);
		}
	}
}








	


