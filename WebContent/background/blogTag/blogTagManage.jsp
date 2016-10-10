<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>博客标签管理页面</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">
	var url;
	function openBlogTagAddDialog(){
		url="${pageContext.request.contextPath}/blogTag/save.do";
		$("#dlg").dialog("open").dialog("setTitle","添加博客标签");
	}
	function openBlogTagModifyDialog(){
		var selectedRows=$("#dg").datagrid("getSelections");
		 if(selectedRows.length!=1){
			 $.messager.alert("系统提示","请选择一条要编辑的数据！");
			 return;
		 }
		 var row=selectedRows[0];
		 $("#dlg").dialog("open").dialog("setTitle","编辑友情链接信息");
		 $("#fm").form("load",row);
		 url="${pageContext.request.contextPath}/blogTag/save.do?id="+row.id;
	}
	function closeBlogTagDialog(){
		$("#tagName").val("");
		$("#typeId").combobox("setValue","");
		$("#dlg").dialog("close");
	}
	function saveBlogTag(){
		var tagName=$("#tagName").val();
		var typeId=$("#typeId").combobox("getValue");
		if(tagName=='' || tagName==null ){
			$.messager.alert("系统提示","标签名称不能为空");
			return;
		}
		if(typeId=='' || typeId==null ){
			$.messager.alert("系统提示","所属博客类别不能为空");
			return;
		}
		$("#fm").form("submit",{
			url:url,
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功！");
					closeBlogTagDialog();
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","保存失败！");
					return;
				}
			}
		 });
	}
	
	function deleteBlogTag(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			 $.messager.alert("系统提示","请选择要删除的数据！");
			 return;
		 }
		 var ids=[];
		 for(var i=0;i<selectedRows.length;i++){
			 ids.push(selectedRows[i].id)
		 }
		 idsStr=ids.join(",");
		 $.messager.confirm("系统提示", "您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗?", function(r){
			 if(r){
				 $.post("${pageContext.request.contextPath}/blogTag/delete.do",{ids:idsStr},function(result){
					 var result=eval("("+result+")");
					 if(result.success){
						 $.messager.alert("系统提示","您已经成功删除数据!");
						 $("#dg").datagrid("reload");
					 }else{
						 $.messager.alert("系统提示","删除失败!");
					 }
				 });
			 }
		 });
	}
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="博客标签管理" class="easyui-datagrid" fitColumns="true" rownumbers="true"
   url="${pageContext.request.contextPath}/blogTag/list.do" fit="true" toolbar="#tb">
   <thead>
   	<tr>
   		<th field="cb" checkbox="true" align="center"></th>
   		<th field="id" width="20" align="center">博客标签编号</th>
   		<th field="tagName" width="150" align="center" >博客标签名称</th>
   		<th field="typeName" width="150" align="center" >所属博客类别</th>
   		<th field="typeId" width="150" align="center" hidden="true"></th>
   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 	    <a href="javascript:openBlogTagAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
 		<a href="javascript:openBlogTagModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
 		<a href="javascript:deleteBlogTag()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 	</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
 </div>
 
 <div id="dlg" class="easyui-dialog" style="width:360px;height:180px;padding: 10px 20px"closed="true" buttons="#dlg-buttons">
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>博客标签名称：</td>
   			<td><input class="easyui-validatebox"  id="tagName" name="tagName"></input></td>
   		</tr>
   		<tr>
   			<td>所属博客类别：</td>
   			<td><input id="typeId" class="easyui-combobox" name="typeId" panelHeight="auto" data-options="valueField:'id',textField:'typeName',url:'${pageContext.request.contextPath }/blogType/findBlogTypeComboList.do'"></td>
   		</tr>
   	</table>
   </form>
 </div>
 
 <div id="dlg-buttons">
 	<a href="javascript:saveBlogTag()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeBlogTagDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
</body>
</html>