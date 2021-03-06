package dao;

import java.util.ArrayList;
import java.util.List;

import entity.Emp;

public class EmpDao {
	
	/**
	 * 模拟查询员工
	 */
	public List<Emp> findAll() {
		List<Emp> list = new ArrayList<Emp>();
		
		Emp e1 = new Emp();
		e1.setEmpno(1);
		e1.setEname("唐僧");
		e1.setJob("领导");
		e1.setSal(9000.0);
		list.add(e1);
		
		Emp e2 = new Emp();
		e2.setEmpno(2);
		e2.setEname("悟空");
		e2.setJob("大师兄");
		e2.setSal(5000.0);
		list.add(e2);
		
		Emp e3 = new Emp();
		e3.setEmpno(3);
		e3.setEname("八戒");
		e3.setJob("二师兄");
		e3.setSal(6000.0);
		list.add(e3);
		
		return list;
	}

	/**
	 * 模拟增加员工
	 */
	public void save(Emp e) {
		System.out.println(e.getEmpno());
		System.out.println(e.getEname());
	}
	
}







