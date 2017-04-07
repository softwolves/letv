package com.tedu.cloudnote.service;
import java.sql.Timestamp;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tedu.cloudnote.dao.BookDao;
import com.tedu.cloudnote.entity.Book;
import com.tedu.cloudnote.util.NoteResult;
import com.tedu.cloudnote.util.NoteUtil;

@Service("bookService")
@Transactional
public class BookServiceImpl 
implements BookService{
	@Resource
	private BookDao bookDao;
	
	public NoteResult loadUserBooks(String userId) {
		//按用户ID查询笔记本信息
		List<Book> list = 
			bookDao.findByUserId(userId);
		//创建返回结果
		NoteResult result = new NoteResult();
		result.setStatus(0);
		result.setMsg("查询完毕");
		result.setData(list);
		return result;
	}

	public NoteResult addBook(
		String userId, String name) {
		Book book = new Book();
		book.setCn_user_id(userId);//设置用户ID
		book.setCn_notebook_name(name);//设置笔记本名
		String bookId = NoteUtil.createId();
		book.setCn_notebook_id(bookId);//设置笔记本ID
		Timestamp time = new Timestamp(
			System.currentTimeMillis());
		book.setCn_notebook_createtime(time);//设置创建时间
		bookDao.save(book);//保存笔记本
		//创建返回结果
		NoteResult result = new NoteResult();
		result.setStatus(0);
		result.setMsg("创建笔记本成功");
		result.setData(book);//返回添加的笔记本信息
		return result;
	}

}
