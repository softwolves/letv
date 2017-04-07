package com.tarena.oss.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.springframework.stereotype.Repository;

import com.tarena.oss.entity.Admin;

/**
 * DAO实现类。
 *
 */
@Repository("adminDAO")
public class AdminDAOJdbcImpl implements 
AdminDAO{
	
	@Resource(name="ds")
	//注入DataSource。
	private DataSource ds;
	
	public Admin findByAdminCode(
			String adminCode) {
		Admin admin = null;
		Connection conn = null;
		PreparedStatement prep = null;
		ResultSet rst = null;
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM "
					+ "admin_info "
					+ "WHERE admin_code=?";
			prep = conn.prepareStatement(sql);
			prep.setString(1, adminCode);
			rst = prep.executeQuery();
			if(rst.next()){
				admin  = new Admin();
				admin.setAdminId(rst.getInt("admin_id"));
				admin.setAdminCode(rst.getString("admin_code"));
				admin.setPassword(rst.getString("password"));
				admin.setName(rst.getString("name"));
				admin.setTelephone(rst.getString("telephone"));
				admin.setEmail(rst.getString("email"));
				admin.setEnrolldate(rst.getTimestamp("enrolldate"));
			}
		} catch (SQLException e) {
			/*
			 * step1. 记日志(保留现场)
			 */
			e.printStackTrace();
			/*
			 * step2. 看异常能否恢复，如果
			 * 不能够恢复(比如数据库服务暂停，
			 * 网络中断等，即发生了系统异常)，
			 * 则提示用户稍后重试。如果能够
			 * 恢复，则立即恢复。
			 */
			throw new RuntimeException(e);
		}finally{
			/*
			 * jdbc规范要求关闭连接时，
			 * 连接所创建的statement要自动
			 * 关闭，statement创建的resultset
			 * 也要自动关闭。
			 * 
			 * 有些连接池的实现，在关闭连接时，
			 * 并没有关闭statement。所以建议
			 * 最好依次关闭resultset,statement和
			 * 连接。
			 */
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
		return admin;
	}

}
