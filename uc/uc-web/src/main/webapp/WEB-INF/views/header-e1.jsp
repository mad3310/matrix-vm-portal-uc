<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<header class="le-head-uc tm" id="le-head-uc">
    <div class="comwidth clearfix">
        <h1 class="pull-left logo"><a href="http://matrix.letvcloud.com:8081/home/index.html" target="_top"><img src="http://static.uc.letvcloud.com/images/logo.png" alt="logo"></a></h1>
        <!--未登录-->
	<div class="pull-right user" style="display: none" id="Login_n">
            <div class="pull-left link-gray6 login">
                <a href="http://uc.letvcloud.com/login.do" target="_top">登录</a>
                <a href="http://uc.letvcloud.com/registerView/registerUserView.do" target="_top">注册</a>
            </div>
        </div>
        <div class="pull-right user" style="display: none" id="Login_y">
            <div class="pull-left logined">
                <a href="javascript:;"class="le-header-uc-link">
                    <!--如果用户未设置头像那么引用默认头像否则直接引用用户上传的头像-->
                    <img src="http://static.uc.letvcloud.com/images/base/icon-user-face-unlogin.png"class="user-face" id="userFace" alt="头像" />
                    <i class="drop"></i>
                </a>
                <div class="le-header-uc-items items-user clearfix">
                    <p class="info">欢迎您<br><a href="http://uc.letvcloud.com/userView/ucOverview.do" target="_top" id="username">&nbsp;</a></p>
                    <ul class="item clearfix">
                        <li><a href="http://uc.letvcloud.com/userView/ucOverview.do" target="_top">用户中心</a></li>
                        <li><a href="http://uc.letvcloud.com/messageView/msgCenterView.do" target="_top">消息(<span id="count">10</span>)</a></li>
                        <li><a href="http://uc.letvcloud.com/logout.do" target="_top">退出</a></li>
                    </ul>
                    <i class="arrow"></i>
                </div>
                <a href="javascript:;" class="le-header-uc-link" id="le-control-menus" >控制台<i class="drop"></i></a>
            </div>
        </div>

    </div>
</header>
<!--顶部head/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/jquery-1.7.2.min.js"></script>
<link tyoe="text/css" rel="stylesheet" herf="http://www.letvcloud.com/css/min/modify.css">
<script type="text/javascript">
    var username = $("#username");
    var messagecount = $("#count");
    var manage = $("#le-control-menus");

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
        $('#logout').attr('href',"http://uc.letvcloud.com/logout.do?backUrl="+top.location.href);

        $.ajax({
            type : "GET",
            url : "http://uc.letvcloud.com/conmmonPage/showHeaderParam.do",
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
                username.html( data.username);
                messagecount.html( data.messageCount);

                if (data.userAvatar != null&&data.userAvatar!="") {
                    $("#userFace").attr("src", data.userAvatar);
                }

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
            },
            error : function(){
                commom_header_fn();
            }

        });
    });
</script>
