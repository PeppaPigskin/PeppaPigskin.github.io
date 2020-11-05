<%--
  Created by IntelliJ IDEA.
  User: WuChen
  Date: 2020/09/18
  Time: 16:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>博客信息管理</title>
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

    <script type="text/javascript">
        /*返回该行博客类型名*/
        function formatBlogType(val, row) {
            return val.typeName;
        }

        /*返回该行博客博主名*/
        function formatBlogger(val, row) {
            return val.nickName;
        }

        /*设置博客状态*/
        function formatBlogStatus(val, row) {
            if (val == 0) {
                return "未发布";
            } else if (val == 1) {
                return "已发布";
            } else if (val == 2) {
                return "已撤销发布";
            }
        }

        /*根据标题查询博客数据*/
        function searchBlog() {
            $("#dg").datagrid("load", {"title": $("#s_title").val()});
        }

        /*修改一条博客数据*/
        function openBlogModifyDialog() {
            var selBlogs = $("#dg").datagrid("getSelections");
            if (selBlogs.length != 1) {
                $.messager.alert("系统提示", "请选择一条要修改的博客数据！")
                return;
            }
            var selBlog = selBlogs[0];
            /*TODO:调用父窗体中的方法*/
            window.parent.openModifyBlog("${pageContext.request.contextPath}/admin/modifyBlog.jsp?blogId=" + selBlog.id);
        }

        /*删除博客数据*/
        function deleteBlog() {
            var selBlogs = $("#dg").datagrid("getSelections");
            if (selBlogs.length <= 0) {
                $.messager.alert("系统提示", "请至少选择一条要删除的数据！");
                return;
            }
            var selBlogIDs = [];
            for (var i = 0; i < selBlogs.length; i++) {
                selBlogIDs.push(selBlogs[i].id);
            }
            var ids = selBlogIDs.join(",");
            $.messager.confirm("系统提示", "是否确认删除选择的<font color='red'>" + selBlogs.length + "</font>条数据？", function (r) {
                if (r) {
                    $.post("${pageContext.request.contextPath}/admin/blog/delBlogById.do", {ids: ids}, function (result) {
                        if (result.success) {
                            $.messager.alert("系统提示", "删除成功！")
                        } else {
                            $.messager.alert("系统提示", "删除失败！")
                        }
                        $("#dg").datagrid("reload");
                    }, "json");
                }
            });
        }

        /*点击标题，弹出用户预览界面*/
        function showBlogInfo(val, row) {
            return "<a target='_blank' href='${pageContext.request.contextPath}/blog/" + row.id + ".html'>" + val + "</a>"
        }

        /*修改发布状态：撤销发布和发布*/
        function changeStatus(val) {
            if (val != 1 && val != 2) {
                $.messager.alert("系统提示", "触发异常操作！");
                return;
            }
            let selBlogs = $("#dg").datagrid("getSelections");
            if (selBlogs.length <= 0) {
                if (val == 1)
                    $.messager.alert("系统提示", "请至少选择一条要发布的数据！");
                else if (val == 2)
                    $.messager.alert("系统提示", "请至少选择一条要撤销发布的数据！");
                return;
            }
            for (var i = 0; i < selBlogs.length; i++) {
                //todo:要校验发布/撤销发布的数据都是可进行操作的
                if (val == 1) {//进行发布操作（未发布的和已撤销发布的可同时操作）
                    if (selBlogs[i].status == 1) {
                        $.messager.alert("系统提示", "选择的数据包含已发布的，请检查后重新操作！");
                        return;
                    }
                } else if (val == 2) {//进行撤销发布操作(只可以操作已发布的)
                    if (selBlogs[i].status != 1) {
                        $.messager.alert("系统提示", "只能选择已发布的数据进行撤销发布，请检查后重新操作！");
                        return;
                    }
                }
            }
            let selBlogIDs = [];
            for (let i = 0; i < selBlogs.length; i++) {
                selBlogIDs.push(selBlogs[i].id);
            }
            var ids = selBlogIDs.join(",");
            $.post("${pageContext.request.contextPath}/admin/blog/changeStatusById.do", {
                ids: ids,
                status: val
            }, function (result) {
                if (result.success) {
                    $.messager.alert("系统提示", "操作成功！")
                } else {
                    $.messager.alert("系统提示", "操作失败！")
                }
                $("#dg").datagrid("reload");
            }, "json");
        }

    </script>
    <style type="text/css">

    </style>
</head>
<body>
<div style="width: 100%;height: 100%;">
    <table id="dg" title="博客类别" class="easyui-datagrid" fitcolumns="true" pagination="true" rownumbers="true"
           url="${pageContext.request.contextPath}/admin/blog/list.do" fit="true" toolbar="#tb">
        <thead>
        <tr>
            <th field="cb" checkbox="true" align="center"></th>
            <th field="id" width="50" align="center">编号</th>
            <th field="title" width="250" align="center" formatter="javascript:showBlogInfo">标题</th>
            <th field="summary" width="400" align="center">摘要</th>
            <th field="blogType" width="100" align="center" formatter="javascript:formatBlogType">博客类型</th>
            <th field="blogger" width="100" align="center" formatter="javascript:formatBlogger">所属博主</th>
            <th field="releaseDate" width="100" align="center">创建日期</th>
            <th field="modifyDate" width="100" align="center">最近修改日期</th>
            <th field="keyWord" width="200" align="center">关键字</th>
            <th field="clickHit" width="100" align="center">访问量</th>
            <th field="replyHit" width="100" align="center">评论数</th>
            <th field="status" width="100" align="center" formatter="javascript:formatBlogStatus">博客状态</th>
        </tr>
        </thead>
    </table>

    <div id="tb">
        <div style="float: left;">
            <a href="javascript:openBlogModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit"
               plain="true">编辑</a>
            <a href="javascript:changeStatus(1)" class="easyui-linkbutton" iconCls="icon-remove"
               plain="true">发布</a>
            <a href="javascript:changeStatus(2)" class="easyui-linkbutton" iconCls="icon-remove"
               plain="true">撤销发布</a>
            <a href="javascript:deleteBlog()" class="easyui-linkbutton" iconCls="icon-remove"
               plain="true">删除</a>
        </div>
        <div style="float: right;padding-right: 5%">
            &nbsp;标题： &nbsp;<input type="text" id="s_title" size="20" onkeydown="if(event.keyCode==13)searchBlog()"/>
            <a href="javascript:searchBlog()"
               class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
        </div>
        <div style="clear: both"></div>
    </div>
</div>
</body>
</html>
