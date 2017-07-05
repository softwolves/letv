package day01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

/**
 * 查看员工信息
 * empno,ename,sal,job,deptno
 * 
 * 要求用户可以输入页数和每页查看的条目数
 * 然后查看内容
 * 如:查看第二页，每页显示5条。查看的内容按照工资降序
 * @author Administrator
 *
 */
public class JDBCDemo7 {
	public static void main(String[] args) {
		try {
			Scanner scanner = new Scanner(System.in);
			System.out.println("请输入每页显示的条目数:");
			int pageSize = Integer.parseInt(scanner.nextLine());
			
			System.out.println("请输入页数:");
			int page = Integer.parseInt(scanner.nextLine());
			
			int start = (page-1)*pageSize+1;
			int end = pageSize*page;
			
			
			
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
			 * SELECT *
			 * FROM(SELECT ROWNUM rn,t.*
			 *      FROM(SELECT empno,ename,sal,job,deptno
			 *           FROM emp
			 *           ORDER BY sal DESC) t
			 *      WHERE ROWNUM<=10)
			 * WHERE rn>=6
			 */
			String sql 
				= "SELECT * "+
			      "FROM(SELECT ROWNUM rn,t.* "+
				  "     FROM(SELECT empno,ename,sal,job,deptno "+
			      "          FROM emp "+
				  "          ORDER BY sal DESC) t "+
			      "     WHERE ROWNUM<="+end+") "+
				  "WHERE rn>="+start;
			System.out.println(sql);
			ResultSet rs = state.executeQuery(sql);
			while(rs.next()){
				int rn = rs.getInt("rn");
				int empno = rs.getInt("empno");
				String ename = rs.getString("ename");
				int sal = rs.getInt("sal");
				String job = rs.getString("job");
				int deptno = rs.getInt("deptno");
				System.out.println(rn+","+empno+","+ename+","+sal+","+job+","+deptno);
			}
			
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}	
			
			
			
	}
}
