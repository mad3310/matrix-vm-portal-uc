<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<!--[if lte IE 8 ]>
<html class="ielow" lang="zh-CN">
<![endif]-->
<!--[if (gt IE 8)|!(IE)]><!-->
<html lang="zh-CN">
<!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <title>乐视云视频-最专业的视频开放平台，提供一站式视频解决方案</title>
    <meta name="Keywords" content="乐视云视频，免费视频空间，视频存储，免费空间，企业视频，播客，视频建站，视频营销，在线视频，开放平台"/>
    <meta name="Description" content="乐视云视频是乐视网旗下视频开放平台，专注于为客户提供视频上传、存储、转码、调取、个性化定制、统计等一站式视频解决方案"/>
    <link rel="shortcut icon" href="http://static.uc.letvcloud.com/images/favicon.ico" />
    <link type="text/css" rel="stylesheet" href="/assets/css/main/registerApp.css"/>
    <style type="text/css">
        .icon-success-password.failed{background: url(http://static.uc.letvcloud.com/images/base/icon-admin-zb.png) no-repeat 0 -250px !important}
    </style>
    <!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!--[if IE 8]>
    <div class="ielow-div"><div class="ielow-content">亲，您正在使用过时的浏览器，提升体验您可以：<img src="http://static.uc.letvcloud.com/images/ie6_ie.png"><a href="http://windows.microsoft.com/zh-cn/internet-explorer/download-ie">【升级IE浏览器】</a>或下载<img src="images/ie6_360.png" style="padding-left: 8px"><a href="http://se.360.cn/">【360安全浏览器】</a><img src="images/ie6_chrome.png" style="padding-left: 8px"><a href="http://www.google.cn/intl/zh-CN/chrome/">【chrome浏览器】</a></div></div>
    <![endif]-->
    <!--[if lte IE 7]>
    <script src="http://static.uc.letvcloud.com/js/min/lowBowerNoie.js"></script>
    <![endif]-->
</head>
<body>
<!-- 内容区域/S-->
<div class="password-title text-center">
    <div class="h3">乐视云计算充值状态</div>
    <p class="shortline"></p>
</div>
<section class="le-section-user comwidth clearfix">
    <div class="password-success">
        <div class="row">
            <c:if test="${state==1}">
                <i class="icon-success-password"></i>
                <div class="h4">充值成功<span class="ml-20">恭喜您成功充值${totalMoney}元</span></div></div>
                <div class="row mt-20">充值流水号：${orderNum}</div>
            </c:if>
            <c:if test="${state==0}">
                <i class="icon-success-password failed"></i>
                <div class="h4">充值失败<span class="ml-20">充值${totalMoney}元，充值失败</span></div></div>
            </c:if>
    </div>
</section>
<!-- 内容区域/E-->
<!-- 引入底部foot-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/jquery-1.7.2.min.js"></script>
</body>
</html><!-- file tree:
|...usercenter-zhuce-success.html
|   |...header-s.html
|   |...header-e.html
|   |...usercenter-header-unlogin.html
|   |...footer.html
- By MOKTEXT. -->