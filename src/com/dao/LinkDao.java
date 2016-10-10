package com.dao;

import com.entity.Link;

import java.util.List;

/**
 * Created by ldb on 2016/9/22.
 */
public interface LinkDao {

    public List<Link> findLinkList();
    
    public int saveLink(Link link);
    
    public int updateLink(Link link);
    
    public int deleteLink(Integer id);
}
