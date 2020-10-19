<%--
  Created by IntelliJ IDEA.
  User: WuChen
  Date: 2020/09/29
  Time: 11:22
  To change this template use File | Settings | File Templates.
  Description:前台导航栏模板页
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--设置导航部分-->
<!-- inverted：黑色 ;attached:取消圆角-->
<nav class="ui inverted attached segment m-padded-tb-mini m-shadow-small">
    <div class="ui container">
        <!--    设置导航组件-->
        <!--stackable:可堆叠-->
        <div class="ui inverted secondary stackable menu">
            <h2 class="ui teal header item"><a href="${pageContext.request.contextPath}/index.do">个人博客</a></h2>
            <a id="indexMenu" href="${pageContext.request.contextPath}/index.do" target="_self"
               class="menu-item item m-mobile-hide">
                <i class="home icon"></i>首页
            </a>
            <a id="typesMenu" href="${pageContext.request.contextPath}/types.do" target="_self"
               class="menu-item item m-mobile-hide">
                <i class="idea icon"></i>分类
            </a>
            <%--
            <a href="${pageContext.request.contextPath}/tags.do" class="menu-item item m-mobile-hide">
                <i class="tags icon"></i>标签
            </a>
            --%>
            <a id="archivesMenu" href="${pageContext.request.contextPath}/archives.do" target="_self"
               class="menu-item item m-mobile-hide">
                <i class="clone icon"></i>归档
            </a>
            <a id="aboutMenu" href="${pageContext.request.contextPath}/about.do" target="_self"
               class="menu-item item m-mobile-hide">
                <i class="info icon"></i>关于我
            </a>
            <div id="searchBtn" class="right menu-item item m-mobile-hide">
                <div class="ui icon inverted transparent input">
                    <form id="luceneSearch" action="${pageContext.request.contextPath}/q.do" method="post">
                        <input id="mainPageName" name="mainPageName" type="hidden">
                        <input id="q" name="q" type="text" placeholder="查找...">
                        <i class="search link icon" onclick="javascript:window.parent.luceneSearch()"></i>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--添加图标,用于展示堆叠页签-->
    <a href="#" id="show_hide_icon" class="ui menu toggle black icon button m-position-top-right m-mobile-show">
        <i class="sidebar icon"></i>
    </a>
</nav>
<script>

    /*用于空值堆叠项的显示与隐藏属性*/
    $('.menu.toggle').click(function () {
        $('.menu-item').toggleClass('m-mobile-hide');
    });
</script>

