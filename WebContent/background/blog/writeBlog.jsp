<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>写博客页面</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath }/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath }/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath }/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">
	
	function submitData(){
		var title=$("#title").val();
		var blogTypeId=$("#blogTypeId").val();
		var blogTagId=$("#blogTagId").val();
		var isRecommend=$("input[name='isRecommend']:checked").val();
		var recommendOrder=$("#recommendOrder").val();
		var author=$("#author").val();
		var id=$("#id").val();
		var content=UE.getEditor('editor').getContent();
		if(blogTagId==null){
			blogTagId="-1";
		}
		if(id==''){
			id=-1;
		}
		if(title==null || title==''){
			alert("请输入标题！");
		}else if(blogTypeId==null || blogTypeId==''){
			alert("请选择博客类别！");
		}else if(content==null || content==''){
			alert("请输入内容！");
		}else if(recommendOrder==null||recommendOrder==''){
			alert("请输入推荐顺序！");
		}else{
			$.post("${pageContext.request.contextPath}/blog/save.do",{'title':title,'blogType.id':blogTypeId,'blogTag.id':blogTagId,'content':content,'isRecommend':isRecommend,'recommendOrder':recommendOrder,'author':author,'id_background':id},function(result){
				if(result.success){
					alert("博客发布成功！");
					resetValue();
				}else{
					alert("博客发布失败！");
				}
			},"json");
		}
	}
	
	function resetValue(){
		$("#title").val("");
		$("#blogTypeId").val("");
		$("#blogTagId").val("");
		$("#recommendOrder").val("");
		UE.getEditor('editor').setContent("");
	}
	
	function loadBlogTagComboList(){
		var blogTypeId=$('#blogTypeId').val();
		$("#blogTagId option[value!='-1']").remove();
		if(blogTypeId=="-1"){
			$('#blogTagId').val("-1");
		}
		$.post("${pageContext.request.contextPath }/blogTag/findBlogTagComboListByTypeId.do",{typeId:blogTypeId},function(result){
			var result=eval("("+result+")");
			$('#blogTagId').val("-1");
			$.each(result,function(i,item){
				$("<option value='"+item.id+"'>"+item.tagName+"</option>").appendTo($("#blogTagId"));
			});
		});
	}
	function showRecommendOrder(){
		$("#recommendOrder").val("");
		$("#recommendOrderSpan").show();
	}
	function hideRecommendOrder(){
		$("#recommendOrder").val(10); 
		//$("#recommendOrderSpan").hide();
	}
	
	//页面加载完成后执行
	$(function(){
		var blogTypeId=$("#blogTypeId").val();
		if(blogTypeId!=''){
			loadBlogTagComboList();
		}
		if($("#recommendYes").attr("checked")){
			//$("#recommendOrderSpan").show();
		}else{
			$("#recommendOrder").val(10);
			$("#recommendNo").attr("checked","checked");
		}
	}); 
</script>
</head>
<body style="margin: 10px">
<div id="p" class="easyui-panel" title="编写博客" style="padding: 10px">
 	<table cellspacing="15px">
   		<tr>
   			<td width="80px">博客标题：</td>
   			<td><input type="text" id="title" name="title" style="width: 400px;" value="${blog_background.title }"/></td>
   			<td><input type="hidden" id="id" name="id" value="${blog_background.id }"/></td>
   		</tr>
   		<tr>
   			<td>所属类别：</td>
   			<td>
   				<select style="width: 154px" id="blogTypeId" name="blogType.id" editable="false" " panelHeight="auto" onChange="loadBlogTagComboList()" >
					<option value="">请选择博客类别...</option>	
				    <c:forEach var="blogType" items="${blogTypeList }">
				    	<option value="${blogType.id }" ${blog_background.blogType.id==blogType.id?'selected':'' }>${blogType.typeName }</option>
				    </c:forEach>			
                </select>
   			</td>
   		</tr>
   		<tr>
   			<td>所属标签：</td>
   			<td>
   				<select  style="width: 154px" id="blogTagId" name="blogTag.id" editable="false" panelHeight="auto" >
					<option value="">请选择博客标签...</option>	
                </select>
   			</td>
   		</tr>
   		<tr>
   			<td>是否推荐博文:</td>
   			<td>
   				<input type="radio"  name="isRecommend" id="recommendYes" value="1" onclick="showRecommendOrder()" ${blog_background.isRecommend==1?'checked':''}>是
				<input type="radio" name="isRecommend"  id="recommendNo" value="0" onclick="hideRecommendOrder()">否
				<span id="recommendOrderSpan"  >&nbsp;&nbsp;推荐顺序:&nbsp;<input type="text" id="recommendOrder" name="recommendOrder"  value="${blog_background.recommendOrder}" />(根据排序序号从小到大排序)</span>
   			</td>
   		</tr>
   		<tr>
   			<td><input type="hidden" name="author" id="author" value="${currentBloger.nickName }"></td>
   		</tr>
   		<tr>
   			<td valign="top">博客内容：</td>
   			<td>
				   <script id="editor" type="text/plain" style="width:100%;height:400px;">${blog_background.content}</script>
   			</td>
   		</tr>
   		<tr>
   			<td></td>
   			<td>
   				<a href="javascript:submitData()" class="easyui-linkbutton" data-options="iconCls:'icon-submit'">发布博客</a>
   			</td>
   		</tr>
   	</table>
 </div>
 
 <script type="text/javascript">
    var ue = UE.getEditor('editor');
</script>
</body>
</html>