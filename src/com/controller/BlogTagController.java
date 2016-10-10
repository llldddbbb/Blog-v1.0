package com.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.entity.BlogTag;
import com.entity.BlogType;
import com.service.BlogTagService;
import com.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Created by ldb on 2016/9/22.
 */
@Controller
@RequestMapping("/blogTag")
public class BlogTagController {

    @Resource
    private BlogTagService blogTagService;
    
    @RequestMapping("/list")
    public String list(HttpServletResponse response)throws Exception{
    	List<BlogTag> blogTagList=blogTagService.findBlogTagList();
    	JSONArray rows=new JSONArray();
    	for(BlogTag blogTag:blogTagList){
    		JSONObject jsonObject=new JSONObject();
    		jsonObject.put("id", blogTag.getId());
    		jsonObject.put("tagName", blogTag.getTagName());
    		jsonObject.put("typeName", blogTag.getBlogType().getTypeName());
    		jsonObject.put("typeId", blogTag.getBlogType().getId());
    		rows.add(jsonObject);
    	}
    	JSONObject result=new JSONObject();
    	result.put("rows", rows);
    	ResponseUtil.write(result, response);
    	return null;
    }
    
    @RequestMapping("/save")
    public String save(BlogTag blogTag,String typeId,HttpServletResponse response)throws Exception{
    	BlogType blogType=new BlogType();
    	blogType.setId(Integer.parseInt(typeId));
    	blogTag.setBlogType(blogType);
    	int resultNum=0;
    	if(blogTag.getId()==0){
    		resultNum=blogTagService.saveBlogTag(blogTag);
    	}else{
    		resultNum=blogTagService.updateBlogTag(blogTag);
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
    
    @RequestMapping("delete")
    public String delete(String ids,HttpServletResponse response)throws Exception{
    	String[] idsArr=ids.split(",");
    	int resultNum=0;
    	for(String id:idsArr){
    		resultNum+=blogTagService.deleteBlogTag(Integer.parseInt(id));
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
    
    @RequestMapping("/findBlogTagComboListByTypeId")
    public List<BlogTag> findBlogTagComboListByTypeId(String typeId,HttpServletResponse response)throws Exception{
    	List<BlogTag> blogTagComboList=blogTagService.findBlogTagComboListByTypeId(Integer.parseInt(typeId));
		JSONArray jsonArray=new JSONArray();
		for(BlogTag blogTag:blogTagComboList){
			JSONObject jsonObject=new JSONObject();
			jsonObject.put("id", blogTag.getId());
			jsonObject.put("tagName", blogTag.getTagName());
			jsonArray.add(jsonObject);
		}
		ResponseUtil.write(jsonArray,response);
    	return null;
    }
   


}
