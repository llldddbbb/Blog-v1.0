package com.dao;

import com.entity.Comment;

import java.util.List;
import java.util.Map;

/**
 * Created by ldb on 2016/9/23.
 */
public interface CommentDao {

    public List<Comment> findNewestCommentList(Map<String,Object> map);

    public List<Comment> findCommentListByBlogId(Map<String ,Object> map);
    
    public int saveComment(Comment comment);
    
    public int getCommentTotal(Map<String,Object> map);
    
    public int deleteComment(Integer id);
    
    public int updateReply(Map<String,Object> map);
    
    public int deleteCommentByBlogId(Integer typeId);
}
