<%--
  Created by IntelliJ IDEA.
  User: WuChen
  Date: 2020/09/30
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <!--进行移动端页面适应设置-->
    <meta name="viewport" content="width=device,initial-scale=1.0">
    <title>${title}</title>
    <!--引入前端框架的semantic的css资源-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
    <!--引入动画样式-尚未起效-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.0.0/animate.min.css"/>
    <!--引入文本排版样式-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/typo.css">
    <!--    <link rel="stylesheet" href="static/css/animate.css">-->
    <!--引入字体高亮的样式-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/lib/prism/prism.css">
    <!--引入目录生成样式----对应的h标签必须要有id属性-->
    <!--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tocbot/4.11.1/tocbot.css">-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/lib/tocbot/tocbot.css">
    <!--引入自定义样式-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myStyle.css">
    <!--引入jquery资源-->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.2/dist/jquery.min.js"></script>
    <!--引入前端框架semantic的js资源-->
    <script src="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.js"></script>
    <!--引入目录生成js-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tocbot/4.11.1/tocbot.min.js"></script>
    <!--一引入平滑滚动插件js-->
    <script src="https://cdn.jsdelivr.net/npm/jquery.scrollto@2.1.2/jquery.scrollTo.min.js"></script>
    <!--引入滚动检测js插件-->
    <script src="${pageContext.request.contextPath}/static/lib/waypoint/jquery.waypoints.min.js"></script>
    <!--引入二维码生成js-->
    <script src="${pageContext.request.contextPath}/static/lib/qrcode/qrcode.js"></script>
    <!--引入字体高亮的js-->
    <script src="${pageContext.request.contextPath}/static/lib/prism/prism.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#archivesMenu").addClass("active");
            $("#searchBtn").hide();
        });
    </script>
</head>
<body>
<jsp:include page="template_nav.jsp"></jsp:include>
<!--设置中间内容部分-->
<div class="m-padded-tb-big m-container-small">
    <!--container：设置显示最好的效果-->
    <div class="ui container">

        <!--设置归档头-->
        <!--attached：进行附加-->
        <div class="ui top attached padded segment">
            <div class="ui middle aligned two column grid">
                <div class="column">
                    <h3 class="ui teal header">归档</h3>
                </div>
                <div class="column right aligned">
                    <!--h元素为block元素，会换行，使用自定义样式进行转换-->
                    共<h2 class="ui orange header m-inline-block m-text-thin">${blogSum}</h2>篇文章
                </div>
            </div>
        </div>

        <!--按照年月归档-->
        <c:forEach items="${blogNewMap}" var="kv">
            <h3 class="ui header center aligned">${kv.key}</h3>
            <div class="ui fluid vertical menu">
                <c:forEach items="${kv.value}" var="blog">
                    <a href="${pageContext.request.contextPath}/blog/${blog.id}.do" target="_blank" class="item">
                        <span>
                            <i class="teal circle icon"></i>${blog.title}
                            <div class="ui teal basic left pointing label m-padded-mini m-text-thin">
                                <fmt:formatDate value="${blog.releaseDate}" pattern="dd日"></fmt:formatDate>
                            </div>
                        </span>
                        <div class="ui yellow basic left pointing label m-padded-mini">${blog.blogType.typeName}</div>
                    </a>
                </c:forEach>
            </div>
        </c:forEach>

        <!--设置底部放置分页的按钮-->
        <div class="ui bottom attached segment">
            <div class="ui middle aligned three column grid">
                ${pageCode}
            </div>
        </div>
    </div>
</div>
<jsp:include page="template_footer.jsp"></jsp:include>
</body>
</html>
