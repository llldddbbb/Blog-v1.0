package com.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.entity.BlogAdvice;
import com.entity.PageBean;
import com.service.BlogAdviceService;
import com.util.DateUtil;
import com.util.PageUtil;
import com.util.PropertiesUtil;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


/**
 * Created by ldb on 2016/9/22.
 */
@Controller
@RequestMapping("/blogAdvice")
public class BlogAdviceController {

    @Resource
    private BlogAdviceService blogAdviceService;
    
    @RequestMapping("/preAdvice")
    public String preAdvice(@RequestParam(value="page",required=false)String page,HttpServletRequest request){
    	if(StringUtil.isEmpty(page)){
    		page="1";
    	}
    	PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(PropertiesUtil.getValue("advicePageSize")));
    	Map<String,Object> map=new HashMap<>();
    	map.put("start", pageBean.getStart());
    	map.put("pageSize", pageBean.getPageSize());
    	int totalNum=blogAdviceService.getBlogAdviceTotal();
    	String pageCode=PageUtil.getPageCode("/Blog/blogAdvice/preAdvice.do?a=2", Integer.parseInt(page), totalNum, pageBean.getPageSize());
    	List<BlogAdvice> blogAdviceList=blogAdviceService.findBlogAdviceList(map);
    	request.setAttribute("blogAdviceList", blogAdviceList);
    	request.setAttribute("pageCode", pageCode);
    	return "foreground/blogAdvice/blogAdvice";
    }
    
    @RequestMapping("save")
    public String save(BlogAdvice blogAdvice,HttpServletResponse response,HttpServletRequest request)throws Exception{
    	String userIP=request.getRemoteAddr();//»ñÈ¡IP
    	int resultNum=0;
    	if(blogAdvice.getId()!=0){
    		resultNum=blogAdviceService.updateBlogAdviceReply(blogAdvice);
    	}else{
    		blogAdvice.setUserIP(userIP);
    		resultNum=blogAdviceService.saveBlogAdvice(blogAdvice);
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
    
    @RequestMapping("list")
    public String list(HttpServletResponse response)throws Exception{
    	List<BlogAdvice> blogAdviceList=blogAdviceService.findBlogAdviceList(new HashMap<String,Object>());
    	JSONArray rows=new JSONArray();
    	for(BlogAdvice blogAdvice:blogAdviceList){
    		JSONObject jsonObject=new JSONObject();
    		jsonObject.put("id", blogAdvice.getId());
    		jsonObject.put("nickName", blogAdvice.getNickName());
    		jsonObject.put("userIP", blogAdvice.getUserIP());
    		jsonObject.put("content", blogAdvice.getContent());
    		jsonObject.put("publishTime", DateUtil.formatDateToStr(blogAdvice.getPublishTime(), "yyyy-MM-dd HH:mm:ss"));
    		jsonObject.put("reply", blogAdvice.getReply());
    		rows.add(jsonObject);
    	}
    	JSONObject result=new JSONObject();
    	result.put("rows", rows);
    	ResponseUtil.write(result, response);
    	return null;
    }
    
    @RequestMapping("/delete")
    public String delete(String id,HttpServletResponse response)throws Exception{
    	int resultNum=blogAdviceService.deleteBlogAdvice(Integer.parseInt(id));
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
