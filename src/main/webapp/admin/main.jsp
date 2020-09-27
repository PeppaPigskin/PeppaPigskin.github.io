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
        #mainDiv {
            height: 100%;
            width: 100%;
            position: absolute;
        }

        body {
            margin: 0px;
            padding: 0px;
            overflow: hidden;
        }

        dl {
            padding-left: 20px;
        }

        dt {
            font-family: Consolas;
            font-weight: bold;
        }

        dd {
            margin-top: 10px;
            margin-left: 40px;
        }

        dt, dd {
            cursor: pointer;
        }

        a {
            text-decoration: none;
        }

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

        /*打开修改密码窗口*/
        function openPasswordModifyDialog() {
            $("#dlg").dialog("open").dialog("setTitle", "修改密码");
            url = "${pageContext.request.contextPath}/admin/blogger/modifyPassword.do?id=${sessionScope.currentUser.id}";
        }

        /*修改密码*/
        function modifyPassword() {
            $("#fm").form("submit", {
                url: url,
                onSubmit: function () {
                    var newPassword = $("#newPassword").val();
                    var newPassword2 = $("#newPassword2").val();
                    if (!$(this).form("validate")) {
                        return false;
                    }
                    if (newPassword == null || newPassword == "") {
                        $.messager.alert("系统提示", "请输入新密码");
                        return false;
                    }
                    if (newPassword != newPassword2) {
                        $.messager.alert("系统提示", "两次输入密码不一致");
                        return false;
                    }
                    return true;
                },
                success: function (result) {
                    result = eval("(" + result + ")");
                    if (result.success) {
                        closePassword();
                        $.messager.alert('系统提示', '修改密码成功,请重新登录！', 'info', function () {
                            window.location.href = "${pageContext.request.contextPath}/admin/blogger/logout.do";
                        });
                    } else {
                        $.messager.alert("系统提示", "修改密码失败！");
                        return;
                    }
                }
            })
            ;
        }

        function openModifyBlog(url) {
            $("#centerFrame").attr("src", url)
        }

        /*清空值*/
        function resetValue() {
            $("#newPassword").val("");
            $("#newPassword2").val("");
        }

        /*关闭窗口*/
        function closePassword() {
            resetValue();
            $("#dlg").dialog("close");
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
<body>
<div id="mainDiv" class="easyui-layout">
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
    <div data-options="region:'south',split:true" style="background-color:#E0ECFF;height:80px;text-align: center">
        <p style="padding: 10px">底部版权及友情链接区</p>
    </div>
    <div data-options="region:'east',title:'消息区',split:true" style="width: 150px"></div>
    <div data-options="region:'west',title:'导航菜单',split:true" style="width:250px;">
        <dl>
            <dt>博客管理</dt>
            <dd>
                <a href="${pageContext.request.contextPath}/admin/creatBlog.jsp" target="centerFrame">写博客</a>
            </dd>
            <dd>
                <a href="${pageContext.request.contextPath}/admin/blogManage.jsp" target="centerFrame">博客信息管理</a>
            </dd>
        </dl>
        <dl>
            <dt>博客类别管理</dt>
            <dd>
                <a href="${pageContext.request.contextPath}/admin/blogTypeManage.jsp" target="centerFrame">博客类别信息管理</a>
            </dd>
        </dl>
        <dl>
            <dt>评论管理</dt>
            <dd>
                <a href="${pageContext.request.contextPath}/admin/blogCommentManage.jsp" target="centerFrame">评论信息管理</a>
            </dd>
        </dl>
        <dl>
            <dt>个人账户管理</dt>
            <dd>
                <a href="${pageContext.request.contextPath}/admin/bloggerInfoManage.jsp" target="centerFrame">个人信息维护</a>
            </dd>
            <dd>
                <a href="javascript:openPasswordModifyDialog()">密码修改</a>
            </dd>
        </dl>
        <dl>
            <c:set var="bloggerTypeAdmin" value="<%=ConstantsUtil.BloggerTypeEnum.BLOGGER_TYPE_ADMIN %>"></c:set>
            <c:set var="bloggerTypeManager" value="<%=ConstantsUtil.BloggerTypeEnum.BLOGGER_TYPE_MANAGER %>"></c:set>
            <c:set var="bloggerTypeUser" value="<%=ConstantsUtil.BloggerTypeEnum.BLOGGER_TYPE_USER %>"></c:set>
            <dt>系统管理</dt>
            <c:if test="${sessionScope.get('currentUser').accountType.value==bloggerTypeAdmin.value || sessionScope.get('currentUser').accountType.value==bloggerTypeManager.value}">
                <%--只有超级管理员具有账户管理权限--%>
                <c:if test="${sessionScope.get('currentUser').accountType.value==bloggerTypeAdmin.value}">
                    <dd>
                            <%-- <a href="#" target="centerFrame">账户管理</a>--%>
                    </dd>
                </c:if>
                <%--一般管理具有资源管理权限--%>
                <dd>
                        <%--  <a href="#" target="centerFrame">系统资源管理</a>--%>
                </dd>
                <dd>
                    <a href="${pageContext.request.contextPath}/admin/linkManage.jsp" target="centerFrame">友情链接管理</a>
                </dd>
            </c:if>
            <%--系统管理普通功能--%>
            <dd>
                <a href="javascript:refreshSystemResource()">刷新系统缓存</a>
            </dd>
            <dd>
                <a href="javascript:logout()">安全退出</a>
            </dd>
        </dl>
    </div>
    <div class="easyui-tabs" data-options="region:'center'">
        <iframe name="centerFrame" id="centerFrame" width="100%" height="100%"></iframe>
    </div>

    <div id="dlg" class="easyui-dialog" style="width:400px;height:250px;padding: 10px 20px;align-items: center"
         data-options="iconCls:'icon-save',resizable:true,modal:true" buttons="#dlg-buttons" closed="true">
        <form id="fm" method="post">
            <table cellspacing="8px">
                <tr>
                    <td>用户名：</td>
                    <td>
                        <input type="text" id="userName" name="userName" readonly="readonly" width="200px"
                               value="${sessionScope.get('currentUser').userName}"/>
                    </td>
                </tr>
                <tr>
                    <td>新密码：</td>
                    <td>
                        <input type="password" id="newPassword" name="newPassword" class="easyui-valdatebox"
                               required="true"/>
                    </td>
                </tr>
                <tr>
                    <td>确认密码：</td>
                    <td>
                        <input type="password" id="newPassword2" name="newPassword2" class="easyui-valdatebox"
                               required="true"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <div id="dlg-buttons">
        <a href="javascript:modifyPassword()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
        <a href="javascript:closePassword()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
    </div>
</div>
</body>
</html>