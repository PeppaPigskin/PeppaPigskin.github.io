<%--
  Created by IntelliJ IDEA.
  User: WuChen
  Date: 2020/09/17
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <title>博客类别信息管理</title>
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

        /*打开添加博客类别弹出窗*/
        function openBlogTypeAddDialog() {
            $("#dlg").dialog("open").dialog("setTitle", "添加博客类别");
            url = "${pageContext.request.contextPath}/admin/blogType/saveBlogType.do";
        }

        /*打开博客类别修改界面*/
        function openBlogTypeModifyDialog() {

            var selectRows = $("#dg").datagrid("getSelections");
            if (selectRows.length != 1) {
                $.messager.alert("系统提示", "请选择一条要编辑的数据");
                return;
            } else {
                var selectRow = selectRows[0];
                $("#dlg").dialog("open").dialog("setTitle", "编辑博客类别");
                url = "${pageContext.request.contextPath}/admin/blogType/saveBlogType.do?id=" + selectRow.id;
                $("#form_addBlogType").form("load", selectRow);
            }
        }

        /*删除博客类别信息*/
        function deleteBlogType() {
            var selectRows = $("#dg").datagrid("getSelections");
            if (selectRows.length == 0) {
                $.messager.alert("系统提示", "至少选择一条要删除数据！")
                return;
            }
            var selIds = [];
            for (var i = 0; i < selectRows.length; i++) {
                selIds.push(selectRows[i].id);
            }
            var ids = selIds.join(",");
            $.messager.confirm("系统提示", "是否确认删除选择的<font color='red'>" + selectRows.length + "</font>条数据？", function (r) {
                if (r) {
                    $.post("${pageContext.request.contextPath}/admin/blogType/deleteBlogType.do", {ids: ids}, function (result) {
                        if (result.success) {
                            if (result.message) {
                                $.messager.alert("系统提示", result.message)
                            } else {
                                $.messager.alert("系统提示", "删除成功！")
                            }
                        } else {
                            if (result.message) {
                                $.messager.alert("系统提示", result.message)
                            } else {
                                $.messager.alert("系统提示", "删除失败！")
                            }
                        }
                        $("#dg").datagrid("reload");
                    }, "json");
                }
            });
        }

        /*保存博客类型信息*/
        function saveBlogType() {
            $("#form_addBlogType").form("submit", {
                url: url,
                onSubmit: function () {
                    return $(this).form("validate");
                },
                success: function (result) {
                    var result = eval('(' + result + ')');
                    if (result.success) {
                        $.messager.alert("系统提示", "保存成功！");
                        resetValue();
                        $("#dlg").dialog("close");
                        $("#dg").datagrid("reload");
                        refreshSystemResource();
                    } else {
                        $.messager.alert("系统提示", "保存失败！");
                        return;
                    }
                }
            });
        }

        /*刷新系统资源*/
        function refreshSystemResource() {
            $.post("${pageContext.request.contextPath}/admin/systemManager/refreshSystemResource.do", {}, function (result) {
                if (!result.success) {
                    $.messager.alert("系统提示", "刷新系统缓存失败！")
                }
            }, "json");
        }

        /*重置弹出的对话框*/
        function resetValue() {
            $("#typeName").val("");
            $("#orderNo").val("");
        }

        /*关闭添加弹出对话框*/
        function closeBlogTypeDialog() {
            $("#dlg").dialog("close");
            resetValue();
        }
    </script>
</head>
<body>
<div style="width: 100%;height: 100%;">

    <table id="dg" title="博客类别" class="easyui-datagrid" fitcolumns="true" pagination="true" rownumbers="true"
           url="${pageContext.request.contextPath}/admin/blogType/list.do" fit="true" toolbar="#tb">
        <thead>
        <tr>
            <th field="cb" checkbox="true" align="center"></th>
            <th field="id" width="100" align="center">编号</th>
            <th field="typeName" width="300" align="center">博客类型名</th>
            <th field="orderNo" width="300" align="center">排序编号</th>
        </tr>
        </thead>
    </table>

    <div id="tb">
        <a href="javascript:openBlogTypeAddDialog()" class="easyui-linkbutton" iconCls="icon-add"
           plain="true">添加</a>
        <a href="javascript:openBlogTypeModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit"
           plain="true">编辑</a>
        <a href="javascript:deleteBlogType()" class="easyui-linkbutton" iconCls="icon-remove"
           plain="true">删除</a>
    </div>

    <div id="dlg" class="easyui-dialog" title="添加博客类别" data-options="iconCls:'icon-save'"
         style="width:500px;height:200px;padding:10px 20px" closed="true" buttons="#dlg-buttons" modal="true">
        <form id="form_addBlogType" method="post">
            <table cellpadding="8px" style="font-size: xx-small;align-content: center">
                <tr>
                    <td>类别名称：</td>
                    <td>
                        <input type="text" id="typeName" name="typeName" class="easyui-validatebox"
                               style="width: 250px"
                               required="true"
                               placeholder="请输入类别名称...">
                    </td>
                </tr>
                <tr>
                    <td>类别排序：</td>
                    <td>
                        <input type="number" min="1" id="orderNo" name="orderNo" class="easyui-validatebox"
                               style="width: 60px"
                               required="true"/>(类别排序作为显示顺序：从小到大)
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <div id="dlg-buttons">
        <a href="javascript:saveBlogType()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
        <a href="javascript:closeBlogTypeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
    </div>

</div>
</body>
</html>
