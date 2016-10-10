package com.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.entity.Bloger;
import com.service.BlogerService;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Created by ldb on 2016/9/22.
 */
@Controller
@RequestMapping("/bloger")
public class BlogerController {

    @Resource
    private BlogerService blogerService;
    
    @RequestMapping("/login")
    public String login(@RequestParam(value="userName")String userName,@RequestParam(value="password")String password,HttpServletRequest request){
    	Map<String ,Object> map=new HashMap<>();
    	if(StringUtil.isNotEmpty(userName)){
    		map.put("userName", userName);
    	}
    	if(StringUtil.isNotEmpty(password)){
    		map.put("password", password);
    	}
    	HttpSession session=request.getSession();
    	Bloger bloger=blogerService.login(map);
    	if(bloger==null){
    		request.setAttribute("userName", userName);
    		request.setAttribute("password", password);
    		request.setAttribute("error", "用户名或密码错误");
    		return "background/login";
    	}else{
    		session.setAttribute("currentBloger", bloger);
    		return "redirect:/background/main.jsp";
    	}
    }
    
    @RequestMapping("/updatePassword")
    public String updatePassword(String newPassword,String id,HttpServletResponse response)throws Exception{
    	int resultNum=0;
    	Map<String,Object> map=new HashMap<>();
    	map.put("password", newPassword);
    	map.put("id", id);
    	resultNum=blogerService.updatePassword(map);
    	JSONObject result=new JSONObject();
    	if(resultNum>0){
    		result.put("success", true);
    	}else{
    		result.put("success", false);
    	}
    	ResponseUtil.write(result, response);
    	return null;
    }
    
    @RequestMapping("logout")
    public String logout(HttpServletRequest request){
    	HttpSession session=request.getSession();
    	session.invalidate();
    	return "redirect:/background/login.jsp";
    }
    
    @RequestMapping("/list")
    public String list(HttpServletResponse response)throws Exception{
    	Bloger bloger=blogerService.getBloger();
    	JSONArray rows =JSONArray.fromObject(bloger);
    	JSONObject result=new JSONObject();
    	result.put("rows", rows);
    	ResponseUtil.write(result, response);
    	return null;
    }
    
    @RequestMapping("/save")
    public String save(Bloger bloger,HttpServletResponse response)throws Exception{
    	int resultNum=blogerService.updateBlogerInfo(bloger);
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
