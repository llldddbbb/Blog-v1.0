package com.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.entity.Blog;
import com.entity.BlogTag;
import com.entity.BlogType;
import com.entity.Bloger;
import com.entity.Link;
import com.service.BlogService;
import com.service.BlogTagService;
import com.service.BlogTypeService;
import com.service.BlogerService;
import com.service.LinkService;
import com.util.ResponseUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/system")
public class SystemController {
	
	@Resource
	private LinkService linkService;
	@Resource
	private BlogService blogService;
	@Resource
	private BlogTypeService blogTypeService;
	@Resource
	private BlogerService blogerService;
	@Resource
	private BlogTagService blogTagService;

    @RequestMapping("/refreshSystem")
    public String refreshSystem(HttpServletRequest request,HttpServletResponse response)throws Exception{
    	ServletContext application=request.getServletContext();
    	
    	application.removeAttribute("linkList");
    	List<Link> linkList=linkService.findLinkList();
        application.setAttribute("linkList",linkList);

        application.removeAttribute("hotBlogList");
        List<Blog> hotBlogList=blogService.findHotBlogList();
        application.setAttribute("hotBlogList",hotBlogList);

        application.removeAttribute("recommendBlogList");
        List<Blog> recommendBlogList=blogService.findRecommendBlogList();
        application.setAttribute("recommendBlogList",recommendBlogList);

        application.removeAttribute("technologyBlogList");
        List<Blog> technologyBlogList=blogService.findTechnologyBlogList();
        application.setAttribute("technologyBlogList",technologyBlogList);

        application.removeAttribute("blogTypeList");
        List<BlogType> blogTypeList=blogTypeService.findBlogTypeList();
        application.setAttribute("blogTypeList",blogTypeList);

        application.removeAttribute("blogTagList");
        List<BlogTag> blogTagList=blogTagService.findBlogTagList();
        application.setAttribute("blogTagList",blogTagList);

        application.removeAttribute("bloger");
        Bloger bloger=blogerService.getBloger();
        application.setAttribute("bloger",bloger);
        
        JSONObject result=new JSONObject();
    	result.put("success", true);
    		
    	ResponseUtil.write(result, response);
    	return null;
    }


}
