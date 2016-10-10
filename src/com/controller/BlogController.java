package com.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.entity.Blog;
import com.entity.BlogType;
import com.entity.Comment;
import com.entity.PageBean;
import com.service.BlogService;
import com.service.BlogTagService;
import com.service.BlogTypeService;
import com.service.CommentService;
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
@RequestMapping("/blog")
public class BlogController {

    @Resource
    private BlogService blogService;
    
    @Resource
    private BlogTypeService blogTypeService;
    
    @Resource
    private CommentService commentService;
    
    @Resource
    private BlogTagService blogTagService;

    @RequestMapping("/list")
    public String list(@RequestParam(required=false,value="typeId")String typeId,@RequestParam(required=false,value="tagId")String tagId,@RequestParam(required=false,value="publishTime")String publishTime,@RequestParam(value="page",required=false)String page, HttpServletRequest request) throws Exception{
    	if(StringUtil.isEmpty(page)){
    		page="1";
    	}
    	String pageCode=null;
    	int totalNum=0;
    	PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(PropertiesUtil.getValue("pageSize")));
    	Map<String,Object> map=new HashMap<>();
    	map.put("start", pageBean.getStart());
    	map.put("pageSize", pageBean.getPageSize());
    	
    	if(StringUtil.isNotEmpty(typeId)){
    		map.put("typeId", typeId);
    		totalNum=blogService.getBlogTotal(map);
    		pageCode=PageUtil.getPageCode("blog/list.do?typeId="+typeId, Integer.parseInt(page), totalNum, pageBean.getPageSize());
    	}
    	if(StringUtil.isNotEmpty(tagId)){
    		map.put("tagId", tagId);
    		totalNum=blogService.getBlogTotal(map);
    		pageCode=PageUtil.getPageCode("blog/list.do?tagId="+tagId, Integer.parseInt(page), totalNum, pageBean.getPageSize());
    	}
    	if(StringUtil.isNotEmpty(publishTime)){
    		String publishTimeStr=DateUtil.formatStrToSQL(publishTime, "yyyyÄêMMÔÂ","yyyy-MM");
    		map.put("publishTime", publishTimeStr);
    		totalNum=blogService.getBlogTotal(map);
    		pageCode=PageUtil.getPageCode("blog/list.do?publishTime="+publishTime, Integer.parseInt(page), totalNum, pageBean.getPageSize());
    	}
    	List<Blog> blogList=blogService.findBlogList(map);
    	for(Blog b:blogList){
    		Map<String,Object> m=new HashMap<>();
        	m.put("blogId", b.getId());
        	b.setContent(StringUtil.Html2Text(b.getContent()));
        	b.setCommentList(commentService.findCommentListByBlogId(m));
    	}
    	HttpSession session=request.getSession();
    	session.setAttribute("blogList", blogList);
    	session.removeAttribute("pageCode");
    	session.setAttribute("pageCode", pageCode);
    	session.setAttribute("blogListTemp", "foreground/blog/blogList.jsp");
		return "redirect:/index.jsp";
    }
    
    @RequestMapping("/show")
    public String show(@RequestParam(value="page",required=false)String page,@RequestParam(value="id")String id,HttpServletRequest request){
    	HttpSession session=request.getSession();
    	Map<String ,Object> map=new HashMap<>();
    	map.put("blogId", id);
    	if(StringUtil.isEmpty(page)){
    		page="1";
    	}
    	PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(PropertiesUtil.getValue("pageSize")));
    	map.put("start", pageBean.getStart());
    	map.put("pageSize", pageBean.getPageSize());
    	int totalNum=commentService.getCommentTotal(map);
    	String pageCode=PageUtil.getPageCode("/Blog/blog/show.do?id="+id, Integer.parseInt(page), totalNum, pageBean.getPageSize());
    	List<Comment> commentList=commentService.findCommentListByBlogId(map);
    	Blog blog=blogService.getBlogById(Integer.parseInt(id));
    	blogService.updateBlogReadNum(Integer.parseInt(id));
    	session.setAttribute("blog", blog);
    	session.setAttribute("commentList", commentList);
    	session.removeAttribute("pageCode");
    	session.setAttribute("pageCode", pageCode);
    	return "redirect:/foreground/blog/blogShow.jsp";
    }
    
    @RequestMapping("/list_background")
    public String list_background(String page,String rows,@RequestParam(value="s_title",required=false)String s_title,HttpServletResponse response)throws Exception{
    	PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
    	Map<String ,Object> map=new HashMap<>();
    	map.put("start", pageBean.getStart());
    	map.put("pageSize", pageBean.getPageSize());
    	if(StringUtil.isNotEmpty(s_title)){
    		map.put("title", StringUtil.formatSQLlike(s_title));
    	}
    	int total=blogService.getBlogTotal(map);
    	List<Blog> blogList=blogService.findBlogList(map);
    	JSONArray jsonArray=new JSONArray();
    	for(Blog blog:blogList){
    		JSONObject jsonObject=new JSONObject();
    		jsonObject.put("id", blog.getId());
    		jsonObject.put("title", blog.getTitle());
    		jsonObject.put("publishTime",DateUtil.formatDateToStr(blog.getPublishTime(), "yyyy-MM-dd HH:mm:ss") );
    		jsonObject.put("typeName", blog.getBlogType().getTypeName());
    		if(blog.getBlogTag()!=null){
    			jsonObject.put("tagName", blog.getBlogTag().getTagName());
    		}else{
    			jsonObject.put("tagName", "");
    		}
    		jsonObject.put("isRecommend", blog.getIsRecommend());
    		jsonArray.add(jsonObject);
    	}
    	JSONObject result=new JSONObject();
    	result.put("total", total);
    	result.put("rows", jsonArray);
    	ResponseUtil.write(result, response);
    	return null;
    }
    
    @RequestMapping("/preSave")
    public String preSave(HttpServletRequest request,HttpServletResponse response)throws Exception{
    	List<BlogType> blogTypeList=blogTypeService.findBlogTypeList();
    	request.setAttribute("blogTypeList", blogTypeList);
    	return "background/blog/writeBlog";
    }
    
    @RequestMapping("/save")
    public String save(@RequestParam(value="id_background",required=false)String id_background,Blog blog,HttpServletResponse response)throws Exception{
    	int resultNum=0;
    	if("-1".equals(id_background)){
    		blog.setCoverImageName("s1.jpg");
    		resultNum=blogService.saveBlog(blog);
    	}else{
    		blog.setId(Integer.parseInt(id_background));
    		resultNum=blogService.updateBlog(blog);
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
    
    
    @RequestMapping("/delete")
    public String delete(String id,HttpServletResponse response)throws Exception{
    	int deleteNum=commentService.deleteCommentByBlogId(Integer.parseInt(id));
    	int resultNum=blogService.deleteBlog(Integer.parseInt(id));
    	JSONObject result=new JSONObject();
    	if(resultNum>0||deleteNum>0){
    		result.put("success", true);
    	}else{
    		result.put("success", false);
    	}
    	ResponseUtil.write(result, response);
    	return null;
    }
    
    @RequestMapping("saveMore")
    public String saveMore(HttpServletRequest request,HttpServletResponse response)throws Exception{
    	FileItemFactory factory=new DiskFileItemFactory();
		ServletFileUpload upload=new ServletFileUpload(factory);
		Map<String,Object> map=new HashMap<>();
		List<FileItem> items=null;
		items=upload.parseRequest(request);
		Iterator<FileItem> iterator=items.iterator();
		String fileName=request.getSession().getServletContext().getRealPath("/");
		while(iterator.hasNext()){
			FileItem item=iterator.next();
			if(!item.isFormField()){
				String imageName=DateUtil.getCurrentDateStr();
				map.put("coverImageName",imageName+"."+item.getName().split("\\.")[1]);
				String filePath=fileName+"\\Blog\\coverImages\\"+imageName+"."+item.getName().split("\\.")[1];
				item.write(new File(filePath));
			}else{
				String fieldName=item.getFieldName();
				if("id".equals(fieldName)){
					map.put("id", item.getString("utf-8"));
				}
			}
		}
		int resultNum=0;
		resultNum=blogService.saveMore(map);
		JSONObject result=new JSONObject();
		if(resultNum>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(result, response);
    	return null;
    }
    
    @RequestMapping("/preUpdate")
    public String preUpdate(String id,HttpServletRequest request)throws Exception{
    	Blog blog=blogService.getBlogById(Integer.parseInt(id));
    	request.setAttribute("blog_background", blog);
    	return "background/blog/writeBlog";
    }
}
