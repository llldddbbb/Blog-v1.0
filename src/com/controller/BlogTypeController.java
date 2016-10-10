package com.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.entity.BlogType;
import com.service.BlogTypeService;
import com.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Created by ldb on 2016/9/22.
 */
@Controller
@RequestMapping("/blogType")
public class BlogTypeController {

    @Resource
    private BlogTypeService blogTypeService;
    
    @RequestMapping("/list")
    public String list(HttpServletResponse response)throws Exception{
    	List<BlogType> blogTypeList=blogTypeService.findBlogTypeList();
    	JSONArray rows=JSONArray.fromObject(blogTypeList);
    	JSONObject result=new JSONObject();
    	result.put("rows", rows);
    	ResponseUtil.write(result, response);
    	return null;
    }
    
    @RequestMapping("/findBlogTypeComboList")
    public String findBlogTypeComboList(HttpServletResponse response)throws Exception{
    	List<BlogType> blogTypeList=blogTypeService.findBlogTypeList();
    	JSONArray result=JSONArray.fromObject(blogTypeList);
    	ResponseUtil.write(result, response);
    	return null;
    }


}
