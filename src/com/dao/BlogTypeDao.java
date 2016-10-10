package com.dao;

import com.entity.BlogType;

import java.util.List;

/**
 * Created by ldb on 2016/9/22.
 */
public interface BlogTypeDao {

    public List<BlogType> findBlogTypeList();

    public BlogType getBlogTypeById(Integer typeId);
    
    public int updateBlogType(BlogType blogType);
    
    public List<BlogType> findBlogTypeComboList();


}
