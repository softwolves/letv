package dao;

import java.util.List;

import annotation.MyBatisRepository;
import entity.Emp;

/**
 * Mapper接口
 *
 */
@MyBatisRepository
public interface EmpDAO {
	public void save(Emp emp);
	public List<Emp> findAll();
	public Emp findById(int id);
	public void modify(Emp emp);
	public void delete(int id);
	
	
	
	
	
}
