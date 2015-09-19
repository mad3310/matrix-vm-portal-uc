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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <title>乐视云视频-最专业的视频开放平台，提供一站式视频解决方案</title>
    <meta name="Keywords" content="乐视云视频，免费视频空间，视频存储，免费空间，企业视频，播客，视频建站，视频营销，在线视频，开放平台"/>
    <meta name="Description" content="乐视云视频是乐视网旗下视频开放平台，专注于为客户提供视频上传、存储、转码、调取、个性化定制、统计等一站式视频解决方案"/>
    <link rel="shortcut icon" href="http://static.uc.letvcloud.com/images/favicon.ico"/>
    <link type="text/css" rel="stylesheet" href="/assets/css/main/loginApp.css"/>
    <!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!--[if IE 8]>
    <div class="ielow-div">
        <div class="ielow-content">亲，您正在使用过时的浏览器，提升体验您可以：<img src="images/ie6_ie.png"><a
                href="http://windows.microsoft.com/zh-cn/internet-explorer/download-ie">【升级IE浏览器】</a>或下载<img
                src="images/ie6_360.png" style="padding-left: 8px"><a href="http://se.360.cn/">【360安全浏览器】</a><img
                src="images/ie6_chrome.png" style="padding-left: 8px"><a href="http://www.google.cn/intl/zh-CN/chrome/">【chrome浏览器】</a>
        </div>
    </div>
    <![endif]-->
    <!--[if lte IE 7]>
    <script src="${ctx}js/min/lowBowerNoie.js"></script>
    <![endif]-->
</head>
<body>
<!--nav/S-->
<header class="comwidth clearfix">
    <div class="head-lji comwidth">
        <a href="#" class="logo-ljl pull-left"></a>
        <ul class="nav-ljl link-white pull-left">
            <li class="li-on"><a href="#"><span>首页</span><i></i></a></li>
            <li><a href="#"><span>产品</span><i></i></a></li>
            <li><a href="#"><span>解决方案</span><i></i></a></li>
            <li><a href="#"><span>合作伙伴</span><i></i></a></li>
            <li><a href="#"><span>帮助与支持</span><i></i></a></li>
        </ul>
        <dl class="info-ljl pull-right">
            <dt class="icon-nav-tel link-white pull-left">400-323-100</dt>
            <dd class="pull-left link-gray6">
                <a href="#">登陆</a>
                <a href="${ctx}/user/registerView.do">注册</a>
            </dd>
        </dl>
    </div>
</header>
<!--nav/E-->
<!--main /S-->
<div class="login-bg-ljl">
    <div class="comwidth clearfix">
        <div class="login-ljl  pull-right">
            <form id="loginForm" action="${ctx}/login/userLogin.do" method="post">
                <input type="hidden" name="backUrl" value="${backUrl}">

                <h1>用户登录</h1>
                <ul class="form mt-20">

                    <li><span class="type">邮<span class="pl-20"></span>箱：</span><span class="info"><input type="text"
                                                                                                          class="input"
                                                                                                          name="username"/></span>
                    </li>
                    <li><span class="type">密<span class="pl-20"></span>码：</span><span class="info"><input type="text"
                                                                                                          class="input"
                                                                                                          name="password"/><span
                            class="icon-view"></span></span></li>
                    <li><span class="type">验证码：</span><span class="info"><input type="text" class="input-short"
                                                                                name="captchaCode"/><span
                            class="yzm">
                   	<img src="${ctx}/captcha/createCaptcha.do" id="captcha"></span><span class="icon-refresh"
                                                                                         id="captchaRefresh"></span></span>
                    </li>
                    <li class="txt">
                        <span class="type"></span>
                        <span class="info">
                            <input type="checkbox" name="remember" class="check">记住密码
                            <a href="${ctx}/restPassword/backPasswordView.do" class="ml-40 link-red">忘记密码</a>
                        </span>
                    </li>
                </ul>
                <p><a href="javascript:void(0)" class="btn-login link-white" onclick="checkForm();">登录</a><span
                        class="ml-15"><a href="${ctx}/registerView/registerUserView.do"
                                         class="link-red">快速注册</a></span>
                </p>
            </form>
        </div>
    </div>
</div>
<!--main /E-->
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
</body>

<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
    var checkForm = function () {
        document.getElementById("loginForm").submit();
    }


    $(function () {
        $('#captchaRefresh').click(function () {

            $("#captcha").attr("src", '${ctx}/captcha/createCaptcha.do?date=' + new Date());
        });
    });

</script>
</html>
<!-- file tree:
|...login.html
| |...header-login.html
| |...footer.html
- By MOKTEXT. -->