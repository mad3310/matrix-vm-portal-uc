<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
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
    <link type="text/css" rel="stylesheet" href="${ctx}/assets/css/min/zhiboApp.css"/>
    <style type="text/css">
        .upload-success-tankuang-info{position:relative;padding:20px 0 30px}
        .upload-success-tankuang-info p{line-height:40px;height:40px;text-align:center}
        .upload-success-tankuang-info p.h4{font-size:20px;margin-left:40px}
        .upload-success-tankuang-info i{display:inline-block;position:absolute;left:0;top:34px;width:46px;height:40px;background:url(http://static.uc.letvcloud.com/images/base/icon-modal.png) no-repeat -46px -72px}</style>
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
<body>
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
<!--title/S-->
<h1 class="title-zhuce"><p>云点播服务开通</p><p><span class="line"></span></p></h1>
<!--title/E-->
<!--main /S-->
<div class="comwidth clearfix">
    <div class="zhibo-con border-bottom  pb-10 clearfix">
        <p class="title titletext01"><i class="icon-arrow01"></i>免费模式</p>
        <p class="title mt-35 fuwutext pl-110">服务内容<i class="icon-arrow"></i></p>
        <ul class="con01 clearfix">
            <li><span class="icon-tag-arrow tags">存储</span><span class="info">空间：不限</span><span class="info">费用：免费</span></li>
            <li><span class="icon-tag-arrow tags">转码</span><span class="info">时间：不限</span><span class="info">费用：免费</span></li>
            <li><span class="icon-tag-arrow tags">播放器</span><span class="info">数量：不限</span><span class="info">费用：免费</span></li>
            <li><span class="icon-tag-arrow tags">平台服务费</span><span class="info">云平台服务</span><span class="info">费用：免费</span></li>
        </ul>
        <p class="db_fuwu02_xieyi"><a href="http://help.letvcloud.com/Wiki.jsp?page=Protocol" target="_blank">免费服务协议>></a></p>
    </div>
    <div class="zhibo-con border-bottom  clearfix">
        <p class="title"><i class="icon-arrow02"></i>更多模式</p>
        <span class="db_fuwu_hope">敬请期待...</span>
    </div>
    <div class="btn-zhibo clearfix" ><a href="javascript:;" id="openVodServiceModal" class="btn-primary btn-xxl">开通服务</a></div>
</div>
<!-- 开通成功/S -->
<div class="modal fade" id="uploadSuccessModal" tabindex="-1" role="dialog" aria-labelledby="uploadSuccessModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 480px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="<editPhoneModalLabel></editPhoneModalLabel>">服务开通成功</h4>
            </div>
            <!--//s上传成功-->
            <div class="modal-body" style="display: -none;">
                <div class="row text-center upload-success-tankuang-info">
                    <i class="upload-success-tankuang-icon col-sm-3 col-sm-offset-3"></i>
                    <p class="h4">云点播服务已开通</p>
                    <p class="text-center ml-20">3s后自动跳转云点播控制台</p>
                </div>
                <div class="row" style="padding-bottom: 54px;" align="center">
                    <button type="button" onclick="window.location.href='http://vod.letvcloud.com/user/userinfo'" class="btn btn-primary" style="padding: 6px 20px;margin-left: 70px;">点播控制台</button>
                    <a href="http://help.letvcloud.com/" target="_blank" class="text-primary ml-10">了解更多>></a>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<!-- 开通成功/E -->
<!--main /E-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<script type="text/javascript" src="${ctx}/assets/js/min/tagApp.js"></script>
<script type="text/javascript">
    $=require("lib/jquery.min");
    require("lib/bootstrap.min");
    $(function(){
        $("#openVodServiceModal").bind("click",function(){
            var params =null;
            var url = '/serviceOpen/openVod.do';
            $.post(url,params,
                    function(data){
                        if(data.state ==1){
                            //成功的操作
                            $("#uploadSuccessModal").modal("show");
                            setTimeout(function(){window.location.href='http://vod.letvcloud.com/user/userinfo'},3000);
                        }
                    },"json");
        });
    });
</script>
</body>
</html><!-- file tree:
|...yundianbo-fuwu02.html
|   |...header-s.html
|   |...header-e.html
|   |...header-common.html
|   |...footer.html
- By MOKTEXT. -->