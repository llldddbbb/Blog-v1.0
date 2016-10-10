<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:forEach var="blog" items="${blogList}">
    <li>
        <div class="arrow_box">
            <div class="ti"></div>
            <!--三角形-->
            <div class="ci"></div>
            <!--圆形-->
            <h2 class="title"><a href="${pageContext.request.contextPath }/blog/show.do?id=${blog.id}" >${blog.title}</a></h2>
            <ul class="textinfo">
                <a href="${pageContext.request.contextPath }/blog/show.do?id=${blog.id}"><img src="Blog/coverImages/${blog.coverImageName }"></a>
                <p>
                     ${fn:substring(blog.content,0,170)}...</p>
            </ul>
            <ul class="details">
                <li class="likes"><a href="#">阅读(${blog.readNum})</a></li>
                <li class="comments"><a href="#">评论(${blog.commentList.size()})</a></li>
                <li class="icon-time"><a href="#">发表时间(<fmt:formatDate value="${blog.publishTime}" type="Date" pattern="yyyy-MM-dd"></fmt:formatDate>)</a></li>
            </ul>
        </div>
        <!--arrow_box end-->
    </li>
</c:forEach>