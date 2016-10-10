package com.service;

import com.entity.BlogType;

import java.util.List;

/**
 * Created by ldb on 2016/9/22.
 */
public interface BlogTypeService {

    public List<BlogType> findBlogTypeList();
    
    public int updateBlogType(BlogType blogType);
    
    public List<BlogType> findBlogTypeComboList();
}
