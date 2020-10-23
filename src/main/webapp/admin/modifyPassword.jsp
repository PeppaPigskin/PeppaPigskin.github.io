<%--
  Created by IntelliJ IDEA.
  User: WuChen
  Date: 2020/09/18
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <title>修改密码</title>
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


    <%--引入ueditor相关资源--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/ueditor/lang/zh-cn/zh-cn.js"></script>
    <%--自定义css--%>
    <style type="text/css">

    </style>

    <%--自定义js--%>
    <script type="text/javascript">

        /*修改密码*/
        function modifyPassword() {
            var newPassword = $("#newPassword").val();
            var newPassword2 = $("#newPassword2").val();
            if (newPassword == null || newPassword == "") {
                $.messager.alert("系统提示", "请输入新密码");
                return;
            }
            if (newPassword != newPassword2) {
                $.messager.alert("系统提示", "两次输入密码不一致");
                return;
            }
            $.post(
                "${pageContext.request.contextPath}/admin/blogger/modifyPassword.do",
                {
                    'id': ${sessionScope.currentUser.id},
                    'newPassword': newPassword
                },
                function (result) {
                    if (result.success) {
                        $.messager.alert('系统提示', '修改密码成功,请重新登录！', 'info', function () {
                            window.location.href = "${pageContext.request.contextPath}/admin/blogger/logout.do";
                        });
                    } else {
                        $.messager.alert("系统提示", "修改密码失败！");
                        return;
                    }
                },
                "json"
            );

            $("#fm").form("submit", {
                url: url,
                onSubmit: function () {
                    if (!$(this).form("validate")) {
                        return false;
                    }
                    return true;
                },
                success: function (result) {
                    result = eval("(" + result + ")");
                    if (result.success) {
                        resetValue();
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

        /*清空值*/
        function resetValue() {
            $("#newPassword").val("");
            $("#newPassword2").val("");
        }

    </script>
</head>
<body>
<%--消息提示框--%>
<div id="edit_p" class="easyui-panel" title="修改密码" align="center">
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
            <tr>
                <td></td>
                <td>
                    <a href="javascript:modifyPassword()" class="easyui-linkbutton"
                       data-options="iconCls:'icon-save'">保存</a>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
