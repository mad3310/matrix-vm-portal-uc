<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="renderer" content="webkit">
  <title></title>
  <link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/usercenterRecharge.css"/>
</head>
<!--chongzhitanceng/S-->
    <style type="text/css">
       .iframe-box{width: 560px;height: 530px;position: fixed;top:50%;left:50%;margin-left:-280px;margin-top:-265px;z-index: 1000;display:none}
       .iframe-box .close{width: 26px;height: 26px;display: block;position:absolute;top:23px;right: 23px;}
       .overlay {background: #000;filter:alpha(opacity=50); opacity: 0.5;display: none;position: absolute;top: 0px;left: 0px;width: 100%;height: 100%;
         z-index: 999;display: none;
       }
       .dbox .overlay{display:block;}
       .dbox .iframe-box{display:block;}
       .modal-header .close{
           background-position: -63px -1px;
       }
       .iframe-box .close{
           position:relative;
           top: 55px;
           left:7px;
           z-index: 10001;
           transform-origin: center center;
           -webkit-transform-origin: center center;
       }
       .dbox{ display: none}
    </style>
<body>
<div id="dbox" class="">
    <div class="iframe-box modal-header" id="iframeCz">
        <button type="button"  class="close" data-dismiss="modal" id="iframeClose" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <iframe id="rechargeIframe" src="${ctx}/recharge/rechargePop.do" width="560" height="530" frameborder="no"
                border="0" scrolling="no" allowTransparency="true"></iframe>
    </div>
    <div class="overlay"></div>
</div>
<!--chongzhitanceng/E-->
<!--<script type="text/javascript">
    $ = jQuery = require("lib/jquery.min");
</script>-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/usercenterApp.js?t=20150623"></script>
<script type="text/javascript">
    $ = jQuery = require('lib/jquery.min');//jquery
    $(function(){
        /*触发弹层事件*/
        $("#btnCz").click(function(){
            //alert(1);//return;
            var iframe = $("#iframeCz");
                //_width = parseInt(($(window).width()-iframe.width())/2),
                //_height =parseInt(($(window).height()-iframe.height())/2);
                //iframe.css({"left":_width,"top":_height});
                $(".overlay").height($(document).height()).width($(window).width());
                $("#dbox").addClass("dbox").fadeIn(200);
        });
        //采用document.getElementByID绑定事件确保事件全局唯一
        $("#iframeClose").click(function () {
            var iframe = $("#dbox");
                iframe.fadeOut(200);
                iframe.removeClass("dbox");
                $("#rechargeIframe").attr("src", "${ctx}/recharge/rechargePop.do");
        });

    });
</script>
</body>
</html>