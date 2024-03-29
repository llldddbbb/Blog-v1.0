package com.service;

import java.util.List;
import java.util.Map;

import com.entity.BlogAdvice;

/**
 * Created by ldb on 2016/9/22.
 */
public interface BlogAdviceService {

	public List<BlogAdvice> findBlogAdviceList(Map<String,Object> map);
	
	public int saveBlogAdvice(BlogAdvice blogAdvice);
	
	public int updateBlogAdviceReply(BlogAdvice blogAdvice);
	
	public int deleteBlogAdvice(Integer id);
	
	public int getBlogAdviceTotal();
}
