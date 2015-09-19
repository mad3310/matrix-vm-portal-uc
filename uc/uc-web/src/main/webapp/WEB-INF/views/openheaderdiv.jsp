<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link type="text/css" rel="stylesheet" href="/assets/css/main/adminHeaderApp.css"/>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/js/min/adminZbHomeApp.js"/>
<header class="le-head-user">
    <div class="leyun-topbar">
        <div class="leyun-topbar-body">
            <div class="topbar-wrap clearfix">
                <div class="topbar-head pull-left">
                    <a href="#"><img src="http://static.uc.letvcloud.com/images/base/logo.png" alt="乐视云计算"></a>
                </div>
                <div class="topbar-nav pull-left">
                    <p class="topbar-nav-info">云直播</p>
                </div>
                <div class="topbar-info pull-right">
                    <div class="info">欢迎您，<a href="http://uc.letvcloud.com/userView/ucOverview.do" class="user" id="username" target="_top">&nbsp;</a></div>
                    <div class="info">
                        <a id="logout" href="http://uc.letvcloud.com/logout.do" target="_top">退出</a><label>|</label>
                        <a href="http://uc.letvcloud.com/userView/ucOverview.do" target="_top">用户中心</a><label>|</label>
                        <a href="http://help.letvcloud.com/" target="_top">帮助与支持</a><label>|</label>
                        <a href="javascript:;" id="topbar-nav-control" class="link-control">控制台<i class="icon-dropdown-sj"></i></a>
                        <dl class="items clearfix" id="le-control-menus">
                        </dl>
                    </div>
                    <a href="http://uc.letvcloud.com/messageView/msgCenterView.do" class="topbar-info-msg" target="_top">
                        <i class="icon-msg-w"></i><em id="count" class="num"></em></a>
                </div>
            </div>
        </div>
    </div>
     <script type="text/javascript"
    src="http://static.uc.letvcloud.com/js/min/jquery-1.7.2.min.js"></script>

    <script type="text/javascript">
        var username = $("#username");
        var messagecount = $("#count");
        var manage = $("#le-control-menus");
        $(function() {
            $("#topbar-nav-control").show();
            $('#logout').attr('href',"http://uc.letvcloud.com/logout.do?backUrl="+top.location.href);
//ajax 跨域
            $.ajax({
                type : "GET",
                url : "http://uc.letvcloud.com/conmmonPage/showHeaderParam.do",
                dataType: 'jsonp',
                jsonp: 'jsoncallback',
                success : function(data) {
                    var manageArray = data.managecontrol;
                    var html = "";
                    if(manageArray!=undefined&&manageArray.length>0) {
                        for (var i = 0; i < manageArray.length; i++) {
                            html = html + "<dd><a target='_blank' href='" + manageArray[i].url + "'>" + manageArray[i].name + "</a></dd>";
                        }
                        html = html + "<dd><a target='_blank' href='http://data.letvcloud.com/'>Data+</a></dd>";
                    }else{
                        html = html + "<dd><a>未开通任何业务</a></dd>";
                    }
                    if(typeof data.username == "undefined"){
                        $("#logout").hide();
                        manage.html(html);
                        return;
                    }
                    username.html( data.username);
                    messagecount.html( data.messageCount);
                    manage.html(html);
                }
            });
        });
    </script>
</header>
