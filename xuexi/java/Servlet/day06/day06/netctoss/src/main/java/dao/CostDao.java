package dao;

import java.sql.Connection;
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
				"²éÑ¯×Ê·ÑÊ§°Ü", e);
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
	
	public static void main(String[] args) {
		CostDao dao = new CostDao();
		List<Cost> list = dao.findAll();
		for(Cost c : list) {
			System.out.println(
				c.getCostId() + "," +
					c.getName()+ "," +
						c.getDescr());
		}
	}

}











