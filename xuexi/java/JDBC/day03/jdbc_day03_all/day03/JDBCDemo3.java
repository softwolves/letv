package day03;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import day01.DBUtil;

/**
 * 自动返回主键
 * 在实际开发中经常有关联操作，例如，新添加一个部门，
 * 并且为该部门添加集合员工。
 * 通常主键都是自动生成的，比如使用序列，那么这就出现
 * 了一个问题，添加一个部门后，该主键由序列生成并插入
 * 到dept表中，但在向emp表中插入该部门员工时，在emp
 * 表中的deptno字段需要插入该部门的部门编号，如何获取
 * 这个部门编号是一个问题。
 * @author Administrator
 *
 */
public class JDBCDemo3 {
	public static void main(String[] args) {
		try {
			Connection conn = DBUtil.getConnection();
			/*
			 * 在插入dept信息的同时返回生成的主键
			 */
			String sql
				= "INSERT INTO dept "
				+ "(deptno,dname,loc)"
				+ "VALUES "
				+ "(seq_dept_id.NEXTVAL,?,?)";
			/*
			 * 创建PreparedStatement的同时，指定
			 * 通过该PS执行SQL后影响的记录中给定字段，
			 * 以获取该值
			 */
			PreparedStatement ps
				= conn.prepareStatement(
					sql, new String[]{"deptno"}
				);
			
			ps.setString(1, "IT");
			ps.setString(2, "BEIJING");
			int n = ps.executeUpdate();//插入数据
			if(n>0){
				//获取插入的该条记录中指定字段的值
				ResultSet rs = ps.getGeneratedKeys();
				rs.next();
				//获取了插入的部门信息的部门号的值
				int id = rs.getInt(1);
				System.out.println("该部门号:"+id);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection();
		}
		
	}
}









