package day01;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * 测试DBUtile管理连接
 * @author Administrator
 *
 */
public class JDBCDemo8 {
	public static void main(String[] args) {
		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			Statement state = conn.createStatement();
			String sql = "SELECT ename,job,sal,deptno FROM emp";
			ResultSet rs = state.executeQuery(sql);
			while(rs.next()){
				String ename = rs.getString("ename");
				String job = rs.getString("job");
				int sal = rs.getInt("sal");
				int deptno = rs.getInt("deptno");				
				System.out.println(ename+","+job+","+sal+","+deptno);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection(conn);
		}
	}
}







