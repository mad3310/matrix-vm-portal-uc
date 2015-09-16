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

        .pay-way a.active-zf {
            border-color: #1073c2;
        }

        .zhifu-tankuang-info .ul-amount li label {
            font-weight: normal;
            cursor: pointer
        }
        .moneryInput{
            border:1px solid #ddd;
        }
        .moneryInput.error{
            border:1px solid #c00;
        }
        .modal-header .close{
            background: none;
        }
    </style>
</head>
<body>
<!-- 账户充值/S -->
<div class="modal-dialog" style="width: 540px; " id="rechargeProcessModal">
    <div class="modal-content">
        <div class="modal-header modal-header-primary">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span
                    aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="<editPhoneModalLabel></editPhoneModalLabel>">账户充值</h4>
        </div>
        <div class="modal-body">
            <div class="row text-center zhifu-tankuang-info">
                <div class="row zhifu-tankuang-row">
                    <div class="le-col-3 text-right">
                        账户余额：
                    </div>
                    <div class="le-col-9 text-important text-left">
                        ￥${accountMoney}
                    </div>
                </div>
                <form id="rechargeForm" method="post">
                    <div class="row">
                        <div class="le-col-3 text-right">充值金额：</div>
                        <div class="le-col-9">
                            <ul class="ul-amount">
                                <li>
                                    <label for="chargeMoneyRadioA">
                                        <input type="radio" name="chargeMoney" id="chargeMoneyRadioA" value="500"
                                               checked="checked"/><span class="ml-10">￥500</span>
                                        <%--<span class="text-important pull-right">历史日均消费：¥60</span>--%>
                                    </label>
                                </li>
                                <li>
                                    <label for="chargeMoneyRadioB">
                                        <input type="radio" name="chargeMoney" id="chargeMoneyRadioB"
                                               value="1000"/><span class="ml-10">￥1000</span>
                                    </label>
                                </li>
                                <li>
                                    <label for="otherMoney_radio">
                                        <input id="otherMoney_radio" type="radio" name="chargeMoney" value="0"/><span
                                            class="ml-10">其他金额</span>
                                    </label>
                                    <input id="otherMoney_Text" type="text" name="chargeInputMoney"
                                           class="moneryInput ml-10" autocomplete="off"/>
                                    <span class="ml-10">限整数</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row zhifu-tankuang-row pt-20">
                        <div class="le-col-3 text-right">
                            支付方式：
                        </div>
                        <div class="le-col-9 text-important pay-way">
                            <input type="hidden" name="rechargeWay"/>
                            <a href="javascript:void(0);" class="zhifubbao-a active-zf" input-value="ZFB"
                               rechargeWay="1"></a>
                            <a href="javascript:void(0);" class="weixin-a" input-value="WX" rechargeWay="2"></a>
                            <%--<a href="#" class="yinlian-a" input-value="CCB-DEBIT" rechargeWay="6"></a>--%>
                        </div>
                    </div>
                </form>
            </div>
            <div class="row" style="padding-bottom: 54px;text-align: left;">
                <button type="button" class="btn btn-primary" id="czFormSubmit"
                        style="padding: 6px 40px;margin-left: 164px;">确定
                </button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
    document.domain="letvcloud.com";
    $(function () {
        //纯数字 正则
        var NumberReg=/^[1-9]\d*$/;
//        var NumberReg = /^[1-9]d*\.\d*|0\.\d*[1-9]\d*$/;
        //充值金额输入框获取焦点 其被选中
        $("#otherMoney_Text").bind("focus", function () {
            $(":radio[name=chargeMoney]:eq(2)").prop("checked", true);
            changeSubmitBtn($(this));
        }).bind("keyup",function(){
            changeSubmitBtn($(this));
        });
        //验证按钮状态
        function changeSubmitBtn(obj){
            var txtVal=obj.val();
            if(txtVal.length > 0 && NumberReg.test(txtVal)){
                obj.removeClass("error");
                $("#czFormSubmit").removeClass("disabled");
            }else{
                obj.addClass("error");
                $("#czFormSubmit").addClass("disabled");
            }
        }

        $("#otherMoney_Text").keydown(function(event) {
            //输入框限制：限制输入首字符不能是0，限制除退格、数字外其他所有输入，限制除退格及内容长度在8其他输入
            if (($(this).val() == 0 && event.which == 48)||( event.keyCode != 8 &&(event.which < 48 || event.which > 57)) || (event.keyCode != 8 && $("#otherMoney_Text").val().length > 7)) {
                event.preventDefault();
            }
         });
        $(":radio[name=chargeMoney]:lt(2)").bind("click", function () {
            $("#czFormSubmit").removeClass("disabled");
            $("#otherMoney_Text").removeClass("error");
        });
        $(":radio[name=chargeMoney]:eq(2)").bind("click", function () {
            $("#otherMoney_Text").focus();
        });
        $(".pay-way a").bind("click", function () {
            $(".pay-way").children("a").each(function () {
                $(this).removeClass('active-zf');
            });
            $(this).addClass('active-zf');
        });
        $("#czFormSubmit").click(function () {
            $("#otherMoney_radio").attr("value", $("#otherMoney_Text").val());
            $("input[name='rechargeWay']").val($("a.active-zf").attr('rechargeWay'));
            var form = $("<form id='submitForm' action='http://uc.letvcloud.com/recharge/rechargeOperate.do' method='post' target='_blank'></form>");
            var input = $("<input type='text' name='chargeMoney' value='"+ $("input[name='chargeMoney']:checked ").val()+"' />");
            form.append(input);
            var input2 = $("<input type='text' name='rechargeWay' value='"+$("input[name='rechargeWay']").val()+"' />");
            form.append(input2);
            form.css('display','none');
            $("#submitForm",parent.document).remove();
            $(parent.document.body).append(form);
            form.submit();
            $("#rechargeIframe", parent.document).attr("src", "http://uc.letvcloud.com/recharge/rechargeFinishPop.do");

        });
    });
</script>
</body>
</html>