<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="footer-mid">
        <div class="links">
            <h2>友情链接</h2>
            <ul>
                <c:forEach var="link" items="${linkList}">
                    <li><a href="${link.linkUrl}" target="_blank">${link.linkName}</a></li>
                </c:forEach>
            </ul>
        </div>
        <div class="visitors">
            <h2>最新评论</h2>
           <c:forEach var="newestComment" items="${newestCommentList}" varStatus="status">
                <dl>
                    <dt><img src="images/s${status.index+6 }.jpg">
                    <dt>
                    <dd>${newestComment.nickName}
                        <time><fmt:formatDate value="${newestComment.commentTime}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/></time>
                    </dd>
                    <dd>在 <a href="${pageContext.request.contextPath }/blog/show.do?id=${newestComment.blog.id}"
                             class="title">${newestComment.blog.title}</a>中评论：
                    </dd>
                    <dd>${newestComment.content}</dd>
                </dl>
            </c:forEach>
        </div>
    </div>
    <div class="footer-bottom">
        <p>Copyright 2016 Design by <a href="#">D.B</a></p>
    </div>