package com.tedu.cloudnote.dao;

import java.util.List;
import com.tedu.cloudnote.entity.Book;

public interface BookDao {
	public void save(Book book);
	
	public List<Book> findByUserId(
			String userId);
}
