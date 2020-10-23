<%--
  Created by IntelliJ IDEA.
  User: WuChen
  Date: 2020/09/18
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人信息维护</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
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
        /*提交保存数据验证*/
        function submitData() {
            var nickName = $('#nickName').val();
            var sign = $('#sign').val();
            var profile = $('#profile').val();
            var imageFile = $('#imageFile').val();
            if (nickName == null || nickName == "") {
                $.messager.alert("系统提示", "请输入昵称信息！");
            }
            if (sign == null || sign == "") {
                $.messager.alert("系统提示", "请输入个性签名信息！");
            }

            if (profile == null || profile == "") {
                $.messager.alert("系统提示", "请输入个人简介信息！");
            }
            $('#formBloggerInfo').submit();
        }
    </script>
</head>
<body>
<div style="width: 100%;height: 100%;">
    <div id="edit_p" class="easyui-panel" title="修改个人信息" style="padding: 10px">
        <%--TODO:因为要支持图片上传功能，所以使用设置form的enctype="multipart/form-data"--%>
        <form id="formBloggerInfo" action="${pageContext.request.contextPath}/admin/blogger/updBlogger.do" method="post"
              enctype="multipart/form-data">
            <input type="hidden" id="id" name="id" value="${sessionScope.currentUser.id}"/>
            <input type="hidden" id="accountType" name="accountType" value="${sessionScope.currentUser.accountType}"/>
            <table cellspacing="20px">
                <tr>
                    <td width="80px">用户名：</td>
                    <td>
                        <input type="text" id="userName" name="userName" style="width: 400px"
                               value="${sessionScope.currentUser.userName}" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                    <td>昵称：</td>
                    <td>
                        <input type="text" id="nickName" name="nickName" style="width: 400px"
                               value="${sessionScope.currentUser.nickName}" placeholder="请输入昵称..."/>
                    </td>
                </tr>
                <tr>
                    <td>个性签名：</td>
                    <td>
                        <input type="text" id="sign" name="sign" style="width: 400px"
                               value="${sessionScope.currentUser.sign}" placeholder="个性签名..."/>
                    </td>
                </tr>
                <tr>
                    <td>个人头像：</td>
                    <td>
                        <input type="file" id="imageFile" name="imageFile" style="width: 400px"/>
                    </td>
                </tr>
                <tr>
                    <td>文字简介：</td>
                    <td>
                        <textarea rows="10" id="profile" style="width:800px; resize:none;" name="profile"
                                  placeholder="个人文字简介..."> ${sessionScope.currentUser.profile}</textarea>

                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <a href="javascript:submitData()" class="easyui-linkbutton"
                           data-options="iconCls:'icon-save'">保存修改</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>
