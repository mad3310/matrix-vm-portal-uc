<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + (request.getServerPort() == 80 ? "" : ":" + request.getServerPort())
            + path + "/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>用户中心</title>
    <link href="<%=basePath%>/resources/script/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath%>/resources/script/easyui/themes/icon.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath%>/resources/style/custom-easyui.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath%>/resources/style/subform.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath%>/resources/style/index.css" rel="stylesheet" type="text/css"/>

    <script src="<%=basePath%>/resources/script/easyui/jquery.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>/resources/script/easyui/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>/resources/script/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="<%=basePath%>/resources/script/index.js" type="text/javascript"></script>
    <script src="<%=basePath%>/resources/script/subform.js" type="text/javascript"></script>
    <style type="text/css">
        body {
            background-color: #fff;
            color: #000;
            font-size: 12px;
            font-family: "宋体", arial, Times, serif;
            line-height: 1.25;
            margin: 0;
            padding: 0;
            height: 100%;
            word-break: break-all;
        }
    </style>
    <script type="text/javascript">
        var curMenuTree;

        $(function () {
            createMenuTree($('#uc_ms'), '<%=basePath%>/framework/menus?sysId=uc_ms');
        });

    </script>
</head>
<body class="easyui-layout" style="width:100%">
<div region="north" border="false" style="height:35px">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="header_box">
        <tr>
            <td class="header_left">
                    <span class="color1">
                            <img src="<%=basePath%>/resources/images/letv_logo.png"/>&nbsp;
                        工单运营管理系统
                    </span>
            </td>
            <td align="left">

            </td>
            <td class="header_right">
                尊敬的
                <label class="strong" style="font-size:larger;">${userId}</label>&nbsp;您好！
                <span class="color1">
	                <a id="btn_close_all" href="javascript:void(0);" title="关闭所有tab页" class="link1">
                        <img src="<%=basePath%>/resources/images/close_all.png" class="icon" title="关闭所有tab页"/>关闭所有
                    </a>
                </span>
                <span class="color1">
	                <a id="btn_close_other" href="javascript:void(0);" title="关闭当前以外的tab页" class="link1">
                        <img src="<%=basePath%>/resources/images/close_other.png" class="icon" title="关闭当前以外的tab页"/>关闭其它
                    </a>
                </span>
                <span class="color1">
                    <a id="btn_log_out" href="<%=basePath%>/logout" target="_self" title="注销本次登录" class="link1">
                        <img src="<%=basePath%>/resources/images/login/log_out.png" class="icon" title="注销本次登录"/>注销
                    </a>
                </span>
            </td>
        </tr>
    </table>
</div>
<div region='south' style="height:4px;"></div>
<div region="west" split="true" title="菜单导航" style="width:200px;height:100%">
    <div class="easyui-accordion" fit="true" border="false">
        <div title="用户中心" data-options="selected:true" style="overflow:auto;padding:3px;">
            <ul id="uc_ms"></ul>
        </div>
    </div>
</div>
<div region="center" border="false">
    <div id="tt" class="easyui-tabs" fit="true" style="border: 0 none #FFFFFF; background-color:#FFFFFF;">
    </div>
</div>
</body>
</html>
