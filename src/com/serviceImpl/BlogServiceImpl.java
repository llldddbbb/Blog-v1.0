package com.serviceImpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.BlogDao;
import com.entity.Blog;
import com.service.BlogService;

/**
 * Created by ldb on 2016/9/22.
 */
@Service("blogService")
public class BlogServiceImpl implements BlogService {

    @Resource
    private BlogDao blogDao;


    @Override
    public List<Blog> findRecommendBlogList() {
        return blogDao.findRecommendBlogList();
    }

    @Override
    public List<Blog> findHotBlogList() {
        return blogDao.findHotBlogList();
    }

    @Override
    public List<Blog> findTechnologyBlogList() {
        return blogDao.findTechnologyBlogList();
    }

    @Override
    public List<Blog> findBlogList(Map<String,Object> map) {
        return blogDao.findBlogList(map);
    }

	@Override
	public List<Blog> findDateCountList() {
		return blogDao.findDateCountList();
	}

	@Override
	public Blog getBlogById(Integer id) {
		return blogDao.getBlogById(id);
	}

	@Override
	public int updateBlogReadNum(Integer id) {
		return blogDao.updateBlogReadNum(id);
	}

	@Override
	public int getBlogTotal(Map<String,Object> map) {
		return blogDao.getBlogTotal(map);
	}

	@Override
	public int saveBlog(Blog blog) {
		return blogDao.saveBlog(blog);
	}

	@Override
	public int deleteBlog(Integer id) {
		return blogDao.deleteBlog(id);
	}

	@Override
	public int saveMore(Map<String, Object> map) {
		return blogDao.saveMore(map);
	}

	@Override
	public int updateBlog(Blog blog) {
		return blogDao.updateBlog(blog);
	}

}
