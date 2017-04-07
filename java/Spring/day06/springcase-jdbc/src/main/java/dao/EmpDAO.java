package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import entity.Emp;

@Repository("empDAO")
public class EmpDAO {
	
	@Resource(name="jt")
	private JdbcTemplate jt;
	
	/**
	 * JdbcTemplate对象提供了很多实用的方法，
	 * 我们不用考虑获取连接与关闭连接，
	 * 也不用考虑异常的处理(会将异常统一转
	 * 换成运行时异常，然后抛出)。
	 */
	public void save(Emp emp){
		String sql = 
		"INSERT INTO emp "
		+ "VALUES(emp_seq.nextval,?,?)";
		Object[] params = 
				new Object[]{emp.getEname(),
						emp.getAge()};
		jt.update(sql, params);
	}
	
	public List<Emp> findAll(){
		String sql = "SELECT * FROM emp";
		return jt.query(sql, 
				new EmpRowMapper());
	}
	
	public Emp findById(int id){
		String sql = "SELECT * FROM "
				+ "emp WHERE id=?";
		Object[] params = 
				new Object[]{id};
		return jt.queryForObject(
				sql, params, 
				new EmpRowMapper());
	}
	
	public Emp findById2(int id){
		String sql = "SELECT * FROM "
				+ "emp WHERE id=?";
		Object[] params = 
				new Object[]{id};
		List<Emp> emps = 
				jt.query(sql, params,
						new EmpRowMapper());
		if(emps != null && emps.size() > 0){
			return emps.get(0);
		}
		return null;
		
	}
	
	
	/*
	 *  RowMapper类：负责将记录转换成
	 *  相应的对象(比如将emp表中的一条记录
	 *  转换成Emp对象)。
	 */
	class EmpRowMapper 
		implements RowMapper<Emp>{
		//index参数：被遍历的记录的下标
		public Emp mapRow(ResultSet rs,
				int index) throws SQLException {
			Emp e = new Emp();
			e.setId(rs.getInt("id"));
			e.setEname(rs.getString("ename"));
			e.setAge(rs.getInt("age"));
			return e;
		}
		
		
	}
	
	public void modify(Emp emp){
		String sql = 
				"UPDATE emp SET "
				+ "ename=?,age=? WHERE "
				+ "id=?";
		Object[] params = 
				new Object[]{emp.getEname(),
						emp.getAge(),
						emp.getId()};
		jt.update(sql, params);
	}
	
	public void delete(int id){
		String sql = "DELETE FROM emp "
				+ "WHERE id=?";
		Object[] params = 
				new Object[]{id};
		jt.update(sql,params);
	}
	
	//返回所有记录数
	public int getTotalRows(){
		String sql = 
		"SELECT COUNT(*) FROM emp";
		return jt.queryForObject(
				sql, Integer.class);
	}
	
	
	
	
}
