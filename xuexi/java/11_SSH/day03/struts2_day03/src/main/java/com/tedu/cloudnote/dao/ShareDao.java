package com.tedu.cloudnote.dao;

import java.util.List;
import java.util.Map;

import com.tedu.cloudnote.entity.Share;

public interface ShareDao {
	public Share findById(String shareId);
	public List<Share> findLikeTitle(
			Map<String, Object> params);
	public void save(Share share);
}
