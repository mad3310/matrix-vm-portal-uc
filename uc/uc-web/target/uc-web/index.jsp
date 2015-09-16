<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta name="renderer" content="webkit">
    <title>乐视云视频-最专业的视频开放平台，提供一站式视频解决方案</title>
    <meta name="Keywords" content="乐视云视频，免费视频空间，视频存储，免费空间，企业视频，播客，视频建站，视频营销，在线视频，开放平台"/>
    <meta name="Description" content="乐视云视频是乐视网旗下视频开放平台，专注于为客户提供视频上传、存储、转码、调取、个性化定制、统计等一站式视频解决方案"/>
    <link rel="shortcut icon" href="../../images/favicon.ico" />
    <link type="text/css" rel="stylesheet" href="../../css/min/homeApp.css"/>
    <!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
        ul li{margin: 10px 0}
    </style>
</head>
<body id="lebody">
<div class="container">
    <h2>乐视云计算页面导航</h2>
    <ul class="clearfix">
        <!--  <li><a href="home-yao.html" target="_blank">首页</a></li> -->
        <li><a href="${ctx}/login/loginView.do" target="_blank">登录</a></li>
        <li><a href="${ctx}/registerView/registerUserView.do" target="_blank">注册</a></li>
        <li><a href="${ctx}/user/backPasswordView.do" target="_blank">找回密码</a></li>
        <li><a href="重置密码-手机.html" target="_blank">重置密码-手机</a></li>
        <li><a href="重置密码-邮箱.html" target="_blank">重置密码-邮箱</a></li>
        <li><a href="用户中心-概览.html" target="_blank">用户中心-概览</a></li>
        <li><a href="${ctx}/user/accountManagerView.do" target="_blank">用户中心-账号管理</a></li>
        <li><a href="${ctx}/user/accountManagerAuthenFillMsgView.do" target="_blank">用户中心-账号管理-资质认证-填写资质信息</a></li>
        <li><a href="用户中心-账号管理-资质认证-进行认证.html" target="_blank">用户中心-账号管理-资质认证-进行认证</a></li>
        <li><a href="用户中心-账号管理-资质认证-认证成功.html" target="_blank">用户中心-账号管理-资质认证-认证成功</a></li>
        <li><a href="用户中心-我的服务-云点播.html" target="_blank">用户中心-我的服务-云点播</a></li>
        <li><a href="用户中心-我的服务-云直播.html" target="_blank">用户中心-我的服务-云直播</a></li>
        <li><a href="用户中心-我的服务-CDN.html" target="_blank">用户中心-我的服务-CDN</a></li>
        <li><a href="用户中心-我的账单.html" target="_blank">用户中心-我的账单</a></li>
        <li><a href="用户中心-我的账单-月账单.html" target="_blank">用户中心-我的账单-月账单</a></li>
        <li><a href="用户中心-我的账单-账单信息.html" target="_blank">用户中心-我的账单-账单信息</a></li>
        <li><a href="用户中心-用户私钥.html" target="_blank">用户中心-用户私钥</a></li>
        <li><a href="用户中心-发票设置.html" target="_blank">用户中心-发票设置</a></li>
        <li><a href="用户中心-消息中心.html" target="_blank">用户中心-消息中心</a></li>
        <li><a href="用户中心-消息中心-详情.html" target="_blank">用户中心-消息中心-详情</a></li>
    </ul>
</div>
</body>
</html><!-- file tree:
|...../../index.html
- By MOKTEXT. -->