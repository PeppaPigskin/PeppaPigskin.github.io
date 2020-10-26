<%--
  Created by IntelliJ IDEA.
  User: WuChen
  Date: 2020/09/29
  Time: 11:30
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
        //设置当前点击的页签的class为活动状态
        $(function () {
            $("#indexMenu").addClass("active");
        });

        //点击查询按钮时触发
        function luceneSearch() {
            var q = document.getElementById("q").value.trim();
            if (null == q || "" == q) {
                alert("请输入要查找的关键字");
                return;
            }
            var form = document.getElementById('luceneSearch');
            document.getElementById('mainPageName').value = 'index';
            form.submit();
        }

        //表单提交前验证（包含回车提交）
        function luceneSearchKeyDown() {
            var q = document.getElementById("q").value.trim();
            if (null == q || "" == q) {
                alert("请输入要查找的关键字");
                return false;
            }
            document.getElementById('mainPageName').value = 'index';
            return true;
        }

    </script>
</head>
<body>
<jsp:include page="template_nav.jsp"></jsp:include>

<!--设置中间内容部分-->
<div class="m-padded-tb-big m-container">
    <!--container:根据屏幕不同尺寸达到最适应的效果-->
    <div class="ui container">
        <div class="ui stackable grid">
            <!--左边-设置文章内容占11份-->
            <div class="eleven wide column">
                <jsp:include page="${mainPage}"></jsp:include>
            </div>
            <!--右边-置卡片部分占5份-->
            <div class="five wide column">

                <!--分类部分-->
                <div class="ui segments m-margin-top-lager">
                    <!--分类头-->
                    <div class="ui secondary segment">
                        <div class="ui two column grid">
                            <div class="column">
                                <i class="tags icon"></i>按博客分类
                            </div>
                            <div class="column right aligned">
                                <a href="${pageContext.request.contextPath}/types.do" target="_self">more <i
                                        class="icon angle double right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!--具体标签-->
                    <div class="ui teal segment">
                        <c:forEach var="blogType" items="${applicationScope.blogTypeListName}">
                            <c:if test="${blogType.blogCount>0}">
                                <a href="${pageContext.request.contextPath}/index.do?typeId=${blogType.id}"
                                   class="ui teal basic left pointing label m-margin-tb-tiny">
                                        ${blogType.typeName}
                                    <div class="detail">${blogType.blogCount}</div>
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>

                <!--日期归档部分-->
                <div class="ui segments">
                    <!--日期归档头-->
                    <div class="ui attached secondary segment">
                        <div class="ui two column grid">
                            <div class="column">
                                <i class="calendar icon"></i>按博客日期
                            </div>
                            <div class="column right aligned">
                                <a href="${pageContext.request.contextPath}/archives.do" target="_self">more <i
                                        class="icon angle double right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!--具体归档-->
                    <div class="ui teal segment">
                        <!--fluid:设置填充外层容器-->
                        <div class="ui fluid vertical menu">
                            <c:forEach items="${applicationScope.blogCountList}" var="blog">
                                <c:if test="${blog.blogCount>0}">
                                    <a href="${pageContext.request.contextPath}/index.do?releaseDateStr=${blog.releaseDateStr}"
                                       class="item">
                                            ${blog.releaseDateStr}
                                        <div class="ui teal basic left pointing label">${blog.blogCount}</div>
                                    </a>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>


                <!--友情链接部分-->
                <div class="ui segments m-margin-top-lager">
                    <!--标签头-->
                    <div class="ui secondary segment">
                        <i class="bookmark icon"></i>友情链接
                    </div>
                    <!--友情链接列表-->
                    <c:forEach items="${applicationScope.linkList}" var="link">
                        <div class="ui segment">
                            <a href="${link.linkUrl}" target="_blank"
                               class="m-color-black m-text-thin">${link.linkName}</a>
                        </div>
                    </c:forEach>
                </div>
                <%--
                <!--二维码部分-->
                <h4 class="ui horizontal divider header m-margin-top-lager">有问题请扫描联系我</h4>
                <div class="ui centered card" style="width:11em;height: 11em">
                    <img src="${pageContext.request.contextPath}/static/images/weChart.png" alt=""
                         class="ui rounded image">
                </div>
                --%>
            </div>
        </div>
    </div>
</div>

<jsp:include page="template_footer.jsp"></jsp:include>
</body>
</html>
