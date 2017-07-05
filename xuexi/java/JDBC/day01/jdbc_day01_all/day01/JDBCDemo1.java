package day01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * JDBC，java的数据库连接
 * java提供了一套通用的连接数据库的解决方案
 * JDBC是一套标准的接口。不同的数据库提供商都提供了
 * 一套JDBC的实现类，这套实现类我们通常称为数据库的
 * 驱动包。
 * 这样的好处在于，我们的程序只需要面向JDBC的接口，
 * 然后进行统一的调用方式就可以了，无需根据不同的数据库
 * 执行不同的代码。
 * JDBC中常用接口:
 * DriverManager
 * 负责加载不同数据库的驱动，并建立与数据库的连接
 * 
 * Connection
 * 表示与数据库的连接，负责控制事务与创建Statement
 * 
 * Statement
 * 用于执行SQL语句
 * 
 * ResultSet
 * 表示查询结果集。
 * 
 * JDBC连接数据库使用过程
 * 1:加载驱动
 * 2:通过DriverManager根据驱动建立连接(Connection)
 * 3:通过Connection创建用于执行SQL的Statement
 * 4:通过Statement执行SQL语句
 * 5:若执行的是DQL语句，那么可以获得返回的查询
 *   结果集ResultSet,遍历ResultSet以达到获取
 *   查询内容的目的。
 * 6:可以重复执行4,来执行不同SQL语句
 * 7:全部操作完毕后关闭Connection释放资源。  
 * 
 * @author Administrator
 *
 */
public class JDBCDemo1 {
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
			
			String sql = "SELECT ename,job,sal,deptno FROM emp";
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
				
				System.out.println(ename+","+job+","+sal+","+deptno);
			}
			
			
			
			//关闭连接释放资源
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}






