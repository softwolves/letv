package day01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * 查看每个员工的工号，名字，职位，薪水，部门号，
 * 部门名称，以及工作所在地
 * 
 * SELECT e.empno,e.ename,e.job,e.sal,
 *        d.deptno,d.dname,d.loc
 * FROM emp e,dept d
 * WHERE e.deptno=d.deptno       
 * @author Administrator
 *
 */
public class JDBCDemo4 {
	public static void main(String[] args) {
		try {
			//1 不同的数据库字符串内容不一致
			Class.forName(
				"oracle.jdbc.driver.OracleDriver");
			
			//2 url不同数据库格式不同
			Connection conn = DriverManager.getConnection(
				"jdbc:oracle:thin:@192.168.201.209:1521:orcl", 
				"fancq", 
				"zaq12wsx"
			);
			System.out.println("连接数据库成功!");
			
			//3
			Statement state = conn.createStatement();
			
			/*
			 * 4 Statement根据执行的SQL语句的不同
			 *   提供了相应的几个执行方法
			 *   
			 * boolean execute(String sql)
			 * 通常用来执行DDL语句，但实际上任何语句都可以
			 * 用该方法执行
			 * 
			 * int executeUpdate(String sql)
			 * 专门用来执行DML语句，返回值为执行该SQL后影响
			 * 数据库表中多少条数据
			 * 
			 * 
			 * ResultSet executeQuery(String sql)  
			 * 专门用来执行DQL语句，返回值为查询的结果集  
			 */
			
			String sql = "SELECT e.empno,e.ename,e.job,e.sal,d.deptno,d.dname,d.loc FROM emp e,dept d WHERE e.deptno=d.deptno";
			//执行查询语句
			ResultSet rs = state.executeQuery(sql);
			/*
			 * 遍历结果集
			 * ResultSet提供了方法:
			 * boolean next()
			 * 该方法会时当前结果集向下表示一条记录，若
			 * 结果集还有下一条记录，就表示它并返回true,
			 * 若结果集已经没有记录了，则返回false。
			 * 在遍历结果集时，至少先执行一次next方法，
			 * 因为结果集指针默认在第一条记录之上。
			 */
			while(rs.next()){
				/*
				 * ResultSet提供了获取指定字段值的方法
				 * String getString(String colName)
				 * int getInt(String colName)
				 * double getDouble(String colName)
				 * 还有其他类型的相关方法，具体调用哪个由字段
				 * 类型决定，字段是字符串，就调用getString
				 * 字段是整数就调用getInt...
				 * 
				 * 还有一套重载方法，
				 * 如:getString(int index)
				 * 参数表示第几个字段，从1开始。
				 * 
				 */
				//获取员工名字
				String ename = rs.getString("ename");
				//获取职位
				String job = rs.getString("job");
				//获取工资
				int sal = rs.getInt("sal");
				//获取部门号
				int deptno = rs.getInt("deptno");
				//部门名
				String dname = rs.getString("dname");
				//部门所在地
				String loc = rs.getString("loc");
				System.out.println(ename+","+job+","+sal+","+deptno+","+dname+","+loc);
			}
			
			
			
			//关闭连接释放资源
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}


