package dao;

import java.util.List;

import entity.Emp;

/**
 *
 */
public interface EmpDAO {
	public void save(Emp emp);
	public List<Emp> findAll();
	public Emp findById(int id);
	public void modify(Emp emp);
	public void delete(int id);
	
	
	
	
	
}
