package day02;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import day01.DBUtil;

/**
 * Statement通常用来执行静态SQL语句。
 * 静态SQL:SQL内容不含有任何动态信息。
 * 
 * Statement执行非静态SQL有两个问题:
 * 1:若SQL语句是动态拼接的，那么会造成SQL注入攻击
 * 2:若仅是数值变化，而SQL语义并没有变化时，批量执行
 *   多条SQL语句对数据库性能开销大。
 *   
 *   
 * PreparedStatement
 * 专门用来执行含有动态内容的SQL语句。
 * 解决了Statement执行动态SQL的两个不足。
 * 
 * PS执行的是预编译SQL，将动态信息以"?"的形式占位。
 * 数据库在接收预编译SQL后，会生成执行计划。我们接下来
 * 的工作就是传入动态信息即可，多次执行也无非就是多次
 * 传入动态信息。但是可以重用同一个执行计划了。
 * 就好像JAVA程序中定义方法，动态信息被定义为参数，
 * 多次调用方法传入不同参数即可，但是方法不用每次都
 * 重新定义。
 *   
 *   
 * @author Administrator
 *
 */
public class JDBCDemo2 {
	public static void main(String[] args) {
		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			
			String sql 
				= "SELECT id,username,password,account,email "
				+ "FROM userinfo "
				+ "WHERE username=? AND password=? ";
			/*
			 *	在创建PS的同时需要将预编译SQL语句传入，并
			 *  通过Connection专递给数据库了，这时候数据库
			 *  会将执行计划生成，但是并不会执行该计划，因为
			 *  语义虽然确定了，但是还缺少具体的数据。 
			 */
			PreparedStatement ps
				= conn.prepareStatement(sql);
			
			ps.setString(1,"jack");
			ps.setString(2, "1' OR '1'='1");
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				int account = rs.getInt("account");
				System.out.println("欢迎您!您的余额为:"+account);
			}else{
				System.out.println("用户名或密码错误!");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection(conn);
		}
	}
}







