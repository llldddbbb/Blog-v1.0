package com.serviceImpl;

import com.dao.BlogTypeDao;
import com.entity.BlogType;
import com.service.BlogTypeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by ldb on 2016/9/22.
 */
@Service("blogTypeService")
public class BlogTypeServiceImpl implements BlogTypeService {

    @Resource
    private BlogTypeDao blogTypeDao;


    @Override
    public List<BlogType> findBlogTypeList() {
        return blogTypeDao.findBlogTypeList();
    }


	@Override
	public int updateBlogType(BlogType blogType) {
		return blogTypeDao.updateBlogType(blogType);
	}


	@Override
	public List<BlogType> findBlogTypeComboList() {
		return blogTypeDao.findBlogTypeComboList();
	}
	
	
}
