package com.tedu.cloudnote.dao;

import java.util.List;
import java.util.Map;

import com.tedu.cloudnote.entity.Note;

public interface NoteDao {
	public int batchDelete(String[] ids);
	
	public int dynamicUpdate(Note note);
	
	public List<Note> findNotes(Map params);
	
//	public int updateTypeId(String noteId);
//	
//	public int updateBookId(Note note);
//	
//	public int updateStatus(String noteId);
	
	public void save(Note note);
	
//	public int updateNote(Note note);
	
	public Note findById(String noteId);
	
	public List<Map> findByBookId(
			String bookId);
}
