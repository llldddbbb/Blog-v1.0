package com.dao;

import com.entity.BlogTag;

import java.util.List;

/**
 * Created by ldb on 2016/9/22.
 */
public interface BlogTagDao {

    public List<BlogTag> findBlogTagList();

    public BlogTag getBlogTagById(Integer id);
    
    public int saveBlogTag(BlogTag blogTag);
    
    public int updateBlogTag(BlogTag blogTag);
    
    public int deleteBlogTag(Integer id);
    
    public List<BlogTag> findBlogTagComboListByTypeId(Integer typeId);
}
