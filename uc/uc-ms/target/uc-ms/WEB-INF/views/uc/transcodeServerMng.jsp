<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../common/include.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>转码机配置信息管理</title>
    <script type="text/javascript">
        $(function () {
            $('#dgd_result').datagrid({
                onSelect: function (rowIndex, rowData) {
                    $('#btn_delete').linkbutton('enable');
                    $('#btn_edit').linkbutton('enable');
                }
            });
        });

        //工具条
        var toolbar = [
            {
                id: 'btn_edit',
                text: '编辑',
                disabled: true,
                iconCls: 'icon-edit',
                handler: function () {
                    open4Edit()
                }
            }, {
                id: 'btn_add',
                text: '添加',
                iconCls: 'icon-add',
                handler: function () {
                    open4Add();
                }
            }, {
                id: 'btn_delete',
                text: '删除',
                disabled: true,
                iconCls: 'icon-remove',
                handler: function () {
                    deleteTranscodeServer()
                }
            }];

        // 搜索
        function reSearch() {
            // 重新加载数据
            $('#dgd_result').datagrid('load', {
                serverIp: $('#condition_serverIp').val(),
                usedCapacity: $('#condition_usedCapacity').val(),
                totalCapacity: $('#condition_totalCapacity').val(),
                status: $('#condition_status').combobox('getValue')
            });
        }

        // 添加
        function open4Add() {
            $('#frm_transcodeServer').form('clear');
            $('#dlg_transcodeServer').dialog('open');
        }

        // 删除
        function deleteTranscodeServer() {
            var row = $("#dgd_result").datagrid("getSelected");
            if (!row) {
                $.messager.alert("提示", "请至少选择一行！", "error");
                return;
            }
            $.messager.confirm('确认', '是否要删除转码机配置', function (r) {
                if (r) {
                    $.ajax({
                        url: '<%=basePath%>uc/transcodeServer/dele?serverIp=' + row.serverIp,
                        type: 'DELETE',
                        success: function (data) {
                            if (data) {
                                $.messager.alert("提示", data.errorMessage, "error");
                                return;
                            }
                            $('#dgd_result').datagrid("reload");
                        },
                        error: function () {
                            $.messager.alert("提示", "session过期,请刷新页面重试!", "info");
                        }
                    });
                }
            });
        }

        // 编辑
        function open4Edit(rowIndex, rowData) {
            var id;
            if (rowData) {
                id = rowData.serverIp;
            } else {
                var row = $("#dgd_result").datagrid("getSelected");
                if (!row) {
                    $.messager.alert("提示", "请至少选择一行！", "error");
                    return;
                }
                id = row.serverIp;
            }
            $('#frm_transcodeServer').form('clear');
            $('#dlg_transcodeServer').dialog('open');
            $('#frm_transcodeServer #serverIp').attr("readonly", "readonly");
            $('#frm_transcodeServer #serverIp').addClass("readonly");
            $('#frm_transcodeServer').form('load', '<%=basePath%>uc/transcodeServer/getByIp?serverIp=' + id);
        }

        // 保存
        function saveTranscodeServer() {
            $.messager.progress();
            $('#frm_transcodeServer').form('submit', {
                url: '<%=basePath%>uc/transcodeServer/saveOrUpdate',
                onSubmit: function (param) {
                    var serverIp = $("#serverIp").val();
                    if (!ipvalidate(serverIp)) {
                        $.messager.alert("提示", "转码机IP不合法", "warning");
                        $.messager.progress('close');
                        return false;
                    }
                    var totalCapacity = $("#totalCapacity").val();
                    if (isNaN(totalCapacity)) {
                        $.messager.alert("提示", "总转码能力为整数", "warning");
                        $.messager.progress('close');
                        return false;
                    }
                    var isValid = $(this).form('validate');
                    if (!isValid) {
                        $.messager.progress('close');
                        return false;
                    }
                    return true;
                },
                success: function (data) {
                    $.messager.progress('close');
                    if (data) {
                        var result = eval('(' + data + ')');
                        $.messager.alert("提示", result.errorMessage, "error");
                        return;
                    }
                    $('#dgd_result').datagrid("reload");
                    $('#dlg_transcodeServer').dialog('close');
                },
                error: function () {
                    $.messager.alert("提示", "session过期,请刷新页面重试!", "info");
                }
            });
        }

        function reset() {
            $('#searchCondtion input').val("");
        }

        function ipvalidate(ip) {
            var val = /([0-9]{1,3}\.{1}){3}[0-9]{1,3}/;
            var vald = val.exec(ip);
            if (vald == null) {
                return false;
            }
            if (vald != '') {
                if (vald[0] != ip) {
                    return false;
                }
            }
            return true;

        }

        function formatStatusVal(val, row) {
            var resurlt = "";
            if (val == 1) {
                resurlt = "启用";
            }
            if (val == '0') {
                resurlt = "禁用";
            }
            return resurlt;
        }

    </script>
