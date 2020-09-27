<%@ page import="com.wcc.util.ConstantsUtil" %><%--
  Created by IntelliJ IDEA.
  User: WuChen
  Date: 2020/09/18
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>评论信息管理</title>
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

    <style type="text/css">

    </style>

    <script type="text/javascript">
        /**
         * 返回改行数据博客标题名（编号）
         */
        function formatBlog(val, row) {
            return val.title + "(" + val.id + ")";
        }

        /*删除选择的评论*/
        function delComment() {
            var selComs = $("#dg").datagrid("getSelections");
            if (selComs.length == 0) {
                $.messager.alert("系统提示", "至少选择一条要删除的数据！");
                return;
            }
            var comIds = [];
            for (var i = 0; i < selComs.length; i++) {
                comIds.push(selComs[i].id);
            }
            var idStr = comIds.join(",");
            $.post("${pageContext.request.contextPath}/admin/comment/delComment.do", {idStr: idStr}, function (result) {
                if (result.success) {
                    $.messager.alert("系统提示", "删除成功！")
                } else {
                    $.messager.alert("系统提示", "删除失败！")
                }
                $("#dg").datagrid("reload");
            }, "json");

        }

        /*审核评论-修改评论的审核状态*/
        function reviewComment() {
            var selComs = $("#dg").datagrid("getSelections");
            if (selComs.length == 0) {
                $.messager.alert("系统提示", "至少选择一条要修改状态的数据！");
                return;
            }
            /*用于存储被审核的评论主键*/
            var comIds = [];
            var state = null;
            var sensitives = [];
            for (var i = 0; i < selComs.length; i++) {
                if (i == 0) {
                    state = selComs[0].state;
                } else {
                    if (selComs[i].state !== state) {
                        $.messager.alert("系统提示", "请选择当前审核状态相同的数据,进行统一审核操作！");
                        return;
                    }
                }
                comIds.push(selComs[i].id);
                var swStr = selComs[i].sensitiveWord.split(/[,，]/);
                for (var j = 0; j < swStr.length; j++) {
                    /*TODO：使用Jquery中的inArray判断某个项是否包含在数组中*/
                    if ("" != swStr[j] && $.inArray(swStr[j], sensitives) <= 0) {
                        sensitives.push(swStr[j]);
                    }
                }
            }
            $("#dlg").dialog("open").dialog("setTitle", "评论状态审核");
            var obj = {"modifyCommentIds": comIds.join(","), "state": state, "sensitiveWord": sensitives.join(",")};
            $("#form_modifyCommentState").form("load", obj);
        }

        /*修改评论状态*/
        function saveReview() {
            $("#form_modifyCommentState").form("submit", {
                url: "${pageContext.request.contextPath}/admin/comment/saveReview.do",
                onsubmit: function () {
                    return $(this).form("validate");
                },
                success: function (result) {
                    var result = eval('(' + result + ')');
                    if (result.success) {
                        $.messager.alert("系统提示", "保存成功！");
                        $("#dlg").dialog("close");
                    } else {
                        $.messager.alert("系统提示", "保存失败！");
                        return;
                    }
                    $("#dg").datagrid("reload");
                }
            });
        }

        /*关闭修改评论状态窗口*/
        function closeReviewDialog() {
            $("#dlg").dialog("close");
        }

    </script>
</head>
<body>
<div style="width: 100%;height: 100%;">

    <table id="dg" title="博客类别" class="easyui-datagrid" fitcolumns="true" pagination="true" rownumbers="true"
           url="${pageContext.request.contextPath}/admin/comment/list.do" fit="true" toolbar="#tb">
        <thead>
        <tr>
            <th field="cb" checkbox="true" align="center"></th>
            <th field="id" width="50" align="center">编号</th>
            <th field="userIp" width="100" align="center">评论者IP</th>
            <th field="blog" width="200" align="center" formatter="javascript:formatBlog">对应博客标题（编号）</th>
            <th field="content" width="300" align="center">评论内容</th>
            <th field="commentDate" width="150" align="center">评论日期</th>
            <th field="stateStr" width="100" align="center">审核状态</th>
            <th field="sensitiveWord" width="200" align="center">敏感词汇</th>
        </tr>
        </thead>
    </table>

    <div id="tb">
        <div style="float: left">
            <a href="javascript:reviewComment()" class="easyui-linkbutton" iconCls="icon-edit"
               plain="true">审核评论</a>
            <a href="javascript:delComment()" class="easyui-linkbutton" iconCls="icon-remove"
               plain="true">删除评论</a>
        </div>
        <%--上边有浮动，不清除会导致分页部分显示不出来--%>
        <div style="clear: both"></div>
    </div>

    <div id="dlg" class="easyui-dialog" title="状态审核及敏感词汇设置" data-options="iconCls:'icon-save'"
         style="width:600px;height:300px;padding:40px 20px;" closed="true" buttons="#dlg-buttons" modal="true">
        <form id="form_modifyCommentState" method="post">
            <input type="hidden" name="modifyCommentIds"/>
            <label>设置需过滤敏感词汇：</label>
            <div style="margin-bottom:20px;padding-left: 20px;padding-top: 20px">
                <input type="text" id="sensitiveWord" name="sensitiveWord" class="easyui-validatebox"
                       style="width: 50%"/>(多个使用【，】分割)
            </div>
            <label>设置新审核状态：</label>
            <div style="margin-bottom:20px;padding-left: 20px;padding-top: 20px">
                <input type="radio" name="state"
                       value="<%=ConstantsUtil.CommentStateEnum.COMMENT_STATE_PENDING%>" checked="true"/>
                <%=ConstantsUtil.CommentStateEnum.COMMENT_STATE_PENDING.getDesc()%>

                <input type="radio" name="state"
                       value="<%=ConstantsUtil.CommentStateEnum.COMMENT_STATE_REVIEW_PASSED%>"/>
                <%=ConstantsUtil.CommentStateEnum.COMMENT_STATE_REVIEW_PASSED.getDesc()%>

                <input type="radio" name="state"
                       value="<%=ConstantsUtil.CommentStateEnum.COMMENT_STATE_AUDIT_FAILED%>"/>
                <%=ConstantsUtil.CommentStateEnum.COMMENT_STATE_AUDIT_FAILED.getDesc()%>
            </div>
        </form>
    </div>

    <div id="dlg-buttons">
        <a href="javascript:saveReview()" class="easyui-linkbutton" iconCls="icon-ok">确认</a>
        <a href="javascript:closeReviewDialog()" class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
    </div>

</div>
</body>
</html>
