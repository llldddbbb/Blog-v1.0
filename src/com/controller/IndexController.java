package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.entity.Blog;
import com.entity.Comment;
import com.entity.PageBean;
import com.service.BlogService;
import com.service.BlogerService;
import com.service.CommentService;
import com.util.PageUtil;
import com.util.PropertiesUtil;
import com.util.StringUtil;

/**
 * Created by ldb on 2016/9/22.
 */

@Controller
public class IndexController {

    @Resource
    private BlogService blogService;

    @Resource
    private CommentService commentService;
    
    @Resource
    private BlogerService blogerService;

    @RequestMapping("/goIndex")
    public String goIndex(@RequestParam(value="page",required=false)String page,HttpServletRequest request){
    	if(StringUtil.isEmpty(page)){
    		page="1";
    	}
    	PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(PropertiesUtil.getValue("pageSize")));
    	Map<String,Object> map=new HashMap<>();
    	map.put("start", pageBean.getStart());
    	map.put("pageSize", pageBean.getPageSize());
    	int totalNum=blogService.getBlogTotal(new HashMap<String,Object>());
    	String pageCode=PageUtil.getPageCode("goIndex.do?a=2", Integer.parseInt(page), totalNum, pageBean.getPageSize());
        List<Blog> blogList=blogService.findBlogList(map);
        for(Blog blog:blogList){
        	Map<String,Object> m=new HashMap<>();
        	m.put("blogId", blog.getId());
        	blog.setContent(StringUtil.Html2Text(blog.getContent()));
        	blog.setCommentList(commentService.findCommentListByBlogId(m));
        }
        Map<String,Object> newestCommentMap=new HashMap<String,Object>();
        newestCommentMap.put("start", 0);
        newestCommentMap.put("pageSize",Integer.parseInt(PropertiesUtil.getValue("newestCommentPageSize")));
        List<Comment> newestCommentList=commentService.findNewestCommentList(newestCommentMap);
        List<Blog> dateCountList=blogService.findDateCountList();
        List<Blog> hotBlogList=blogService.findHotBlogList();
        List<Blog> technologyBlogList=blogService.findTechnologyBlogList();
        HttpSession session=request.getSession();
        session.setAttribute("hotBlogList",hotBlogList);
        session.setAttribute("technologyBlogList",technologyBlogList);
        session.setAttribute("blogList",blogList);
        session.setAttribute("newestCommentList",newestCommentList);
        session.setAttribute("dateCountList",dateCountList);
        session.setAttribute("blogListTemp", "foreground/blog/blogList.jsp");
        session.setAttribute("pageCode", pageCode);
        
        blogerService.updateWebClick();
        
        return "redirect:/index.jsp";
    }
    
   
}
