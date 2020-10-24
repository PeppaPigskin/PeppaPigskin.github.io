<%--
  Created by IntelliJ IDEA.
  User: WuChen
  Date: 2020/09/21
  Time: 22:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <title>修改博客数据</title>
    <meta http-equiv="Content-Type" content="text/html;charst=UTF-8">

    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/js/jquery-3.4.1.min.js"></script>

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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/editor/css/editormd.css"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/editormd.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/lib/marked.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/lib/prettify.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/lib/raphael.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/lib/underscore.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/lib/sequence-diagram.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/lib/flowchart.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/lib/jquery.flowchart.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/editor/editormd.js"></script>

    <%--自定义js--%>
    <script type="text/javascript">

        var testEditor;
        $(function () {
            /*用于保存初始化编辑器的内容*/
            var markContent;

            /*异步加载数据用于初始化修改的数据*/
            $.ajax({
                url: "${pageContext.request.contextPath}/admin/blog/findById.do",
                async: false,
                data: {"id": "${param.blogId}"},/*使用传过来的参数id获取初始化数据*/
                success: function (result) {
                    $("#title").val(result.title);
                    $("#summary").val(result.summary);
                    markContent = result.content;
                    $("#keyWord").val(result.keyWord);
                    $("#blogTypeId").combobox("setValue", result.blogType.id);
                },
                dataType: "json"
            });

            /*初始化编辑器*/
            testEditor = editormd("editormd", {//注意1：这里的就是上面的DIV的id属性值
                width: "100%",
                height: 640,
                syncScrolling: "single",
                path: "${pageContext.request.contextPath}/static/editor/lib/",//注意2：你的路径
                saveHTMLToTextarea: true,//注意3：这个配置，方便post提交表单

                /*启用表情*/
                emoji: true,

                /*本地图片上传*/
                imageUpload: true,
                imageFormats: ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
                imageUploadURL: "${pageContext.request.contextPath}/admin/blog/editorPic.do",//注意你后端的上传图片服务地址

                /*编辑器加载完毕相关处理*/
                onload: function () {
                    /*初始化编辑器内容*/
                    this.setMarkdown(markContent);
                }
            });


        });

        /*提交修改的博客数据*/
        function submitData() {
            var title = $("#title").val();
            var blogTypeId = $("#blogTypeId").combobox("getValue");
            var content = $("#content").val();
            var summary = $("#summary").val();
            var keyWord = $("#keyWord").val();
            var title = $("#title").val();
            var bloggerId = ${sessionScope.get('currentUser').id};
            if (bloggerId == null || bloggerId == '') {
                $.messager.alert("系统提示", "用户信息异常！");
                return;
            }

            if (title == null || title == '') {
                $.messager.alert("系统提示", "博客标题不能为空！");
                return;
            }
            if (blogTypeId == null || blogTypeId == '') {
                $.messager.alert("系统提示", "请选择博客类别！");
                return;
            }
            if (summary == null || summary == '') {
                $.messager.alert("系统提示", "请输入博客摘要！");
                return;
            }
            if (content == null || content == '') {
                $.messager.alert("系统提示", "请输入博客内容！");
                return;
            }
            $.post(
                "${pageContext.request.contextPath}/admin/blog/editBlog.do",
                {
                    'id': '${param.blogId}',
                    'title': title,
                    'blogType.id': blogTypeId,
                    'blogger.id': bloggerId,
                    'summary': summary,
                    'content': content,
                    'keyWord': keyWord,
                },
                function (result) {
                    if (result.success) {
                        $.messager.alert("系统提示", "保存成功！");
                    } else {
                        $.messager.alert("系统提示", "保存失败！");
                    }
                },
                "json"
            );
        }
    </script>
</head>
<body>
<div style="width: 100%;height: 100%;">
    <div id="edit_p" class="easyui-panel" title="修改博客" style="padding: 10px">
        <table cellspacing="20px">
            <tr>
                <td width="80px">博客标题：</td>
                <td>
                    <input type="text" placeholder="请输入博客标题..." id="title" name="title" style="width: 800px">
                </td>
            </tr>
            <tr>
                <td>所属类别：</td>
                <td>
                    <select class="easyui-combobox" id="blogTypeId" name="blogType.id" style="width: 400px"
                            editable="false" panelHeight="auto">
                        <option value="">请选择博客类别...</option>
                        <c:forEach items="${applicationScope.blogTypeListName}" var="blogType">
                            <option value="${blogType.id}">${blogType.typeName}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>博客摘要：</td>
                <td>
                    <textarea rows="10" id="summary" style="width:800px; resize:none;" name="summary"
                              placeholder="博客摘要..."></textarea>
                </td>
            </tr>
            <tr>
                <td>博客内容：</td>
                <td>
                    <div id="editormd">
                        <textarea id="content" style="display:none;" name="content"></textarea>
                    </div>
                </td>
            </tr>
            <tr>
                <td>关键字：</td>
                <td>
                    <input type="text" placeholder="请输入关键字..." id="keyWord" name="keyWord" style="width: 400px">
                    &nbsp;（多个关键字使用空格隔开）
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
    </div>
</div>


</body>
</html>

