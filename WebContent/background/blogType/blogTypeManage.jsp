<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>博客类别管理页面</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">
	
	function openUpdateBlogTypeDialog(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			 $.messager.alert("系统提示","请选择要修改的一条数据！");
			 return;
		 }
		var row = selectedRows[0];
		$("#fm").form("load",row);
		$("#dlg").dialog("open").dialog("setTitle","修改博客类别");
	}
	function closeBlogTypeDialog(){
		$("#typeName").val("");
		$("#id").val("");
		$("#dlg").dialog("close");
	}
	function updateBlogType(){
		var typeName=$("#typeName").val();
		if(typeName==null){
			$.message.alert("系统提示","博客类别名称不能为空");
			return;
		}
		var row = $('#dg').datagrid('getSelected');
		$("#fm").form("submit",{
			url:"${pageContext.request.contextPath}/blogType/updateBlogType.do",
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功！");
					closeBlogTypeDialog();
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
<table id="dg" title="博客类别管理" class="easyui-datagrid" fitColumns="true" rownumbers="true"
   url="${pageContext.request.contextPath}/blogType/list.do" fit="true" toolbar="#tb">
   <thead>
   	<tr>
   		<th field="cb" checkbox="true" align="center"></th>
   		<th field="id" width="20" align="center">博客类别编号</th>
   		<th field="typeName" width="150" align="center" >博客类别名称</th>
   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 		<a href="javascript:openUpdateBlogTypeDialog()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">修改</a>
 	</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
 </div>
 
 <div id="dlg" class="easyui-dialog" style="width:300px;height:170px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons">
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>博客名称：</td>
   			<td><input class="easyui-validatebox"  id="typeName" name="typeName"></input></td>
   			<td><input type="hidden" id="id" name="id"></input></td>
   		</tr>
   	</table>
   </form>
 </div>
 
 <div id="dlg-buttons">
 	<a href="javascript:updateBlogType()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeBlogTypeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
</body>
</html>