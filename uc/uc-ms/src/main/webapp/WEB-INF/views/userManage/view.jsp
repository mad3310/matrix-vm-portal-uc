<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../common/include.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>用户管理</title>
    <script type="text/javascript">
        $(function () {
            $('#dgd_result').datagrid({
                onSelect: function (rowIndex, rowData) {
                    $('#btn_delete').linkbutton('enable');
                    $('#btn_edit').linkbutton('enable');
                }
            });
        });


        // 搜索
        function reSearch() {
            // 重新加载数据
            $('#dgd_result').datagrid('load', {
                serverIp: $('#s_userId').val(),
                usedCapacity: $('#s_mobile').val(),
                totalCapacity: $('#s_mail').val(),
                status: $('#s_qualityStatus').combobox('getValue')
            });
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
                        url: '<%=basePath%>/uc/transcodeServer/dele?serverIp=' + row.serverIp,
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
    <table width="100%" border="0" cellpadding="3">
        <tr>
            <td>
                用户ID:
                <input name="q_id" id="q_id" class="input_normal easyui-numberbox"/>
                用户名称:
                <input name="q_contacts" id="q_contacts" class="input_normal"/>
                用户类型:
                <select id="q_usertype" name="q_usertype" class="easyui-combobox"
                        data-options="editable:false,panelHeight:'auto'">
                    <option value="" selected="selected">全部</option>
                    <option value="2">个人会员</option>
                    <option value="3">企业会员</option>
                    <option value="4">一级代理</option>
                    <option value="5">二级代理</option>
                    <option value="6">大客户</option>
                    <option value="7">代理商用户</option>
                </select>
                手机号:
                <input name="q_mobile" id="q_mobile" class="input_normal easyui-numberbox"/>
                邮箱:
                <input name="q_email" id="q_email" class="input_normal"/>
            </td>
        </tr>
        <tr>
            <td>
                资质状态:
                <select id="q_examinestatus" name="q_examinestatus" class="easyui-combobox"
                        data-options="editable:false,panelHeight:'auto'">
                    <option value="" selected="selected">全部</option>
                    <option value="2">待审核</option>
                    <option value="0">审核未通过</option>
                    <option value="1">审核通过</option>
                </select>
                用户状态:
                <select id="q_userstatus" name="q_userstatus" class="easyui-combobox"
                        data-options="editable:false,panelHeight:'auto'">
                    <option value="">全部</option>
                    <option value="1" selected="selected">正常</option>
                    <option value="2">禁用</option>
                    <option value="0">删除</option>
                </select>
                企业名称:
                <input name="q_enterprisename" id="q_enterprisename" class="input_normal"/>
                注册时间:
                <input id="q_starttime"
                       name="q_starttime"
                       class="date-select-day6"
                       required="true" type="text"/>
                -
                <input id="q_endtime" name="q_endtime"
                       class="date-select-day6"
                       required="true" type="text"/>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="right">
                <a href="javascript:void(0)" class="easyui-linkbutton" id="search"
                   data-options="iconCls:'icon-search'">搜索</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" id="reset"
                   data-options="iconCls:'icon-reset'">重置</a>
            </td>
        </tr>
    </table>
</div>
<table id="list_table" class="easyui-datagrid" title="用户列表" style="height:400px"
       rownumbers="true" pagination="true"></table>

<div style="display:none;">
    <!-- 配置项编辑页面 -->
    <div id="dlg_editInfo" class="easyui-dialog" title="编辑" style="width:800px;height:250px;padding:0px;top:5px"
         data-options="closed:true,modal:true,shadow:true,buttons:'#tb2'">
        <form id="ucUserInfoEditForm" method="post">
            <table width="100%" border="0" cellpadding="0" cellspacing="2">
                <tr>
                    <td class="item_name">用户类型:</td>
                    <td class="item_name">邮箱:</td>
                    <td class="item_name">用户名称:</td>
                    <td class="item_name">手机号:</td>
                    <td class="item_name">用户类型:</td>
                    <td class="item_name">用户类型:</td>
                    <td class="item_value">
                        <select id="usertype" name="usertype" class="easyui-combobox"
                                data-options="editable:false,panelHeight:'auto'">
                            <option value="" selected="selected">全部</option>
                            <option value="2">个人会员</option>
                            <option value="3">企业会员</option>
                            <option value="4">一级代理</option>
                            <option value="5">二级代理</option>
                            <option value="6">大客户</option>
                            <option value="7">代理商用户</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="item_name">用户ID:</td>
                    <td class="item_value">
                        <input name="id" id="id" class="input_normal easyui-numberbox"/>
                    </td>

                </tr>
                <tr>
                    <td class="item_name">



                    <input name="email" id="email" class="input_normal"/>
                </tr>
                    用户名称:
                    <input name="contacts" id="contacts" class="input_normal"/>
                    </td>
                    <td>
                        手机号:
                        <input name="mobile" id="mobile" class="input_normal easyui-numberbox"/>
                        注册时间:
                        <input name="createdtime" readonly="readonly" id="createdtime" class="input_long"/>
                        <span class="txt">网站类型：</span>
                        <select name="sitetype" id="sitetype" class="easyui-combobox"
                                data-options="editable:false,panelHeight:'auto'" readonly="readonly">
                            <option value="3">综合门户</option>
                            <option value="9">搜索引擎</option>
                            <option value="7">网络游戏</option>
                            <option value="10">动漫网站</option>
                            <option value="11">亲子&amp;育婴</option>
                            <option value="4">网络购物</option>
                            <option value="2">教育培训</option>
                            <option value="12">视频网站</option>
                            <option value="5">企业网站</option>
                            <option value="13">网站导航</option>
                            <option value="14">新闻资讯</option>
                            <option value="15">SNS&amp;社区</option>
                            <option value="16">生活网站</option>
                            <option value="17">金融&amp;财经</option>
                            <option value="18">IT科技</option>
                            <option value="19">汽车网站</option>
                            <option value="20">影视&amp;娱乐</option>
                            <option value="21">分类信息</option>
                            <option value="22">时尚杂志</option>
                            <option value="23">旅游订票</option>
                            <option value="24">广播电视</option>
                            <option value="1">文化传媒</option>
                            <option value="25">军事网站</option>
                            <option value="26">健康网站</option>
                            <option value="27">音乐网站</option>
                            <option value="28">房产网站</option>
                            <option value="29">体育网站</option>
                            <option value="8">其他网站</option>
                        </select>
                        <span class="txt">企业名称：</span>
                        <input name="enterprisename" readonly="readonly" id="enterprisename" class="input_long"/>
                    </td>
                    <td>

                        <span class="txt">网站域名：</span>
                        <input name="sitedomain" readonly="readonly" id="sitedomain" class="input_long"/>

                        <span class="txt">&nbsp;&nbsp;&nbsp;&nbsp;资质状态：</span>
                        <select id="examinestatus" name="examinestatus" readonly="readonly" class="easyui-combobox"
                                data-options="editable:false,panelHeight:'auto'">
                            <option value="2">待审核</option>
                            <option value="0">审核未通过</option>
                            <option value="1">审核通过</option>
                        </select>

                        <span class="txt">用户状态：</span>
                        <select id="userstatus" name="userstatus" class="easyui-combobox" readonly="readonly"
                                data-options="editable:false,panelHeight:'auto'">
                            <option value="1">正常</option>
                            <option value="2">禁用</option>
                            <option value="0">删除</option>
                        </select>
                        <span class="txt">身份证：</span>
                        <input name="idcard" readonly="true" id="idcard" class="input_long"/>
                    </td>
                    <td>
                        <span class="txt">手机号国家码：</span>
                        <input name="countrycode" readonly="readonly" id="countrycode" class="input_long"/>
                        <span class="txt">&nbsp;详细地址：</span>
                        <input name="address" readonly="true" id="address" class="input_long"/>
                        <span class="txt">组织机构代码：</span>
                        <input name="organizationcode" readonly="true" id="organizationcode" class="input_long"/>
                        <span class="txt">营业执照注册号：</span>
                        <input name="businesslicenseregisternum" id="businesslicenseregisternum" class="input_long"/>
                    </td>
                </tr>
            </table>
            <div id="tb2">
                <a id="btn_saveTranscodeServer" href="javascript:void(0)" class="easyui-linkbutton"
                   onclick="saveTranscodeServer()"
                   data-options="iconCls:'icon-save'">保存</a>
                <a href="javascript:void(0)" class="easyui-linkbutton"
                   onClick="$('#dlg_editInfo').dialog('close');"
                   data-options="iconCls:'icon-cancel'">取消</a>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript" src="${basePath}/scripts/userManage/ucUserInfoQuery.js"></script>
</body>
</html>