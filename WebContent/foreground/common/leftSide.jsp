<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
     <div class="tuijian">
         <h2>推荐文章</h2>
         <ol>
             <c:forEach var="recommendBlog" items="${recommendBlogList}" end="10" varStatus="status">
                 <li><span><strong>${status.index+1}</strong></span><a href="${pageContext.request.contextPath }/blog/show.do?id=${recommendBlog.id}">${recommendBlog.title}</a></li>
             </c:forEach>
         </ol>
     </div>
     <div class="clicks">
         <h2>热门点击</h2>
         <ol>
             <c:forEach var="hotBlog" items="${hotBlogList}" end="10" varStatus="status">
                 <li><span><a href="${pageContext.request.contextPath }/blog/list.do?typeId=${hotBlog.blogType.id}">${hotBlog.blogType.typeName}</a></span><a href="${pageContext.request.contextPath }/blog/show.do?id=${hotBlog.id}"><font color=gray>${hotBlog.title}</font></a></li>
             </c:forEach>
         </ol>
     </div>
     <div class="sunnav">
         <h2>博客标签</h2>
         <ul>
             <c:forEach var="blogTag" items="${blogTagList}" >
                 <li><a href="${pageContext.request.contextPath }/blog/list.do?tagId=${blogTag.id}"  title="${blogTag.tagName}">${blogTag.tagName}</a></li>
             </c:forEach>
         </ul>
     </div>
     
     <div class="search">
     	<h2>日期归档</h2>
 		<ul class="date">
 			<c:forEach var="dateCount" items="${dateCountList }">
  			<li><a href="${pageContext.request.contextPath }/blog/list.do?publishTime=${dateCount.publishTimeStr }">${dateCount.publishTimeStr }(${dateCount.blogCount })</a></li>
 			</c:forEach>
 		</ul>
	</div>
     
     <div class="clicks">
         <h2>技术探讨</h2>
         <ol>
             <c:forEach var="technologyBlog" items="${technologyBlogList}" end="10" varStatus="status">
                 <li><span><a href="${pageContext.request.contextPath }/blog/list.do?tagId=${technologyBlog.blogTag.id}">${technologyBlog.blogTag.tagName}</a></span><a href="${pageContext.request.contextPath }/blog/show.do?id=${technologyBlog.id}">${technologyBlog.title}</a></li>
             </c:forEach>
         </ol>
     </div>

     <div class="viny">
         <dl>
             <dt class="art"><img src="${pageContext.request.contextPath }/images/artwork.png" alt="专辑"></dt>
             <dd class="icon-song"><span></span>千古</dd>
             <dd class="icon-artist"><span></span>歌手：许嵩</dd>
             <dd class="icon-album"><span></span>所属专辑：《千古》</dd>
             <dd class="icon-like"><span></span><a href="#">喜欢</a></dd>
             <dd class="music">
                 <audio src="${pageContext.request.contextPath }/images/qg.mp3" controls></audio>
             </dd>
             <!--也可以添加loop属性 音频加载到末尾时，会重新播放-->
         </dl>
     </div>
