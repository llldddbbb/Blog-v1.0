<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8">
<title>D.B的个人博客</title>
<meta name="keywords" content="黑色模板,个人网站模板,个人博客模板,博客模板,css3,html5,网站模板" />
<meta name="description" content="这是一个有关黑色时间轴的css3 html5 网站模板" />
<link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/view.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/lrtk.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/embed.default.css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/js.js"></script>
<script src="${pageContext.request.contextPath}/js/silder.js"></script>
<script src="${pageContext.request.contextPath}/js/modernizr.js"></script>
<script type="text/javascript">
 function blogAdviceSubmit(){
	 var nickName=$("#nickName").val();
	 var content=$("#content").val();
	 if(nickName==null||nickName==''){
		 alert("请输入昵称");
		 return;
	 }
	 if(content==null||content==''){
		 alert("请输入建议内容!");
		 return;
	 }
	 if(nickName.length>15){
		 alert("昵称长度不能大于15!");
		 return;
	 }
	 $.post("${pageContext.request.contextPath}/blogAdvice/save.do?",{nickName:nickName,content:content},function(result){
		 var result=eval("("+result+")");
		 if(result.success){
			 alert("提交成功，感谢您的建议!");
			 window.location.href="${pageContext.request.contextPath}/blogAdvice/preAdvice.do";
		 }else{
			 alert("提交失败!")
		 }
	 });
 }
</script>
</head>
<body>
	<header> <jsp:include page="../common/header.jsp"></jsp:include> </header>
	<div id="mainbody">
		<div class="blogs">
			<div class="otherlink" >
				<h2 style="margin-bottom: 15px"><font color="white">网友建议</font></h2>
				<ul>
					<c:forEach var="blogAdvice" items="${blogAdviceList}">
						<li><span style="line-height: 48px;margin-left: 0px;">昵称:${blogAdvice.nickName }:</span><h2 style="line-height: 20px ;border-bottom:none;" >建议内容:&nbsp;${blogAdvice.content }</h2><span style="line-height: 48px;margin-left: 600px; color:#333;" ><font color=white>博主回复:</font><font color="#9bbe10" style="padding-right: 100px">${blogAdvice.reply==null?'稍后会回复哦~':blogAdvice.reply}</font></span></li>
					</c:forEach>
				</ul>
			</div>
			
			<div class="page">${pageCode }</div>
			
			<div class="otherlink" style="margin-top: 25px">
				<h2><font color="white" >发表建议</font></h2>
				<div class="ds-replybox">
					<a class="ds-avatar" href="javascript:void(0);" onclick="return false"><img src="${pageContext.request.contextPath }/images/comment_default.png"></a>
						<input  type="search" name="nickName" id="nickName" style="margin-bottom: 6px;font-size: 12px;padding: 2px;padding-left: 10px;color: #408080" placeholder="请输入您的昵称" />
						<div class="ds-textarea-wrapper ds-rounded-top">
							<textarea name="message" id="content" title="Ctrl+Enter快捷提交" placeholder="说点什么吧…"></textarea>
						</div>
						<div class="ds-post-toolbar">
							<div class="ds-post-options ds-gradient-bg">
								<span class="ds-sync"></span>
							</div>
							<button class="ds-post-button" onclick="javascript:blogAdviceSubmit()">提交建议</button>
						</div>
				</div>
			</div>
	</div>
</div>
	
	<!-- jQuery仿腾讯回顶部和建议 代码开始 -->
	<div id="tbox">
		<a id="togbook" href="${pageContext.request.contextPath }/blogAdvice/preAdvice.do"></a> <a id="gotop" href="javascript:void(0)"></a>
	</div>
	<!-- 代码结束 -->
</body>
</html>