package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entity.Cost;
import util.DBUtil;

public class CostDao {
	
	public List<Cost> findAll() {
		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			String sql = 
				"select * from cost_lhh "
				+ "order by cost_id";
			Statement smt = 
				conn.createStatement();
			ResultSet rs = smt.executeQuery(sql);
			List<Cost> list = new ArrayList<Cost>();
			while(rs.next()) {
				Cost c = createCost(rs);
				list.add(c);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(
				"查询资费失败", e);
		} finally {
			DBUtil.closeConnection();
		}
	}

	/**
	 * Alt+Shift+M
	 */
	private Cost createCost(ResultSet rs) throws SQLException {
		Cost c = new Cost();
		c.setCostId(rs.getInt("cost_id"));
		c.setName(rs.getString("name"));
		c.setBaseDuration(rs.getInt("base_duration"));
		c.setBaseCost(rs.getDouble("base_cost"));
		c.setUnitCost(rs.getDouble("unit_cost"));
		c.setStatus(rs.getString("status"));
		c.setDescr(rs.getString("descr"));
		c.setCreatime(rs.getTimestamp("creatime"));
		c.setStartime(rs.getTimestamp("startime"));
		c.setCostType(rs.getString("cost_type"));
		return c;
	}
	
	public void save(Cost cost) {
		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			String sql = 
				"insert into cost_lhh values("
				+ "cost_seq_lhh.nextval,"
				+ "?,?,?,?,'1',?,sysdate,null,?)";
			PreparedStatement ps = 
				conn.prepareStatement(sql);
			ps.setString(1, cost.getName());
			//在当前业务下，基本时长、基本费用、单位
			//费用都可能为null，字段也允许存null。
			//但setInt/setDouble方法不允许传入null。
			//可以将这样的数据当做Object处理。
			ps.setObject(2, cost.getBaseDuration());
			ps.setObject(3, cost.getBaseCost());
			ps.setObject(4, cost.getUnitCost());
			ps.setString(5, cost.getDescr());
			ps.setString(6, cost.getCostType());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(
				"增加资费失败", e);
		} finally {
			DBUtil.closeConnection();
		}
	}
	
	public Cost findById(int id) {
		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			String sql = 
				"select * from cost_lhh "
				+ "where cost_id=?";
			PreparedStatement ps = 
				conn.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				return createCost(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(
				"查询资费失败", e);
		} finally {
			DBUtil.closeConnection();
		}
		return null;
	}
	
	public static void main(String[] args) {
		CostDao dao = new CostDao();
		Cost c = new Cost();
		c.setName("包月");
		//c.setBaseDuration(600);
		c.setBaseCost(600.0);
		//c.setUnitCost(0.6);
		c.setDescr("包月很爽");
		c.setCostType("1");
		dao.save(c);
	}

}











