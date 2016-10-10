package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.entity.Blog;
import com.entity.Comment;
import com.entity.PageBean;
import com.service.CommentService;
import com.util.DateUtil;
import com.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Created by ldb on 2016/9/22.
 */
@Controller
@RequestMapping("/comment")
public class CommentController {

    @Resource
    private CommentService commentService;
    
    @RequestMapping("/list")
    public String list(HttpServletResponse response,String page,String rows)throws Exception{
    	int total=commentService.getCommentTotal(new HashMap<String,Object>());
    	PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
    	Map<String,Object> map=new HashMap<String,Object>();
    	map.put("start", pageBean.getStart());
    	map.put("pageSize", pageBean.getPageSize());
    	List<Comment> newestCommentList=commentService.findNewestCommentList(map);
    	JSONArray jsonArray =new JSONArray();
    	for(Comment comment:newestCommentList){
    		JSONObject jsonObject=new JSONObject();
    		Blog blog=comment.getBlog();
    		jsonObject.put("blogTitle", blog.getTitle());
    		jsonObject.put("blogId", blog.getId());
    		jsonObject.put("id", comment.getId());
    		jsonObject.put("nickName", comment.getNickName());
    		jsonObject.put("userIP", comment.getUserIP());
    		jsonObject.put("content", comment.getContent());
    		jsonObject.put("commentTime", DateUtil.formatDateToStr(comment.getCommentTime(), "yyyy-MM-dd HH:mm:ss"));
    		jsonObject.put("reply", comment.getReply());
    		jsonArray.add(jsonObject);
    	}
    	JSONObject result=new JSONObject();
    	result.put("total", total);
    	result.put("rows", jsonArray);
    	ResponseUtil.write(result, response);
    	return null;
    }
    
    @RequestMapping("/save")
    public String save(String nickName,String content,String blogId,HttpServletResponse response,HttpServletRequest request)throws Exception{
    	String userIP=request.getRemoteAddr();//»ñÈ¡IP
    	Blog blog=new Blog(Integer.parseInt(blogId));
    	Comment comment=new Comment(nickName,userIP,content,blog);
    	int resultNum=commentService.saveComment(comment);
    	JSONObject result=new JSONObject();
    	if(resultNum>0){
    		result.put("success", true);
    	}else{
    		result.put("success", false);
    	}
    	ResponseUtil.write(result, response);
    	return null;
    }
    
    @RequestMapping("/delete")
    public String delete(String ids,HttpServletResponse response)throws Exception{
    	String[] idsArr=ids.split(",");
    	int resultNum=0;
    	for(String id:idsArr){
    		resultNum+=commentService.deleteComment(Integer.parseInt(id));
    	}
    	JSONObject result=new JSONObject();
    	if(resultNum>0){
    		result.put("success", true);
    	}else{
    		result.put("success", false);
    	}
    	ResponseUtil.write(result, response);
    	return null;
    }
    
    @RequestMapping("/updateReply")
    public String updateReply(String reply,String id,HttpServletResponse response)throws Exception{
    	Map<String,Object> map=new HashMap<String,Object>();
    	map.put("reply", reply);
    	map.put("id", id);
    	int resultNum=0;
    	resultNum=commentService.updateReply(map);
    	JSONObject result=new JSONObject();
    	if(resultNum>0){
    		result.put("success", true);
    	}else{
    		result.put("success", false);
    	}
    	ResponseUtil.write(result, response);
    	return null;
    }
   

}
