<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav id="nav">
	<ul>
		<li><a href="${pageContext.request.contextPath}/goIndex.do">D.B's Blog</a></li>
		<li><a href="${pageContext.request.contextPath }/blog/show.do?id=2" title="网站源码下载">网站源码下载</a></li>
		<c:forEach var="blogType" items="${blogTypeList}" begin='0' end='4'>
			<li><a href="${pageContext.request.contextPath }/blog/list.do?typeId=${blogType.id}" title="${blogType.typeName}">${blogType.typeName}</a></li>
		</c:forEach>
		<li><a href="${pageContext.request.contextPath }/blogAdvice/preAdvice.do"  title="留言建议">留言建议</a></li>
		<li><a href="${pageContext.request.contextPath }/blog/show.do?id=1"  title="关于博主">关于博主</a></li>
	</ul>
</nav>