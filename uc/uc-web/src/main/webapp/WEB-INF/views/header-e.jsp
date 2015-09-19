<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!--[if lt IE 9]>
<script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<!--[if IE 8]>
<div class="ielow-div"><div class="ielow-content">亲，您正在使用过时的浏览器，提升体验您可以：<img src="http://static.uc.letvcloud.com/images/ie6_ie.png"><a href="http://windows.microsoft.com/zh-cn/internet-explorer/download-ie">【升级IE浏览器】</a>或下载<img src="http://static.uc.letvcloud.com/images/ie6_360.png" style="padding-left: 8px"><a href="http://se.360.cn/">【360安全浏览器】</a><img src="http://static.uc.letvcloud.com/images/ie6_chrome.png" style="padding-left: 8px"><a href="http://www.google.cn/intl/zh-CN/chrome/">【chrome浏览器】</a></div></div>
<![endif]-->
<!--[if lte IE 7]>
<script src="http://static.uc.letvcloud.com/js/min/lowBowerNoie.js"></script>
<![endif]-->
</head>
<body>
<!--head/S-->
<link type="text/css" rel="stylesheet" href="/assets/css/main/commonHeaderApp.css"/>
<link type="text/css" rel="stylesheet" href="/assets/css/style.css"/>
<!--顶部head/S-->
<header class="le-head-uc header" id="le-head-uc">
    <div class="comwidth clearfix">
	<a href="http://matrix.letvcloud.com:8081/home/index.html" class="header-brand pull-left">
            <img src="/assets/img/brand-logo.png" class="brand-logo">
        </a>
        <!--未登录-->
        <div class="pull-right user" style="display: none" id="Login_n">
            <div class="pull-left link-gray6 login">
                <a href="${ctx}/login.do" target="_top">登录</a>
                <a href="${ctx}/registerView/registerUserView.do" target="_top">注册</a>
            </div>
        </div>

        <div class="pull-right user" style="display: none" id="Login_y">
            <div class="pull-left logined">
		<a href="http://matrix.letvcloud.com:8081/profile/#/dashboard" class="le-header-uc-link" id="le-control-menus" >帮助中心</a>
		<a href="http://matrix.letvcloud.com:8081/profile/#/dashboard" class="le-header-uc-link" id="le-control-menus" >控制台</a>
                <a href="javascript:;"class="le-header-uc-link">
                    <!--如果用户未设置头像那么引用默认头像否则直接引用用户上传的头像-->
                    <img src="http://static.uc.letvcloud.com/images/base/icon-user-face-unlogin.png"class="user-face" id="userFace" alt="头像" />
                    <i class="drop"></i>
                </a>
                <div class="le-header-uc-items items-user clearfix">
                    <p class="info">欢迎您<br><a href="${ctx}/userView/ucOverview.do" target="_top" id="username">&nbsp;</a></p>
                    <ul class="item clearfix">
                        <li><a href="${ctx}/userView/ucOverview.do" target="_top">用户中心</a></li>
                        <li><a href="${ctx}/messageView/msgCenterView.do" target="_top">消息(<span id="count">10</span>)</a></li>
                        <li><a href="${ctx}/logout.do" target="_top">退出</a></li>
                    </ul>
                    <i class="arrow"></i>
                </div>
            </div>
        </div>

    </div>
</header>
<!--顶部head/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/jquery-1.7.2.min.js"></script>

<script type="text/javascript">
    var username = $("#username");
    var messagecount = $("#count");
    var manage = $("#le-control-menus");
    var  cdn = $("#cdn");



    //通用顶部
    var commom_header_fn=function(){
        var le_head_uc=$("#le-head-uc"),
                le_head_uc_link=le_head_uc.find(".le-header-uc-link"),
                le_head_uc_items=le_head_uc.find(".le-header-uc-items");
        le_head_uc.on("click",".le-header-uc-link",function(){
            var target=$(this),
                    target_next_items=target.next(".le-header-uc-items");
            le_head_uc_link.not(target).removeClass("active");
            le_head_uc_items.not(target_next_items).removeClass("active");
            target.toggleClass("active");
            target_next_items.toggleClass("active");
        });
        //鼠标点击网页空白处 关闭顶部已展开的headerbar
        $(document).mouseup(function(e){
            if(!le_head_uc_link.is(e.target) && le_head_uc_link.has(e.target).length === 0 && le_head_uc_link.hasClass("active")){
                le_head_uc_link.removeClass("active");
                le_head_uc_items.removeClass("active");
            }
        });
    };

    $(function(){
        $('#logout').attr('href',"${ctx}/logout.do?backUrl="+top.location.href);

        $.ajax({
            type : "GET",
            url : "${ctx}/conmmonPage/showHeaderParam.do?t="+new Date().toTimeString(),
            dataType : "json",
            success : function(data) {
                if(typeof data.username == "undefined"|| data.username == ""){
                    $("#logout").hide();
                    $("#Login_n").removeAttr("style");
                    commom_header_fn();
                    return;
                }else{
                    $("#Login_y").removeAttr("style");
                }
                if (data.userAvatar != null&&data.userAvatar!="") {
                    $("#userFace").attr("src", data.userAvatar);
                }
                username.html( data.username);
                messagecount.html( data.messageCount);
                var manageArray = data.managecontrol;
                var html = '<div class="le-header-uc-items items-control clearfix" > <ul class="item clearfix">';
                if(manageArray.length>0) {
                    for (var i = 0; i < manageArray.length; i++) {
                        html = html + "<li><a target='_top' href='" + manageArray[i].url + "'>" + manageArray[i].name + "</a></li>";
                    }
                    html = html + "<li class='last'><a target='_top' href='http://data.letvcloud.com/'>Data+</a></li>";
                }else{
                    html = html + "<li class='last'><span>未开通任何业务</span></li>";
                }
                html = html + '</ul><i class="arrow"></i></div>';
                manage.after(html);
                commom_header_fn();
            }
        });

    });
</script>
