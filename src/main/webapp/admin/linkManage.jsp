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
    <title>友情链接信息管理</title>
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
        function openLinkAddDialog() {
            $("#dlg").dialog("open").dialog("setTitle", "添加友情链接");
            url = "${pageContext.request.contextPath}/admin/link/save.do";
        }

        /*打开博客类别修改界面*/
        function openLinkModifyDialog() {

            var selectRows = $("#dg").datagrid("getSelections");
            if (selectRows.length != 1) {
                $.messager.alert("系统提示", "请选择一条要编辑的数据");
                return;
            } else {
                var selectRow = selectRows[0];
                $("#dlg").dialog("open").dialog("setTitle", "编辑博客类别");
                url = "${pageContext.request.contextPath}/admin/link/save.do?id=" + selectRow.id;
                $("#form_addLink").form("load", selectRow);
            }
        }

        /*删除博客类别信息*/
        function deleteLink() {
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
                    $.post("${pageContext.request.contextPath}/admin/link/remove.do", {ids: ids}, function (result) {
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
        function saveLink() {
            $("#form_addLink").form("submit", {
                url: url,
                onsubmit: function () {
                    return $(this).form("validate");
                },
                success: function (result) {
                    var result = eval('(' + result + ')');
                    if (result.success) {
                        $.messager.alert("系统提示", "保存成功！");
                        resetValue();
                        $("#dlg").dialog("close");
                        $("#dg").datagrid("reload");
                    } else {
                        $.messager.alert("系统提示", "保存失败！");
                        return;
                    }
                }
            });
        }

        /*重置弹出的对话框*/
        function resetValue() {
            $("#linkName").val("");
            $("#linkUrl").val("");
            $("#orderNo").val("");
        }

        /*关闭添加弹出对话框*/
        function closeLinkDialog() {
            $("#dlg").dialog("close");
            resetValue();
        }
    </script>
</head>
<body>
<div style="width: 100%;height: 100%;">

    <table id="dg" title="友情链接" class="easyui-datagrid" fitcolumns="true" pagination="true" rownumbers="true"
           url="${pageContext.request.contextPath}/admin/link/list.do" fit="true" toolbar="#tb">
        <thead>
        <tr>
            <th field="cb" checkbox="true" align="center"></th>
            <th field="id" width="0" align="center" hidden="hidden">主键</th>
            <th field="orderNo" width="100" align="center">序号</th>
            <th field="linkName" width="300" align="center">网站名称</th>
            <th field="linkUrl" width="300" align="center">网址</th>
        </tr>
        </thead>
    </table>

    <div id="tb">
        <a href="javascript:openLinkAddDialog()" class="easyui-linkbutton" iconCls="icon-add"
           plain="true">添加</a>
        <a href="javascript:openLinkModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit"
           plain="true">编辑</a>
        <a href="javascript:deleteLink()" class="easyui-linkbutton" iconCls="icon-remove"
           plain="true">删除</a>
    </div>

    <div id="dlg" class="easyui-dialog" title="添加友情链接" data-options="iconCls:'icon-save'"
         style="width:500px;height:300px;padding:10px 20px" closed="true" buttons="#dlg-buttons" modal="true">
        <form id="form_addLink" method="post">
            <table cellpadding="8px" style="font-size: xx-small;align-content: center">
                <tr>
                    <td>网站名称：</td>
                    <td>
                        <input type="text" id="linkName" name="linkName" class="easyui-validatebox"
                               style="width: 250px"
                               required="true"
                               placeholder="请输入网站名称...">
                    </td>
                </tr>
                <tr>
                    <td>网址：</td>
                    <td>
                        <input type="text" id="linkUrl" name="linkUrl" class="easyui-validatebox"
                               style="width: 250px"
                               required="true"
                               placeholder="请输入网址...">
                    </td>
                </tr>
                <tr>
                    <td>序号：</td>
                    <td>
                        <input type="number" min="1" id="orderNo" name="orderNo" class="easyui-validatebox"
                               style="width: 60px" value="0"
                               required="true"/>(序号作为显示顺序：从小到大)
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <div id="dlg-buttons">
        <a href="javascript:saveLink()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
        <a href="javascript:closeLinkDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
    </div>

</div>
</body>
</html>
