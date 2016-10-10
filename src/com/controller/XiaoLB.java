package com.controller;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.util.PostServer;
import com.util.PropertiesUtil;
import com.util.ResponseUtil;

@Controller
@RequestMapping("/XiaoLB")
public class XiaoLB {
	
	@RequestMapping("/sendMessage")
	public String sendMessage(@RequestParam(value="info",required=false)String info,HttpServletResponse response)throws Exception{
		String key=PropertiesUtil.getValue("tuLingKey");
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("key", key);
		jsonObject.put("info",info);
		String result = PostServer.SendPost(jsonObject.toString(), "http://www.tuling123.com/openapi/api");
		ResponseUtil.write(result, response);
		return null;
	}
}
