
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
    <meta charset="utf-8">
    <title>D.B的个人博客</title>
    <!-- 给搜索引擎看的 -->
    <meta name="keywords" content="个人博客,刘东宝,个人博客模板,博客模板,css3,html5,网站模板"/>
    <meta name="description" content="这是一个主题为黑色时间轴的css3 html5个人博客网站"/>
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/animation.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/view.css" rel="stylesheet">
    <!-- 返回顶部调用 begin -->
    <link href="${pageContext.request.contextPath}/css/lrtk.css" rel="stylesheet"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/js.js"></script>
</head>
<body >
<div class="scanlines"></div>
<header>
    <jsp:include page="foreground/common/header.jsp"></jsp:include>
</header>
<!--header end-->
<div id="mainbody">
    <div class="info">
        <figure><img src="images/art.jpg" alt="Panama Hat">
            <figcaption><strong>渡人如渡己，渡已，亦是渡</strong> 当我们被误解时，会花很多时间去辩白。
                但没有用，没人愿意听，大家习惯按自己的所闻、理解做出判别，每个人其实都很固执。与其努力且痛苦的试图扭转别人的评判，不如默默承受，给大家多一点时间和空间去了解。而我们省下辩解的功夫，去实现自身更久远的人生价值。其实，渡人如渡己，渡已，亦是渡人。
            </figcaption>
        </figure>
        <div class="card">
            <h1>我的名片</h1>
            <p>网名：${bloger.nickName}</p>
            <p>职业：${bloger.job}</p>
            <p>爱好：${bloger.hobby}</p>
            <p>Email：${bloger.email}</p>
            <ul class="linkmore">
                <li><a href="#" class="talk" title="给我留言"></a></li>
                <li><a href="${pageContext.request.contextPath }/background/login.jsp" class="address" title="联系地址" target="_blank"></a></li>
                <li><a href="#" class="email" title="给我写信"></a></li>
                <li><a href="#" class="photos" title="生活照片"></a></li>
                <li><a href="#" class="heart" title="关注我"></a></li>
            </ul>
        </div>
    </div>
    <!--info end-->
    <div class="blank"></div>
    <div class="blogs">
        <!--bloglist begin-->
        <ul class="bloglist">
            <jsp:include page="${blogListTemp }"></jsp:include>
        </ul>
        
        <aside>
        	<jsp:include page="foreground/common/leftSide.jsp"></jsp:include>
        </aside>
        <!--bloglist end-->
       
        <div class="page">${pageCode }</div>  
    </div>
    <!--blogs end-->
</div>
<!--mainbody end-->
<footer>
    <jsp:include page="foreground/common/foot.jsp"></jsp:include>
</footer>

<!-- jQuery仿腾讯回顶部和建议 代码开始 -->
<div id="tbox"><a id="togbook" href="${pageContext.request.contextPath }/blogAdvice/preAdvice.do"></a> <a id="gotop" href="javascript:void(0)"></a></div>

<div id="dialog">
	<div class="tip-bubble tip-bubble-right">
		<div style="margin-bottom: 5px"><font color="#555333" size="2px" id="reply">亲爱的客人，快找我聊聊天吧</font></div>
		<input type="text" id="info" style="background-color: transparent;width: 100px; color: #555333;" onkeyup="if(event.keyCode==13)submitContent();" /><input type="button" onclick="javascript:submitContent()" value="发送">
	</div>
</div>
<img id="oImg" src="images/face1.gif" />
</body>
</html>
