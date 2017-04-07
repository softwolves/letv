package day02;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

import day01.DBUtil;

/**
 * 查看结果集元数据
 * 
 * 结果集除了可以查看查询的内容外，也可以查看
 * 结果集自身的元数据，如:查到多少个字段，字段叫什么名字
 * 等信息
 * @author Administrator
 *
 */
public class JDBCDemo6 {
	public static void main(String[] args) {
		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			
			Statement state
				= conn.createStatement();
			
			String sql 
				= "SELECT * FROM userinfo";
			
			ResultSet rs 
				= state.executeQuery(sql);
			//获取结果集元数据对象
			ResultSetMetaData rsmd 
				= rs.getMetaData();
			//获取结果集查询的字段数
			int colCount 
				= rsmd.getColumnCount();
			System.out.println(
				"总共查询了:"+colCount+"个字段");
			
			//查看每个字段的名字
			for(int i=1;i<=colCount;i++){
				String colName = rsmd.getColumnName(i);
				System.out.println(colName);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection(conn);
		}
	}
}








