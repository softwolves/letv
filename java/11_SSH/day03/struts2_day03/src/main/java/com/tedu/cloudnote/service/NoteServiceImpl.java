package com.tedu.cloudnote.service;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.tedu.cloudnote.dao.NoteDao;
import com.tedu.cloudnote.dao.ShareDao;
import com.tedu.cloudnote.entity.Note;
import com.tedu.cloudnote.entity.Share;
import com.tedu.cloudnote.util.NoteResult;
import com.tedu.cloudnote.util.NoteUtil;

@Service("noteService")
@Transactional
public class NoteServiceImpl implements NoteService{
	@Resource
	private NoteDao noteDao;
	@Resource
	private ShareDao shareDao;
	
	public NoteResult loadBookNotes(String bookId) {
		//按笔记本ID查询笔记信息
		List<Map> list = 
			noteDao.findByBookId(bookId);
		//创建返回结果
		NoteResult result = new NoteResult();
		result.setStatus(0);
		result.setMsg("查询完毕");
		result.setData(list);
		return result;
	}
	public NoteResult loadNote(String noteId) {
		//按笔记ID查询笔记信息
		Note note = noteDao.findById(noteId);
		//创建返回结果
		NoteResult result = new NoteResult();
		result.setStatus(0);
		result.setMsg("查询完毕");
		result.setData(note);
		return result;
	}
	public NoteResult updateNote(
		String noteId, String title, String body) {
		Note note = new Note();
		note.setCn_note_id(noteId);//设置笔记ID
		note.setCn_note_title(title);//设置标题
		note.setCn_note_body(body);//设置内容
		Long time = System.currentTimeMillis();
		note.setCn_note_last_modify_time(time);//设置修改时间
//		int rows = noteDao.updateNote(note);//更新
		int rows = noteDao.dynamicUpdate(note);
		//创建返回结果
		NoteResult result = new NoteResult();
		if(rows==1){//成功
			result.setStatus(0);
			result.setMsg("保存笔记成功");
		}else{//失败
			result.setStatus(1);
			result.setMsg("保存笔记失败");
		}
		return result;
	}
	public NoteResult addNote(
	String userId, String noteTitle, String bookId) {
		//创建note参数保存
		Note note = new Note();
		note.setCn_user_id(userId);//设置用户ID
		note.setCn_note_title(noteTitle);//设置笔记名称
		note.setCn_notebook_id(bookId);//设置笔记本ID
		String noteId = NoteUtil.createId();
		note.setCn_note_id(noteId);//笔记ID
		Long time = System.currentTimeMillis();
		note.setCn_note_create_time(time);//创建时间
		note.setCn_note_last_modify_time(time);//最后修改时间
		noteDao.save(note);//保存笔记
		//创建返回结果
		NoteResult result = new NoteResult();
		result.setStatus(0);
		result.setMsg("创建笔记成功");
		result.setData(noteId);//返回笔记ID
		return result;
	}
	public NoteResult deleteNote(String noteId) {
//		int rows = 
//			noteDao.updateStatus(noteId);
		Note note = new Note();
		note.setCn_note_id(noteId);
		note.setCn_note_status_id("2");
		int rows = noteDao.dynamicUpdate(note);
		//创建返回结果
		NoteResult result = new NoteResult();
		if(rows >= 1){//成功
			result.setStatus(0);
			result.setMsg("删除笔记成功");
		}else{
			result.setStatus(1);
			result.setMsg("删除笔记失败");
		}
		return result;
	}
	public NoteResult moveNote(
		String noteId, String bookId) {
		Note note = new Note();
		note.setCn_note_id(noteId);//设置笔记ID
		note.setCn_notebook_id(bookId);//设置笔记本ID
//		int rows = 
//			noteDao.updateBookId(note);//更新
		int rows = noteDao.dynamicUpdate(note);
		//创建返回结果
		NoteResult result = new NoteResult();
		if(rows>=1){
			result.setStatus(0);
			result.setMsg("转移笔记成功");
		}else{
			result.setStatus(1);
			result.setMsg("转移笔记失败");
		}
		return result;
	}
	public NoteResult shareNote(String noteId) {
		NoteResult result = new NoteResult();
		//获取笔记信息
		Note note = noteDao.findById(noteId);
		//检查cn_note_type_id是否为分享状态,
		//如果已分享不执行下面逻辑
		if("2".equals(note.getCn_note_type_id())){
			result.setStatus(1);
			result.setMsg("该笔记已分享过");
			return result;
		}
		//更新笔记的cn_note_type_id为分享状态'2'
//		noteDao.updateTypeId(noteId);
		Note note1 = new Note();
		note1.setCn_note_id(noteId);
		note1.setCn_note_type_id("2");
		noteDao.dynamicUpdate(note1);
		//添加到分享表
		Share share = new Share();
		share.setCn_note_id(noteId);//笔记ID
		share.setCn_share_id(NoteUtil.createId());//分享ID
		share.setCn_share_title(
			note.getCn_note_title());//分享标题
		share.setCn_share_body(
			note.getCn_note_body());//分享内容
		shareDao.save(share);
		//创建返回结果
		result.setStatus(0);
		result.setMsg("分享笔记成功");
		return result;
	}
	public NoteResult searchShareNote(
			String keyword,int page) {
		//处理查询条件值
		String title = "%";
		if(keyword!=null && !"".equals(keyword)){
			title = "%"+keyword+"%";
		}
		//计算抓取起点
		if(page<1){
			page = 1;
		}
		int begin = (page-1)*5;
		//封装成Map参数
		Map<String, Object> params = 
			new HashMap<String, Object>();
		params.put("begin", begin);//对应#{begin}
		params.put("keyword", title);//对应#{keyword}
		List<Share> list = 
			shareDao.findLikeTitle(params);
		//封装NoteResult结果
		NoteResult result = new NoteResult();
		result.setStatus(0);
		result.setMsg("搜索完毕");
		result.setData(list);
		return result;
	}
	public NoteResult loadShareNote(String shareId) {
		Share share = 
			shareDao.findById(shareId);
		NoteResult result = new NoteResult();
		result.setStatus(0);
		result.setMsg("加载笔记成功");
		result.setData(share);
		return result;
	}
	public NoteResult searchNotes(
		String title, String status, 
		String beginStr, String endStr) {
		//创建查询参数
		Map<String,Object> params =
			new HashMap<String, Object>();
		//标题
		if(title!=null&&!"".equals(title)){
			//对应SQL中的#{title}
			params.put("title", "%"+title+"%");
		}
		//状态,如果不是全部选项"0"
		if(!"0".equals(status)){
			//对应SQL中的#{status}
			params.put("status", status);
		}
		//开始日期
		if(beginStr!=null&&!"".equals(beginStr)){
			Date beginDate = Date.valueOf(beginStr);
			//对应SQL中的#{begin}
			params.put("begin", beginDate.getTime());
		}
		//结束日期
		if(endStr!=null&&!"".equals(endStr)){
			Date endDate = Date.valueOf(endStr);
			//对应SQL中的#{end}
			params.put("end", endDate.getTime());
		}
		//根据参数查询笔记信息
		List<Note> list = 
			noteDao.findNotes(params);
		//创建返回结果
		NoteResult result = new NoteResult();
		result.setMsg("搜索完毕");
		result.setStatus(0);
		result.setData(list);
		return result;
	}

}



