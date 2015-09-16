<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/registerApp.css"/>

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
	<link rel="shortcut icon" href="images/favicon.ico" />
    <link type="text/css" rel="stylesheet" href="${ctx}/assets/css/min/liveupdataApp.css"/>
	<!--[if lt IE 9]>
	<script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
	<!--[if IE 8]>
	<div class="ielow-div"><div class="ielow-content">亲，您正在使用过时的浏览器，提升体验您可以：<img src="images/ie6_ie.png"><a href="http://windows.microsoft.com/zh-cn/internet-explorer/download-ie">【升级IE浏览器】</a>或下载<img src="images/ie6_360.png" style="padding-left: 8px"><a href="http://se.360.cn/">【360安全浏览器】</a><img src="images/ie6_chrome.png" style="padding-left: 8px"><a href="http://www.google.cn/intl/zh-CN/chrome/">【chrome浏览器】</a></div></div>
	<![endif]-->
	<!--[if lte IE 7]>
	<script src="js/min/lowBowerNoie.js"></script>
	<![endif]-->
</head>
<div>
<!--顶部head/S-->
<header class="le-head-uc" id="le-head-uc">
    <div class="comwidth clearfix">
        <h1 class="pull-left logo"><a href="http://www.letvcloud.com/" target="_top"><img src="http://static.uc.letvcloud.com/images/logo.png" alt="logo"></a></h1>
        <ul class="pull-left navbar">
            <li><a href="http://www.letvcloud.com/" target="_top">首页</a></li>
            <li>
                <a href="javascript:;" class="le-header-uc-link">产品<i class="drop"></i></a>
                <div class="le-header-uc-items items-product clearfix">
                    <ul class="item clearfix">
                        <li><a href="http://www.letvcloud.com/vod.html" target="_top">云点播</a></li>
                        <li><a href="http://www.letvcloud.com/live.html" target="_top">云直播</a></li>
                        <li><a href="http://www.letvcloud.com/cdn.html" target="_top">CDN</a></li>
                        <li><a href="http://data.letvcloud.com/introduction.html" target="_top">Data+</a></li>
                    </ul>
                    <i class="arrow"></i>
                </div>
            </li>
            <li><a href="http://help.letvcloud.com/" target="_top">帮助与支持</a></li>
            <li><a href="http://www.letvcloud.com/about.html" target="_top">关于</a></li>
        </ul>
        <!--未登录-->
        <div class="pull-right user" style="display: none" id="Login_n">
            <div class="pull-left icon-nav-tel link-white pl-20">400-055-6060</div>
            <div class="pull-left link-gray6 login">
                <a href="http://uc.letvcloud.com/login.do" target="_top">登录</a>
                <a href="http://uc.letvcloud.com/registerView/registerUserView.do" target="_top">注册</a>
            </div>
        </div>
        <!--已登录-->
        <div class="pull-right user" style="display: none" id="Login_y">
            <div class="pull-left icon-nav-tel link-white pl-20">400-055-6060</div>
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
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
    /*用户中心提供通用头部*/
    var username = $("#username"),messagecount = $("#count"),manage = $("#le-control-menus");
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
        //退出
        $('#logout').attr('href',"http://uc.letvcloud.com/logout.do?backUrl="+top.location.href);
        //ajax跨域
        $.ajax({
            type : "GET",
            url : "http://uc.letvcloud.com/conmmonPage/showHeaderParam.do",
            dataType: 'jsonp',
            jsonp: 'jsoncallback',
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
<!--顶部head/E-->
<div class="container-pos-relative">
    <!--title/S-->
    <h1 class="title-zhuce"><p>云直播服务开通</p><p><span class="line"></span></p></h1>
    <!--title/E-->
    <!--main /S-->
    <div class="comwidth clearfix">
        <div class="zhibo-con border-bottom  clearfix">
             <p class="title color-blue"><i class="icon-right-blue"></i>免费模式</p>
             <ul class="con01 clearfix">
                 <li class="font-16">服务内容<i class="icon-arrow"></i></li>
                 <li><span class="icon-tag-arrow tags">转码</span><span class="info">时间：不限</span><span class="info">费用：免费</span></li>
                 <li><span class="icon-tag-arrow tags">播放器</span><span class="info">数量：不限</span><span class="info">费用：免费</span></li>
                 <li><span class="icon-tag-arrow tags">平台服务</span><span class="info">云平台服务</span><span class="info">费用：免费</span></li>
             </ul>
             <ul class="con01 clearfix mt-20">
                 <li class="font-16">赠送服务<i class="icon-arrow"></i></li>
                 <li>即日起开通云直播服务，免费为您同时开通 <a href="http://www.letvcloud.com/vod.html" target="_blank">云点播</a> 服务</li>
                 <li><a href="http://help.letvcloud.com/Wiki.jsp?page=Protocol" target="_blank" class="link-red">免费服务协议>></a></li>
             </ul>
        </div>
        <div class="zhibo-con border-bottom  clearfix">
             <p class="title"><i class="icon-right-gray"></i>更多模式</p>
             <ul class="con01 clearfix mt-20">
                 <li class="font-16 gray9">敬请期待...</li>
             </ul>
        </div>
        <div class="btn-zhibo clearfix"><a href="javascript:;" id="btn-open-service" class="btn-primary btn-xxl">提交申请</a></div>
    </div>
    <!--main/E-->
    <!--弹框遮罩层/S-->
    <div class="layer-yao" id="div-open-service">
        <section class="lyct">
            <div>开通云直播服务需要进行资质认证，<a  href="/qualificationsAuthenView/fillMsgView.do" target="_blank" class="text-primary">立即认证</a></div>
        </section>
    </div>
    <!--弹框遮罩层/E-->
    <!--弹框遮罩层认证中/S-->
    <div class="layer-yao" id="div-open-service1">
        <section class="lyct">
            <div align="center">资质认证中，<a href="/qualificationsAuthenView/executeAuthenView.do" target="_blank" class="text-primary">查看认证状态</a></div>
        </section>
    </div>
    <!--弹框遮罩层认证中/E-->
    <!--弹框遮罩层审核中/S-->
    <div class="layer-yao" id="div-open-shenhe">
        <section class="lyct">
            <div align="center">云直播开通申请审核中，请耐心等待...</div>
        </section>
    </div>
    <!--弹框遮罩层审核中/E-->
</div>
<!-- 引入底部foot-->
<!-- footer/S-->
    <jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<!--云直播服务开通/S-->
<div class="modal fade" id="openliveModal" tabindex="-1" role="dialog" aria-labelledby="openlive" aria-hidden="true">
  <div class="modal-dialog" style="width: 480px;">
    <div class="modal-content">
      <div class="modal-header modal-header-primary">
        <button type="button" class="close" id="closeliveModal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">云直播服务开通</h4>
      </div>
      <div class="modal-body">
      	 <div class="live-con clearfix">
      	    <p class="live-title"><i class="icon-right"></i>云直播服务申请已提交 </p>
      	 	<p class=" ml-20 text-center">我们将对您提交的信息进行审核，审核通过后将以邮件或短信的方式通知您</p>
      	 </div>
      </div> 
 	  <div class="row" style="padding-bottom: 54px; text-align:center">
        <button type="button" class="btn btn-primary" id="submitliveModal" style="padding:6px 30px;">确定</button>
      </div> 
    </div>
  </div>
</div>
<!--云直播服务开通/E-->
<script type="text/javascript" src="${ctx}/assets/js/min/tagApp.js"></script>
<script type="text/javascript">
    //跨域访问
    document.domain="letvcloud.com";
    $=require("lib/jquery.min");
    require("lib/bootstrap.min");

    var authState = ${authState};
    if(authState == 2){//未经过身份认证
        $("#div-open-service").show();
    }else if(authState == 3){//认证中
        $("#div-open-service1").show();
    }else if(authState == 4){//审核中
        $("#div-open-shenhe").show();
    }
    //点击modal 确定按钮 关闭当前，显示审核中
    $("#closeliveModal").bind("click",function(){
        closeLiveModalFn();
    });
    $("#submitliveModal").bind("click",function(){
        closeLiveModalFn();
    });
    function closeLiveModalFn(){
        $("#openliveModal").modal("hide");
        $("#div-open-shenhe").show();
        setTimeout(function(){$('html, body').animate({scrollTop: 0},0);},500);
    }
    //点击
    $("#btn-open-service").click(function(){
        var url = '/serviceOpen/openLive.do';
        var params=null;
        $.post(url, params, function (data) {
            //操作成功
            if (data.state == 1) {
                //成功的操作
                $("#openliveModal").modal("show");
//                setTimeout(function () {
//                    window.location.href = 'http://live.letvcloud.com'
//                }, 3000);
            }else if (data.state == 2) {//未经过认证
                $("#div-open-service").show();
            }else if(data.state == 3){
                $("#div-open-service1").show();
            }else if(data.state==4){
                $("#div-open-shenhe").show();
            }
        }, "json");
    });

    //充值成功的操作
    function rechargeBackFunction(data){
        $("#user_account").text("￥ "+data);
    }
</script>
</body>
</html><!-- file tree:
|...yunzhibo-kaitong.html
|   |...header-s.html
|   |...header-e.html
|   |...header-common.html
|   |...footer.html
- By MOKTEXT. -->