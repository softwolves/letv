package day03;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import day01.DBUtil;

/**
 * 要求用户输入一个部门信息:部门名，部门所在地
 * 然后再要求用户为该部门输入3个员工:名字,职位,工资
 * 每个员工插入empno,ename,job,sal,deptno字段
 * 完成后，dept表中应当有一条新记录，emp表中应当有3条新
 * 记录。要求在一个事务中进行。
 * 
 * 请输入部门名:
 * IT
 * 请输入部门所在地:
 * BEIJING
 * 
 * 请输入第1个员工信息:
 * jack,CLERK,5000
 * 请输入第2个员工信息:
 * jackson,CLERK,5000
 * 请输入第3个员工信息:
 * rose,CLERK,5000
 * 
 * 保存完毕!
 * @author Administrator
 *
 */
public class JDBCDemo4 {
	public static void main(String[] args) {
		try {
			Scanner scanner = new Scanner(System.in);
			System.out.println("请输入部门信息:");
			System.out.println("请输入部门名称:");
			String dname = scanner.nextLine();
			System.out.println("请输入部门所在地:");
			String loc = scanner.nextLine();
			
			System.out.println("请输入要输入的员工个数:");
			int sum = Integer.parseInt(scanner.nextLine());
			
			List<String> empInfos = new ArrayList<String>();
			for(int i=1;i<=sum;i++){
				System.out.println("请输入第"+i+"个员工信息:");
				String empInfo = scanner.nextLine();
				empInfos.add(empInfo);
			}		
			Connection conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			String deptSql 
				= "INSERT INTO dept "
				+ "(deptno,dname,loc) "
				+ "VALUES "
				+ "(seq_dept_id.NEXTVAL,?,?)";
			PreparedStatement deptPs
				= conn.prepareStatement(deptSql,new String[]{"deptno"});
			deptPs.setString(1, dname);
			deptPs.setString(2, loc);
			int n = deptPs.executeUpdate();
			if(n>0){
				//获取部门的ID
				ResultSet rs = deptPs.getGeneratedKeys();
				rs.next();
				int deptno = rs.getInt(1);
				/*
				 * Statement使用完毕后可以关闭释放资源。
				 * 但是需要注意，若使用Statement获取了一个
				 * 结果集，若将Statement关闭，那么该结果集
				 * 也会自动关闭!所以，应当在遍历完结果集后再
				 * 关闭Statement。PreparedStatement也一样
				 */
				deptPs.close();
				
				String empSql 
					= "INSERT INTO emp "
					+ "(empno,ename,job,sal,deptno) "
					+ "VALUES "
					+ "(seq_emp_id.NEXTVAL,?,?,?,?)";
				PreparedStatement empPs
					= conn.prepareStatement(empSql);
				for(String empInfo : empInfos){
					String[] infos = empInfo.split(",");
					empPs.setString(1, infos[0]);
					empPs.setString(2, infos[1]);
					empPs.setInt(3, Integer.parseInt(infos[2]));
					empPs.setInt(4, deptno);
					empPs.executeUpdate();
				}
				System.out.println("保存完毕!");
				conn.commit();	
			}						
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection();
		}
	}
}










