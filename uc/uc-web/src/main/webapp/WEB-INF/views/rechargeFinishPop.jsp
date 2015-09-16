<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <title></title>
    <link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/usercenterRecharge.css"/>
    <style type="text/css">
        html, body {
            min-width: 540px;
            background: transparent;
        }

        .modal-dialog {
            width: 540px;
            margin: 10px 0 0 10px;
        }
        .modal-header .close {
            background: none;
        }
    </style>
</head>
<body>
<!-- 充值成功/S -->
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header modal-header-primary">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="<editPhoneModalLabel></editPhoneModalLabel>">充值完成前请不要关闭此窗口</h4>
        </div>
        <div class="modal-body">
            <div class="row text-center fapiao-tankuang-info" style="padding-bottom: 40px;">
                <p>请在新开充值页面上完成付款后，再继续支付。</p>
            </div>
            <div class="row" style="padding-bottom: 54px;text-align: left;">
                <button type="button" class="btn btn-primary" style="padding: 6px 20px;margin-left: 120px;">充值完成
                </button>
                <button type="button" class="btn btn-default" style="padding: 6px 20px;margin-left: 60px;">充值遇到问题
                </button>
            </div>
        </div>
    </div>
</div>
<!-- 充值成功/E -->
</body>
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
    document.domain="letvcloud.com";
    $(function () {
        var f = function () {
            $.ajax({
                type: "GET",
                url: "/recharge/rechargeDone.do",
                dataType: "JSON",
                success: function (data) {
                    if(parent.rechargeBackFunction != undefined){
                        parent.rechargeBackFunction(data);
                    }
                    $("#dbox",parent.document).fadeOut(50,function(){
                        $("#dbox", parent.document).removeClass("dbox");
                        $("#rechargeIframe", parent.document).attr("src", "${popUrl}");
                    });
                    $("#iframeClose").click(function () { //将事件绑会充值click事件
                        $("#dbox", parent.document).fadeOut(200);
                        $("#dbox", parent.document).removeClass("dbox");
                        $("#rechargeIframe", parent.document).attr("src", "${popUrl}");

                    });
                }
            });
        }

        $(".btn-primary").bind("click", f);
        $("#iframeClose", window.parent.document).bind("click", f);
        $(".btn-default").bind("click", f);

    });
</script>
</html>