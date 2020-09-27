<%@ page import="com.wcc.util.ConstantsUtil" %><%--
  Created by IntelliJ IDEA.
  User: WuChen
  Date: 2020/09/17
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>个人博客系统后台管理</title>
    <meta http-equiv="Content-Type" content="text/html;charst=UTF-8">
    <%--引入easyui相关资源--%>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/jquery-easyui-1.7.0/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/jquery-easyui-1.7.0/themes/icon.css">
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/jquery-easyui-1.7.0/jquery.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/jquery-easyui-1.7.0/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/jquery-easyui-1.7.0/locale/easyui-lang-zh_CN.js"></script>

    <%--自定义js和css--%>
    <style type="text/css">

    </style>

    <script type="text/javascript">

        var url;
        $(function () {
            //设置所有的dd标签隐藏
            $("dd").hide();
            //显示第一个dt下的dd显示
            $("dt").first().siblings().show();
            //点击每一个dt时，设置其同胞隐藏
            $("dt").on('click', function () {
                $(this).siblings().slideToggle(500);
            });
        });

        /*刷新系统资源*/
        function refreshSystemResource() {
            $.post("${pageContext.request.contextPath}/admin/systemManager/refreshSystemResource.do", {}, function (result) {
                if (result.success) {
                    $.messager.alert("系统提示", "已成功刷新系统缓存！")
                } else {
                    $.messager.alert("系统提示", "刷新系统缓存失败！")
                }
            }, "json");
        }

        /*打开页签*/
        function openTab(text, url, iconCls) {
            /*判断是否存在*/
            if ($("#tabs").tabs("exists", text)) {
                /*存在就打开*/
                $("#tabs").tabs("select", text);
            } else {
                /*不存在添加*/
                var content = "<iframe frameborder='0' scrolling='auto' style='width: 100%;height: 100%' src='${pageContext.request.contextPath}/admin/" + url + "'></iframe>";
                $("#tabs").tabs("add", {
                    title: text,
                    iconCls: iconCls,
                    closable: true,
                    content: content
                });
            }
        }

        /*退出系统*/
        function logout() {
            $.messager.confirm("系统提示", "您确定要退出系统吗？", function (r) {
                if (r) {
                    window.location.href = "${pageContext.request.contextPath}/admin/blogger/logout.do";
                }
            });
        }

    </script>
</head>
<body class="easyui-layout">

<%--顶部区域--%>
<div region="north" style="height:100px;background-color:#E0ECFF;overflow: hidden">
    <table style="padding: 5px" width="100%">
        <tr>
            <td style="padding-top: 16px;" valign="middle" align="left" width="50%">
                <font size="3">&nbsp;&nbsp;<strong>个人博客系统</strong></font>
            </td>
            <td style="padding-top: 16px;" valign="middle" align="right" width="50%">
                <font size="3">&nbsp;&nbsp;欢迎：<strong>【${sessionScope.get('currentUser').accountType.desc}】-【${sessionScope.currentUser.nickName}】</strong>进入该系统！</font>
            </td>
        </tr>
    </table>
</div>

<%--中心区域--%>
<div region="center">
    <div class="easyui-tabs" fit="true" border="false" id="tabs">
        <div title="首页" data-options="iconCls:'icon-home'">
            <div align="center" style="padding-top: 100px;">
                <font color="red" size="10">欢迎使用</font>
            </div>
        </div>
    </div>
</div>

<%--导航栏区域--%>
<div region="west" title="导航菜单" split="true" style="width:250px;">
    <div class="easyui-accordion" data-options="fit:true,border:false">
        <div title="常用操作" data-options="iconCls:icon-ok" style="padding: 10px;">
            <a href="javascript:openTab('写博客','creatBlog.jsp','icon-ok')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-ok'" style="width: 150px">写博客</a>
            <a href="javascript:openTab('评论信息管理','blogCommentManage.jsp','icon-glpl')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-ok'" style="width: 150px">评论信息管理</a>
        </div>
        <div title="博客管理" data-options="iconCls:icon-ok" style="padding: 10px;">
            <a href="javascript:openTab('写博客','creatBlog.jsp','icon-ok')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-ok'" style="width: 150px">写博客</a>
            <a href="javascript:openTab('博客信息管理','blogManage.jsp','icon-ok')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-ok'" style="width: 150px">博客信息管理</a>
        </div>
        <div title="博客类别管理" data-options="iconCls:icon-ok" style="padding: 10px;">
            <a href="javascript:openTab('博客类别信息管理','blogTypeManage.jsp','icon-ok')" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-ok'" style="width: 150px">博客类别信息管理</a>
        </div>
        <div title="评论管理" data-options="iconCls:icon-ok" style="padding: 10px;">
            <a href="javascript:openTab('评论信息管理','blogCommentManage.jsp','icon-ok')"
               class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-ok'" style="width: 150px">评论信息管理</a>
        </div>
        <div title="个人账户管理" data-options="iconCls:icon-ok" style="padding: 10px;">
            <a href="javascript:openTab('个人信息维护','bloggerInfoManage.jsp','icon-ok')"
               class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-ok'" style="width: 150px">个人信息维护</a>
            <a href="javascript:openTab('密码修改','modifyPassword.jsp','icon-ok')"
               class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-ok'"
               style="width: 150px">密码修改</a>
        </div>
        <div title="系统管理" data-options="iconCls:icon-ok" style="padding: 10px;">
            <c:set var="bloggerTypeAdmin" value="<%=ConstantsUtil.BloggerTypeEnum.BLOGGER_TYPE_ADMIN %>"></c:set>
            <c:set var="bloggerTypeManager"
                   value="<%=ConstantsUtil.BloggerTypeEnum.BLOGGER_TYPE_MANAGER %>"></c:set>
            <c:set var="bloggerTypeUser" value="<%=ConstantsUtil.BloggerTypeEnum.BLOGGER_TYPE_USER %>"></c:set>
            <c:if test="${sessionScope.get('currentUser').accountType.value==bloggerTypeAdmin.value || sessionScope.get('currentUser').accountType.value==bloggerTypeManager.value}">
                <%--只有超级管理员具有账户管理权限--%>
                <c:if test="${sessionScope.get('currentUser').accountType.value==bloggerTypeAdmin.value}">
                    <%-- <a href="#" target="centerFrame">账户管理</a>--%>
                </c:if>
                <%--一般管理具有资源管理权限--%>
                <%--  <a href="#" target="centerFrame">系统资源管理</a>--%>
                <a href="javascript:openTab('友情链接管理','linkManage.jsp','icon-ok')"
                   class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-ok'"
                   style="width: 150px">友情链接管理</a>
            </c:if>
            <%--系统管理普通功能--%>
            <a href="javascript:refreshSystemResource()" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-ok'"
               style="width: 150px">刷新系统缓存</a>
            <a href="javascript:logout()" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-ok'"
               style="width: 150px">安全退出</a>
        </div>
    </div>
</div>

<%--右侧区域--%>
<div region="east" title="消息区" split="true" style="width: 150px"></div>

<%--底部区域--%>
<div region="south" style="height:80px;padding: 5px" align="center">
    <p style="padding: 10px">底部版权及友情链接区</p>
</div>

</body>
</html>

