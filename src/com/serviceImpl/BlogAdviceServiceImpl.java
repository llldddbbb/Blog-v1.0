package com.serviceImpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.BlogAdviceDao;
import com.entity.BlogAdvice;
import com.service.BlogAdviceService;

@Service("blogAdviceService")
public class BlogAdviceServiceImpl implements BlogAdviceService{
	
	@Resource
	private BlogAdviceDao blogAdviceDao;
	
	@Override
	public List<BlogAdvice> findBlogAdviceList(Map<String,Object> map) {
		return blogAdviceDao.findBlogAdviceList(map);
	}

	@Override
	public int saveBlogAdvice(BlogAdvice blogAdvice) {
		return blogAdviceDao.saveBlogAdvice(blogAdvice);
	}

	@Override
	public int updateBlogAdviceReply(BlogAdvice blogAdvice) {
		return blogAdviceDao.updateBlogAdviceReply(blogAdvice);
	}

	@Override
	public int deleteBlogAdvice(Integer id) {
		return blogAdviceDao.deleteBlogAdvice(id);
	}

	@Override
	public int getBlogAdviceTotal() {
		return blogAdviceDao.getBlogAdviceTotal();
	}


}
