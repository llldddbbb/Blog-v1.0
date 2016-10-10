<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>评论管理页面</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">

	function deleteComment(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			 $.messager.alert("系统提示","请选择要删除的数据！");
			 return;
		 }
		 var strIds=[];
		 for(var i=0;i<selectedRows.length;i++){
			 strIds.push(selectedRows[i].id);
		 }
		 var ids=strIds.join(",");
		 $.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
				if(r){
					$.post("${pageContext.request.contextPath}/comment/delete.do",{ids:ids},function(result){
						if(result.success){
							 $.messager.alert("系统提示","数据已成功删除！");
							 $("#dg").datagrid("reload");
						}else{
							$.messager.alert("系统提示","数据删除失败！");
						}
					},"json");
				} 
	   });
	}
	
	function formatReply(val,row){
		if(val==null){
			return "<a href='javascript:openReplyDialog()'>未回复</a>";
		}else{
			return "<a href='javascript:showReply()'>查看详情</a>";
		}
	}
	function formatTitle(val,row){
		return "<a href='${pageContext.request.contextPath}/blog/show.do?id="+row.blogId+"' target='_blank'>"+val+"<a/>";
	}
	function formatContent(val,row){
		if(val.length>20){
			return val.substring(0,20)+"...";
		}else{
			return val;
		}
	}
	function openReplyDialog(){
		var row = $('#dg').datagrid('getSelected');
		$("#commentContent").val(row.content);
		$("#dlg").dialog("open").dialog("setTitle","回复评论");
	}
	function showReply(){
		var row = $('#dg').datagrid('getSelected');
		$("#commentContent_show").val(row.content);
		$("#blogTitle_show").val(row.blogTitle);
		$("#reply_show").val(row.reply);
		$("#nickName_show").val(row.nickName);
		$("#show").dialog("open").dialog("setTitle","查看详情");
	}
	function closeReplyDialog(){
		$("#reply").val("");
		$("#dlg").dialog("close");
	}
	function saveReply(){
		var reply=$("#reply").val();
		if(reply==null){
			$.message.alert("系统提示","回复内容不能为空");
			return;
		}
		if(reply.length>20){
			$.message.alert("系统提示","回复内容长度不能大于20");
			return;
		}
		var row = $('#dg').datagrid('getSelected');
		$("#fm").form("submit",{
			url:"${pageContext.request.contextPath}/comment/updateReply.do?id="+row.id,
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功！");
					closeReplyDialog();
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","保存失败！");
					return;
				}
			}
		 });
	}
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="评论管理" class="easyui-datagrid"
   fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/comment/list.do" fit="true" toolbar="#tb">
   <thead>
   	<tr>
   		<th field="cb" checkbox="true" align="center"></th>
   		<th field="id" width="20" align="center" hidden="true"></th>
   		<th field="blogId" width="20" align="center" hidden="true"></th>
   		<th field="blogTitle" width="150" align="center" formatter="formatTitle">博客标题</th>
   		<th field="userIP" width="80" align="center">用户IP</th>
   		<th field="nickName" width="80" align="center">用户昵称</th>
   		<th field="content" width="200" align="center" formatter="formatContent">评论内容</th>
   		<th field="commentTime" width="70" align="center">评论日期</th>
   		<th field="reply" width="80" align="center" formatter="formatReply">回复状态</th>
   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 		<a href="javascript:deleteComment()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 	</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
 </div>
 
 <div id="dlg" class="easyui-dialog" style="width:500px;height:400px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons">
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>评论内容：</td>
   			<td><textarea class="easyui-validatebox" rows="5" cols="35" id="commentContent" readonly="readonly"></textarea></td>
   		</tr>
   		<tr>
   			<td>回复内容：</td>
   			<td><textarea class="easyui-validatebox" rows="5" cols="35" id="reply" name="reply"></textarea></td>
   		</tr>
   	</table>
   </form>
 </div>
 
 <div id="dlg-buttons">
 	<a href="javascript:saveReply()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeReplyDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
 
 <div id="show" class="easyui-dialog" style="width:500px;height:420px;padding: 10px 20px" closed="true" >
   	<table cellspacing="8px">
   		<tr>
   			<td>博客标题：</td>
   			<td><input  id="blogTitle_show" readonly="readonly" style="width:300px;"></input></td>
   		</tr>
   		<tr>
   			<td>用户昵称：</td>
   			<td><input  id="nickName_show" readonly="readonly" style="width:300px;"></input></td>
   		</tr>
   		<tr>
   			<td>评论内容：</td>
   			<td><textarea rows="5" cols="35" id="commentContent_show" readonly="readonly"></textarea></td>
   		</tr>
   		<tr>
   			<td>回复内容：</td>
   			<td><textarea rows="5" cols="35" id="reply_show"  readonly="readonly"></textarea></td>
   		</tr>
   	</table>
 </div>
</body>
</html>