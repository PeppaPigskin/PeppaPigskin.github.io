<%--
  Created by IntelliJ IDEA.
  User: WuChen
  Date: 2020/09/17
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人博客系统后台登录页面</title>
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

    <style type="text/css">
        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

        .container {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            background-color: #f7f7f9;
        }

        h1 {
            color: rgb(128, 128, 128);
            text-align: center;
        }

        a:link, a:hover, a:visited, a:active {
            color: rgb(128, 128, 128);
            text-decoration: none;
        }

        form {
            width: 400px;
            min-width: 400px;
            position: absolute;
            left: 40%;
            top: 30%;
            margin: 0;
            padding: 30px;
            background-color: white;
            border: 2px solid rgba(128, 128, 128, 0.2);
            border-radius: 10px;
        }

        form div {
            margin-bottom: 10px;
        }
    </style>
    <script type="text/javascript">

        //验证表单
        function checkForm() {
            var userName = $("#userName").val();
            var password = $("#password").val();
            if (userName == null || userName == "") {
                $("#error").html("用户名不能为空！");
                return false;
            }
            if (password == null || password == "") {
                $("#error").html("密码不能为空！")
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="container">

    <form action="${pageContext.request.contextPath}/manager/login.do" method="post" onsubmit="return checkForm()">
        <div>
            <h1>用户登录</h1>
        </div>
        <div>
            <input class="easyui-textbox"
                   data-options="iconCls:'icon-man',iconWidth:30,iconAlign:'left',prompt:'用户名'"
                   style="width:100%;height:35px;" id="userName"
                   name="userName" placeholder="请输入用户名"
                   value="${requestScope.blogger.userName}"/>
        </div>
        <div>
            <input class="easyui-passwordbox" data-options="iconWidth:30,iconAlign:'left',prompt:'密码'"
                   style="width:100%;height:35px;" id="password" name="password"
                   placeholder="请输入密码"
                   value="${requestScope.blogger.password}"/>
        </div>
        <div>
            <input class="easyui-linkbutton" type="submit" value="登陆" style="width:100%;height:35px;"/>
        </div>
        <div style="text-align: center; clear: both;padding-top: 10px">
            <p><font color="red" id="error">${requestScope.errInfo}</font></p>
        </div>
    </form>
</div>
</body>
</html>