</head>
<body>
<div id="searchCondtion" class="easyui-panel ms-panel-outer" title="查询条件" data-options="collapsible:true">
    <table width="100%" border="0" cellpadding="3" cellspacing="2">
        <tr>
            <td class="item_name">转码机IP</td>
            <td class="item_value">
                <input id="condition_serverIp" name="condition_serverIp" class="easyui-validatebox normaltext"/>
            </td>
            <td class="item_name">状态</td>
            <td class="item_value">
                <select class="easyui-combobox easyui-validatebox normaltext" id="condition_status"
                        name="condition_status"
                        data-options="panelHeight:'auto',required:true,editable: false">
                    <option></option>
                    <option value=1>启用</option>
                    <option value=0>禁用</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="item_name">已使用能力</td>
            <td class="item_value">
                <input id="condition_usedCapacity" name="condition_usedCapacity"
                       class="easyui-validatebox normaltext"/>
            </td>
            <td class="item_name">总转码能力</td>
            <td class="item_value">
                <input id="condition_totalCapacity" name="condition_totalCapacity"
                       class="easyui-validatebox normaltext"/>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="right">
                <a href="javascript:void(0)" class="easyui-linkbutton" onClick="reSearch()"
                   data-options="iconCls:'icon-search'">搜索</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" onClick="reset()"
                   data-options="iconCls:'icon-reset'">重置</a>
            </td>
        </tr>
    </table>
</div>

<table id="dgd_result" class="easyui-datagrid" title="产品列表" style="height:400px"
       rownumbers="true" pagination="true"
       data-options="singleSelect:true,method:'get',toolbar:toolbar,url:'<%=basePath%>uc/transcodeServer/search',onDblClickRow:open4Edit">
    <thead>
    <tr>
        <th field="serverIp" width="150">转码机IP</th>
        <th field="usedCapacity" width="150">已使用能力</th>
        <th field="totalCapacity" width="200">总转码能力</th>
        <th field="version" width="200">版本</th>
        <th field="status" width="200" formatter="formatStatusVal">状态</th>
    </tr>
    </thead>
</table>
</body>
</html>
<!-- Dialogs -->
<div style="display:none;">
    <!-- 配置项编辑页面 -->
    <div id="dlg_transcodeServer" class="easyui-dialog" title="编辑" style="width:800px;height:250px;padding:0px;top:5px"
         data-options="closed:true,modal:true,shadow:true,buttons:'#tb2'">
        <form id="frm_transcodeServer" method="post">
            <table width="100%" border="0" cellpadding="0" cellspacing="2">
                <tr>
                    <td class="item_name">转码机IP</td>
                    <td class="item_value">
                        <input id="serverIp" name="serverIp" class="easyui-validatebox normaltext"
                               data-options="required:true"/>
                    </td>
                    <td class="item_name">已使用能力</td>
                    <td class="item_value">
                        <input id="usedCapacity" name="usedCapacity" class="easyui-validatebox normaltext"/>
                    </td>
                </tr>
                <tr>
                    <td class="item_name">总转码能力</td>
                    <td class="item_value">
                        <input id="totalCapacity" name="totalCapacity" class="easyui-validatebox normaltext"
                               data-options="required:true"/>
                    </td>
                    <td class="item_name">状态</td>
                    <td class="item_value">
                        <select class="easyui-combobox easyui-validatebox normaltext" id="status"
                                name="status"
                                data-options="panelHeight:'auto',required:true,editable: false">
                            <option value=1>启用</option>
                            <option value=0>禁用</option>
                        </select>
                    </td>
                </tr>
            </table>
            <div id="tb2">
                <a id="btn_saveTranscodeServer" href="javascript:void(0)" class="easyui-linkbutton"
                   onclick="saveTranscodeServer()"
                   data-options="iconCls:'icon-save'">保存</a>
                <a href="javascript:void(0)" class="easyui-linkbutton"
                   onClick="$('#dlg_transcodeServer').dialog('close');"
                   data-options="iconCls:'icon-cancel'">取消</a>
            </div>
        </form>
    </div>
</div>