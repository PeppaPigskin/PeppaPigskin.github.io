<%--
  Created by IntelliJ IDEA.
  User: WuChen
  Date: 2020/09/29
  Time: 11:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!--设置博客头-->
<!--attached：进行附加-->
<div class="ui top attached segment">
    <div class="ui middle aligned two column grid">
        <div class="column">
            <h3 class="ui teal header">博客</h3>
        </div>
        <div class="column right aligned">
            <!--h元素为block元素，会换行，使用自定义样式进行转换-->
            共<h2 class="ui orange header m-inline-block m-text-thin">${blogSum}</h2>篇
        </div>
    </div>
</div>

<!--设置博客列表-->
<div class="ui teal attached segment">
    <c:forEach var="blog" items="${blogList}">
        <div class="ui padded vertical segment m-padded-tb-large">
            <!--mobile reversed:顺序调换-->
            <div class="ui stackable mobile reversed grid">
                <!--设置博文-->
                <div class="ui eleven wide column">
                    <!--设置博文标题-->
                    <h3 class="ui header">${blog.title}</h3>
                    <!--设置摘要-->
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
                                    <fmt:formatDate value="${blog.releaseDate}" pattern="yyyy年MM月dd日"></fmt:formatDate>
                                </div>

                                <!--设置浏览次数-->
                                <div class="item">
                                    <i class="eye icon"></i>${blog.clickHit}
                                </div>
                            </div>
                        </div>
                        <div class=" right aligned five wide column">
                            <a href="${pageContext.request.contextPath}/types.do"
                               class="ui teal basic label m-padded-tiny m-text-thin">${blog.blogType.typeName}</a>
                        </div>
                    </div>
                </div>

                <!--设置图片-->
                <div class="ui five wide column">
                    <!--target="_blank"：设置点击时新打开一个界面-->
                    <a href="#" target="_blank">
                        <img src="https://picsum.photos/id/1025/800/400" alt="" class="ui rounded image">
                    </a>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<!--设置底部放置分页的按钮-->
<div class="ui bottom attached segment">
    <div class="ui middle aligned three column grid">
        ${pageCode}
    </div>

</div>
