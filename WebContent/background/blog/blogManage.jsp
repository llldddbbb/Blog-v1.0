<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>博客管理页面</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">

	function deleteBlog(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			 $.messager.alert("系统提示","请选择一条要删除的数据！");
			 return;
		 }
		var row=selectedRows[0];
		 $.messager.confirm("系统提示","该博文下的评论也会删除，您确定要删除这条数据吗？",function(r){
				if(r){
					$.post("${pageContext.request.contextPath}/blog/delete.do",{id:row.id},function(result){
						if(result.success){
							 $.messager.alert("系统提示","数据已成功删除！");
							 $("#dg").datagrid("reload");
						}else{
							$.messager.alert("系统提示",result.errorMsg);
						}
					},"json");
				} 
	   });
	}
	function formatTitle(val,row){
		return "<a href='${pageContext.request.contextPath}/blog/show.do?id="+row.id+"' target='_blank'>"+val+"<a/>";
	}
	function formatIsRecommend(val,row){
		if(val==0){
			return "否";
		}else{
			return "是";
		}
	}
	function formatTagName(val,row){
		if(val==""||val==null){
			return "无所属标签";
		}else{
			return val;
		}
	}
	function formatMore(val,row){
		return "<a href='javascript:openMoreDialog("+row.id+")'>操作</a>";
	}
	
	
	function openMoreDialog(id){
		$("#id").val(id);
		$("#dlg").dialog("open").dialog("setTitle","添加更多属性"); 
	}
	
	function closeMoreDialog(){
		$("#id").val("");
		$("#dlg").dialog("close");
		
	}
	
	function saveMore(){
		$('#fm').form("submit",{
		    url:'${pageContext.request.contextPath}/blog/saveMore.do',
		    success:function(result){
		    	var result=eval("("+result+")");
		        if(result.success){
		        	$.messager.alert("系统提示","保存成功!");
		        	closeMoreDialog();
					$("#dg").datagrid("reload");
		        }else{
		        	$.messager.alert("系统提示","保存失败!");
		        }
		    }
		});
	}
	
	function searchBlog(){
		$('#dg').datagrid('load',{
 			"s_title":$('#s_title').val()
 		})
	}
	
	function updateBlog(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			 $.messager.alert("系统提示","请选择一条要修改的博文！");
			 return;
		 }
		var row=selectedRows[0];
		window.location.href="${pageContext.request.contextPath}/blog/preUpdate.do?id="+row.id;
	}
	
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="博客管理" class="easyui-datagrid"
   fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/blog/list_background.do" fit="true" toolbar="#tb" >
   <thead>
   	<tr>
   		<th field="cb" checkbox="true" align="center"></th>
   		<th field="id" width="20" align="center" >编号</th>
   		<th field="title" width="150" align="center" formatter="formatTitle">博文标题</th>
   		<th field="publishTime" width="70" align="center">发布日期</th>
   		<th field="typeName" width="80" align="center">博文类型</th>
   		<th field="tagName" width="80" align="center" formatter="formatTagName">所属标签</th>
   		<th field="isRecommend" width="40" align="center" formatter="formatIsRecommend">是否推荐博文</th>
   		<th field="more" width="20" align="center" formatter="formatMore">更多操作</th>
   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 		<a href="javascript:deleteBlog()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 		<a href="javascript:updateBlog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
 	</div> 
 	<div>
 		<input type="text" name="s_title" id="s_title"/>
 		<a href="javascript:searchBlog()" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
 	</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
 </div>
 <div id="dlg" class="easyui-dialog" style="width:380px;height:200px;padding: 10px 20px"closed="true" buttons="#dlg-buttons">
   <form id="fm" method="post" enctype="multipart/form-data">
   	<table cellspacing="8px">
   		<tr>
   			<td>上传封面：</td>
   			<td><input type="hidden" id="id" name="id"/></td>
   		</tr>
   		<tr>
   			<td><input type="file" id="coverImageName" name="coverImageName" style="width:300px"/></td>
   		</tr>
   	</table>
   </form>
 </div>
 <div id="dlg-buttons">
 	<a href="javascript:saveMore()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeMoreDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
</body>
</html>