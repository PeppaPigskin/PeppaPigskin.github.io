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
            $("#typesMenu").addClass("active");
        });

        //点击查询按钮时触发
        function luceneSearch() {
            var q = document.getElementById("q").value.trim();
            if (q == null || "" == q) {
                alert("请输入要查找的关键字");
                return;
            }
            var form = document.getElementById('luceneSearch');
            document.getElementById('mainPageName').value = 'types';
            form.submit();
        }

        //表单提交前验证（包含回车提交）
        function luceneSearchKeyDown() {
            var q = document.getElementById("q").value.trim();
            if (q == null || "" == q) {
                alert("请输入要查找的关键字");
                return false;
            }
            document.getElementById('mainPageName').value = 'types';
            return true;
        }

    </script>
</head>
<body>
<jsp:include page="template_nav.jsp"></jsp:include>
<!--设置中间内容部分-->
<div class="m-padded-tb-big m-container-small">
    <!--container：设置显示最好的效果-->
    <div class="ui container">

        <!--设置分类头-->
        <!--attached：进行附加-->
        <div class="ui top attached segment">
            <div class="ui middle aligned two column grid">
                <div class="column">
                    <h3 class="ui teal header">分类</h3>
                </div>
                <div class="column right aligned">
                    <!--h元素为block元素，会换行，使用自定义样式进行转换-->
                    共<h2
                        class="ui orange header m-inline-block m-text-thin">${applicationScope.blogTypeListName.size()}</h2>
                    个
                </div>
            </div>
        </div>

        <!--设置分类标签按钮-->
        <div class="ui attached segment m-padded-tb-large">
            <c:forEach items="${applicationScope.blogTypeListName}" var="blogType">
                <%--                <c:if test="${blogType.blogCount>0}">--%>
                <div class="ui labeled button m-margin-tb-tiny">
                    <a href="${pageContext.request.contextPath}/types.do?typeId=${blogType.id}"
                       class="ui basic teal button">${blogType.typeName}</a>
                    <div class="ui basic teal left pointing label">${blogType.blogCount}</div>
                </div>
                <%--                </c:if>--%>
            </c:forEach>
        </div>

        <!--设置选中分类博客列表-->
        <%--<div class="ui top attached teal segment">
            <c:forEach var="blog" items="${blogList}">
                <div class="ui padded vertical segment m-padded-tb-large m-mobile-lr-clear">
                    <!--mobile reversed:顺序调换-->
                    <div class="ui stackable mobile reversed grid">
                        <!--设置博文-->
                        <div class="ui eleven wide column">
                            <!--设置博文标题-->
                            <h3 class="ui header">
                                <a href="${pageContext.request.contextPath}/blog/${blog.id}.do"
                                   target="_blank">${blog.title}</a>
                            </h3>
                            <!--设置段落内容-->
                            <p class="m-text">
                                    ${blog.summary}...
                            </p>

                            <div class="ui stackable grid">
                                <div class="eleven wide column">
                                    <div class="ui mini horizontal link list">

                                        <!--设置图标-->
                                        <div class="item">
                                            <img src="${pageContext.request.contextPath}/static/userIcon/${blog.blogger.imageName}"
                                                 alt=""
                                                 class="ui avatar image">
                                            <div class="content">
                                                <a href="${pageContext.request.contextPath}/about.do"
                                                   class="header">${blog.blogger.nickName}</a>
                                            </div>
                                        </div>

                                        <!--设置发布日期-->
                                        <div class="item">
                                            <i class="calendar icon"></i>
                                            <fmt:formatDate value="${blog.releaseDate}"
                                                            pattern="yyyy年MM月dd日"></fmt:formatDate>

                                        </div>

                                        <!--设置浏览次数-->
                                        <div class="item">
                                            <i class="eye icon"></i>${blog.clickHit}
                                        </div>
                                    </div>
                                </div>
                                <div class=" right aligned five wide column">
                                    <a href="${pageContext.request.contextPath}/types.do"
                                       class="ui teal basic label m-padded-tiny m-text-thin"
                                       target="_blank">${blog.blogType.typeName}</a>
                                </div>
                            </div>
                        </div>

                        <!--设置图片-->
                        <div class="ui five wide column">
                            <!--target="_blank"：设置点击时新打开一个界面-->
                            <a href="${pageContext.request.contextPath}/blog/${blog.id}.do" target="_blank">
                                <img src="https://picsum.photos/id/1025/800/400" alt="" class="ui rounded image">
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>--%>
        <jsp:include page="${mainPage}"></jsp:include>

    </div>
</div>

<jsp:include page="template_footer.jsp"></jsp:include>
</body>
</html>
