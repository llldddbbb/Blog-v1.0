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
<script src="${pageContext.request.contextPath}/js/modernizr.js"></script>
<script type="text/javascript">
 function commentSubmit(){
	 var nickName=$("#nickName").val();
	 var content=$("#content").val();
	 if(nickName==null||nickName==''){
		 alert("请输入昵称");
		 return;
	 }
	 if(content==null||content==''){
		 alert("请输入评论内容!");
		 return;
	 }
	 if(nickName.length>15){
		 alert("昵称长度不能大于15!");
		 return;
	 }
	 if(content.length>200){
		 alert("评论内容长度不能大于200!");
		 return;
	 }
	 $.post("${pageContext.request.contextPath}/comment/save.do?blogId=${blog.id}",{nickName:nickName,content:content},function(result){
		 var result=eval("("+result+")");
		 if(result.success){
			 alert("评论成功!");
			 window.location.href="${pageContext.request.contextPath}/blog/show.do?id=${blog.id}";
		 }else{
			 alert("评论失败!")
		 }
	 });
 }
</script>
</head>
<body>
	<header> <jsp:include page="../common/header.jsp"></jsp:include> </header>
	<!--header end-->
	<div id="mainbody">
		<div class="blogs">
			<div id="index_view">
				<h2 class="t_nav">
					<a href="${pageContext.request.contextPath }/goIndex.do">网站首页</a><a href="${pageContext.request.contextPath }/blog/list.do?typeId=${blog.blogType.id }">${blog.blogType.typeName }</a>
				</h2>
				<h1 class="c_titile">${blog.title }</h1>
				<p class="box">
					发布时间：<fmt:formatDate value="${blog.publishTime }" type="date" pattern="yyyy-MM-dd"/><span>编辑：${blog.author }</span>阅读（${blog.readNum }）
				</p>
				<ul>
					${blog.content}
				</ul>
				<div class="share">
					<!-- Baidu Button BEGIN -->
					<div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare">
						<span class="bds_more">分享到：</span> <a class="bds_qzone"></a> <a class="bds_tsina"></a> <a class="bds_tqq"></a> <a
							class="bds_renren"></a> <a class="bds_t163"></a> <a class="shareCount"></a>
					</div>
					<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=6574585"></script>
					<script type="text/javascript" id="bdshell_js"></script>
					<script type="text/javascript">
						document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
					</script>
					<!-- Baidu Button END -->
				</div>
				<div class="otherlink">
					<h2>网友评论</h2>
					<ul>
						<c:choose>
							 <c:when test="${empty commentList}">
							 	<div align="center">还没有人评论哦，快抢沙发吧~</div>
							 </c:when>
							 <c:otherwise>
							 	<c:forEach var="comment" items="${commentList }" end="5">
									<li><span style="line-height: 48px; margin-left: -28px;">昵称:${comment.nickName }:</span>
									<h2 style="line-height: 20px; border-bottom: none;">评论内容:&nbsp;${comment.content }</h2>
										<span style="line-height: 48px; margin-left: 350px; color: #333;"><font color=#9bbe10>博主回复:</font>${comment.reply==null?'稍后会回复哦~':comment.reply}</span></li>
								</c:forEach>
							 </c:otherwise>
						</c:choose>
					</ul>
				</div>
				<c:if test="${pageCode!=null }">
					<div class="page">${pageCode }</div>
				</c:if>
				<div class="otherlink">
					<h2>发表评论</h2>
					<div class="ds-replybox">
						<a class="ds-avatar" href="javascript:void(0);" onclick="return false"><img
							src="../../images/comment_default.png"></a> <input type="search" name="nickName" id="nickName"
							style="margin-bottom: 6px; font-size: 12px; padding: 2px; padding-left: 10px; color: #408080"
							placeholder="请输入您的昵称" />
						<div class="ds-textarea-wrapper ds-rounded-top">
							<textarea name="message" id="content" title="Ctrl+Enter快捷提交" placeholder="说点什么吧…"></textarea>
						</div>
						<div class="ds-post-toolbar">
							<div class="ds-post-options ds-gradient-bg">
								<span class="ds-sync"></span>
							</div>
							<button class="ds-post-button" onclick="javascript:commentSubmit()">发布</button>
						</div>
					</div>
				</div>
			</div>
			<!--bloglist end-->
			<aside> <jsp:include page="../common/leftSide.jsp"></jsp:include> </aside>
		</div>
		<!--blogs end-->
	</div>
	<!--mainbody end-->
	
	<!-- jQuery仿腾讯回顶部和建议 代码开始 -->
	<div id="tbox">
		<a id="togbook" href="${pageContext.request.contextPath }/blogAdvice/preAdvice.do"></a> <a id="gotop" href="javascript:void(0)"></a>
	</div>
	<!-- 代码结束 -->
</body>
</html>