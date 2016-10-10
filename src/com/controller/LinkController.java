package com.controller;


import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.entity.Link;
import com.service.LinkService;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Created by ldb on 2016/9/22.
 */
@Controller
@RequestMapping("/link")
public class LinkController {

    @Resource
    private LinkService linkService;
    
    @RequestMapping("/list")
    public String list(HttpServletResponse response)throws Exception{
    	List<Link> linkList=linkService.findLinkList();
    	JSONArray rows=JSONArray.fromObject(linkList);
    	JSONObject result=new JSONObject();
    	result.put("rows", rows);
    	ResponseUtil.write(result, response);
    	return null;
    }
    
    @RequestMapping("/save")
    public String save(Link link,@RequestParam(value="id",required=false)String id,HttpServletResponse response)throws Exception{
    	int resultNum=0;
    	if(StringUtil.isNotEmpty(id)){
    		resultNum=linkService.updateLink(link);
    	}else{
    		resultNum=linkService.saveLink(link);
    	}
    	JSONObject result=new JSONObject();
    	if(resultNum>0){
    		result.put("success", true);
    	}else{
    		result.put("error", "±£´æÊ§°Ü!");
    	}
    	ResponseUtil.write(result, response);
    	return null;
    }
    
    @RequestMapping("/delete")
    public String delete(String ids,HttpServletResponse response)throws Exception{
    	String[] idsArr=ids.split(",");
    	int resultNum=0;
    	for(String id:idsArr){
    		resultNum+=linkService.deleteLink(Integer.parseInt(id));
    	}
    	JSONObject result=new JSONObject();
    	if(resultNum>0){
    		result.put("success", true);
    	}else{
    		result.put("error", false);
    	}
    	ResponseUtil.write(result, response);
    	return null;
    }

}
