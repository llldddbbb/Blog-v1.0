<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>博主信息管理页面</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">

	var url;

	
	function openBlogerModifyDialog(){
		var selectedRows=$("#dg").datagrid("getSelections");
		 if(selectedRows.length!=1){
			 $.messager.alert("系统提示","请选择一条要编辑的数据！");
			 return;
		 }
		 var row=selectedRows[0];
		 $("#dlg").dialog("open").dialog("setTitle","编辑博主信息");
		 $("#fm").form("load",row);
		 url="${pageContext.request.contextPath}/bloger/save.do?id="+row.id;
	 }
	
	function saveBloger(){
		 $("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功！");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","保存失败！");
					return;
				}
			}
		 });
	 }
	 
	function resetValue(){
		 $("#nickName").val("");
		 $("#job").val("");
		 $("#hobby").val("");
		 $("#email").val("");
	 }
	
	 function closeBlogerDialog(){
		 $("#dlg").dialog("close");
		 resetValue();
	 }
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="博主信息管理" class="easyui-datagrid"
   fitColumns="true" rownumbers="true"url="${pageContext.request.contextPath}/bloger/list.do" fit="true" toolbar="#tb">
   <thead>
   	<tr>
   		<th field="cb" checkbox="true" align="center"></th>
   		<th field="id" width="20" align="center">编号</th>
   		<th field="nickName" width="200" align="center">博主昵称</th>
   		<th field="job" width="200" align="center">博主职业</th>
   		<th field="hobby" width="200" align="center">兴趣爱好</th>
   		<th field="email" width="200" align="center">联系邮箱</th>
   		<th field="webClick" width="100" align="center">网站总访问次数</th>
   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 		<a href="javascript:openBlogerModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
 	</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
 </div>
 
 <div id="dlg" class="easyui-dialog" style="width:500px;height:250px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons">
   
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>博主昵称：</td>
   			<td><input type="text" id="nickName" name="nickName" class="easyui-validatebox" required="true"/></td>
   		</tr>
   		<tr>
   			<td>博主职业：</td>
   			<td><input type="text" id="job" name="job" class="easyui-validatebox"  required="true" style="width: 250px"/></td>
   		</tr>
   		<tr>
   			<td>兴趣爱好：</td>
   			<td><input type="text" id="hobby" name="hobby" class="easyui-validatebox" required="true" /></td>
   		</tr>
   		<tr>
   			<td>联系邮箱：</td>
   			<td><input type="text" id="email" name="email" class="easyui-validatebox" validtype="email" required="true" /></td>
   		</tr>
   	</table>
   </form>
 </div>
 
 <div id="dlg-buttons">
 	<a href="javascript:saveBloger()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeBlogerDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
</body>
</html>