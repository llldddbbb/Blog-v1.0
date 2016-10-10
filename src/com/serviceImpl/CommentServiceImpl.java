package com.serviceImpl;

import com.dao.CommentDao;
import com.entity.Comment;
import com.service.CommentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by ldb on 2016/9/22.
 */
@Service("commentService")
public class CommentServiceImpl implements CommentService {

    @Resource
    private CommentDao commentDao;

    @Override
    public List<Comment> findNewestCommentList(Map<String,Object> map) {
        return commentDao.findNewestCommentList(map);
    }

	@Override
	public int saveComment(Comment comment) {
		return commentDao.saveComment(comment);
	}

	@Override
	public int getCommentTotal(Map<String,Object> map) {
		return commentDao.getCommentTotal(map);
	}

	@Override
	public int deleteComment(Integer id) {
		return commentDao.deleteComment(id);
	}

	@Override
	public int updateReply(Map<String, Object> map) {
		return commentDao.updateReply(map);
	}

	@Override
	public int deleteCommentByBlogId(Integer blogId) {
		return commentDao.deleteCommentByBlogId(blogId);
	}

	@Override
	public List<Comment> findCommentListByBlogId(Map<String, Object> map) {
		return commentDao.findCommentListByBlogId(map);
	}
}
