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
            <h2 class="ui teal header item"><a href="${pageContext.request.contextPath}/index.do">MyBlog</a></h2>
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
            <%--
            <div class="right menu-item item m-mobile-hide">
                <div class="ui icon inverted transparent input">
                    <input type="text" placeholder="查找...">
                    <i class="search link icon"></i>
                </div>
            </div>
            --%>
        </div>
    </div>

    <!--添加图标-->
    <a href="#" id="show_hide_icon" class="ui menu toggle black icon button m-position-top-right m-mobile-show">
        <i class="sidebar icon"></i>
    </a>
</nav>

