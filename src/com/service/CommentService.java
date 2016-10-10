package com.service;

import java.util.List;
import java.util.Map;

import com.entity.Comment;

/**
 * Created by ldb on 2016/9/22.
 */
public interface CommentService {

    public List<Comment> findNewestCommentList(Map<String,Object> map);
    
    public int saveComment(Comment comment);
    
    public int getCommentTotal(Map<String,Object> map);
    
    public int deleteComment(Integer id);
    
    public int updateReply(Map<String,Object> map);
    
    public int deleteCommentByBlogId(Integer blogId);
    
    public List<Comment> findCommentListByBlogId(Map<String ,Object> map);
}
