<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/registerApp.css"/>
<jsp:include page="header-e.jsp"></jsp:include>
<!--head/E-->
<!-- 内容区域/S-->
<div class="password-title text-center">
    <div class="h3">找回密码</div>
    <p class="shortline"></p>
</div>
<section class="le-section-user comwidth clearfix">
    <div class="password">

        <div role="tabpanel" class="tab-wraper">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist" id="myTab">
                <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" id="emailTab"
                                                          data-toggle="tab">邮箱找回</a><i class="down-arrow-ico"></i>
                </li>
                <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab" id="mobileTab">手机找回</a><i
                        class="down-arrow-ico"></i>
                </li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content text-left">
                <div role="tabpanel" class="tab-pane active" id="home">
                    <form class="form-horizontal vform" role="form" id="restPassword" action="">
                        <div class="form-group">
                            <label for="email" class="le-col-2 control-label"><span class="bitianxiang">*</span>登录邮箱：</label>

                            <div class="le-col-5">
                                <input type="text" class="form-control form-input-required form-input-required-email"
                                       id="email" placeholder="用于登录及密码找回" nullmsg="请输入邮箱地址！"
                                       errormsg="请输入正确的邮箱地址" onblur="searchUserByEmail(this.value)">
                            </div>
                            <div class="le-col-4">
                               <!--  <div class="Validform_checktip"></div> -->
                                <span class="Validform_checktip " id="emailMsg"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="emailCaptcha" class="le-col-2 control-label"><span
                                    class="bitianxiang">*</span>验证码：</label>

                            <div class="le-col-3">
                                <input type="text" class="form-control form-input-required form-input-required-num"
                                       id="emailCaptcha" placeholder="4位验证码" nullmsg="请输入验证码！" errormsg="请输入正确验证码" onblur="checkCaptcha(this.value)">
                            </div>
                            <div class="le-col-5 clear-left">
                                <img width="70" height="34" src="${ctx}/captcha/createCaptcha.do" id="captcha"
                                     class="pull-left" alt="验证码">
                                <span class="icon-refresh" id="captchaRefresh"></span>

                                <span class="Validform_checktip erro-tips-yanzhengma" id="captchaMsg"></span>
                            </div>
                        </div>
                        <div class="form-group btn-wraper">
                            <div class="col-sm-offset-2 col-sm-4">
                                <button type="button" class="btn btn-primary btn-lg" onclick="backPasswordByEmail()">找回密码
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                <div role="tabpanel" class="tab-pane" id="profile">
                    <form class="form-horizontal vform form-sms" role="form" id="mobileForm" method="post" action="${ctx}/restPassword/backPasswordByMobileView.do"
                          onsubmit="return backPasswordByMobile()">
                        <div class="form-group">
                            <label for="areaNum" class="le-col-2 control-label"><span class="bitianxiang">*</span>选择国家／地区：</label>

                            <div class="le-col-5">
                                <select name="areaNum" id="areaNum" class="form-control" onchange="addAreaNum(this.value)">
                                    <c:forEach var="country" items="${countryList}">
                                        <option value="${country.countryAreaNum}"
                                                >${country.countryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="le-col-4">
                                <div class="Validform_checktip"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="mobile" class="le-col-2 control-label"><span class="bitianxiang">*</span>联系人手机号：</label>

                            <div class="tel-wraper le-col-7">

                                <input id="areaInput" name="areaInput" type="hidden" value="86">
                                <span class="pull-left" id="tel-wraper-span">+86</span>


                                <input type="text"
                                       class="form-control form-input-required form-input-required-phone form-sms-phone"
                                       id="mobile" placeholder="注册的手机号" nullmsg="请输入手机号！" errormsg="请输入正确的手机号"
                                       name="mobile" onblur="searchUserByMobile(this.value)" >
                            </div>
                            <div class="le-col-2">
                                <div class="Validform_checktip" id="mobileMsg" style="width: 180px;"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="checkcode" class="le-col-2 control-label"><span
                                    class="bitianxiang">*</span>验证码：</label>

                            <div class="le-col-5">
                                <input type="password" class="form-control form-input-required form-input-required-num"
                                       id="checkcode" name="checkcode" placeholder="6位数字" nullmsg="请输入验证码！" errormsg="请输入数字"
                                       onblur="checkMobileCode(this.value)">
                            </div>
                            <div class="le-col-3 wraper-yanzhengma">
                                <button type="button" class="btn btn-info pull-left btn-sms-code"
                                        onclick="sendMsg2Mobile()">免费获取验证码
                                </button>
                                <div class="le-col-2">
                                    <div class="Validform_checktip" id="mobileCaptchaMsg" style="width: 180px; margin-left: 18px;"></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group btn-wraper">
                            <div class="col-sm-offset-2 col-sm-4">
                                <button type="submit" class="btn btn-primary btn-lg" >找回密码</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- 内容区域/E-->
<!-- 引入底部foot-->
<!-- 提示框 -->
<div class="modal fade" id="showDialogDiv" tabindex="-1" role="dialog" aria-labelledby="changePhoneSuccessModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 540px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <a href="javascript:hideshowDialogDiv()"><button type="button" class="close"><span aria-hidden="true">&times;</span></button></a>
                <h4 class="modal-title" id="showTitle">温馨提醒</h4>
            </div>
            <div class="modal-body" style="padding-top: 0;">
                <div class="modal-warp modal-warp-edit-phone row clearfix">
                    <p><i class="icon-user-danger"></i><span class="h4 ml-10" id="dialogInfo">请检查信息录入是否正确</span></p>
                    <div class="text-center">
                        <a id="confirmButton" href="javascript:hideshowDialogDiv()"><button class="btn btn-primary btn-xl">确定</button></a>
                        <%--  确定 --%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- footer/S-->
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<!-- footer/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/registerApp.js?t=20150421"></script>

<script type="text/javascript">
    $ = jQuery = require("lib/jquery.min");//jquery
    require("lib/bootstrap.min");//modal
</script>

<script type="text/javascript">

    $(function(){
        $('#captchaRefresh').click(function () {

            $("#captcha").attr("src", '/captcha/createCaptcha.do?date=' + new Date());
        });
    });
    function showDialogDiv(title,comment){
        $("#showTitle").text(title);
        $("#dialogInfo").text(comment);
        $("#showDialogDiv").modal('show');
    }
    function hideshowDialogDiv(){
        $("#showDialogDiv").modal('hide');
    }

    var mobileFlag = false;

    var emailFlag = false;

	var captchaFlag = false;

    var checkMobileCode = function (mobileCode) {
		var mobile = $("#areaInput").val()+$("#mobile").val();
        $.ajax({
            type: "GET",
            url: "${ctx}/user/checkMobileCode.do?checkCode=" + mobileCode+"&mobile="+mobile,
            dataType: "TEXT",
            success: function (data) {
                if (data != 'Y') {
                    $("#mobileCaptchaMsg").removeClass();
                	$("#mobileCaptchaMsg").addClass("Validform_checktip Validform_wrong");
                    $("#mobileCaptchaMsg").html("验证码错误");
                    captchaFlag = false;
                } else {
                    $("#mobileCaptchaMsg").removeClass();
                	$("#mobileCaptchaMsg").addClass("Validform_checktip Validform_right");
               	  	$("#mobileCaptchaMsg").html("验证码正确");
               	  	captchaFlag = true;
                }
            }
        });
    }


    var sendMsg2Mobile = function () {
       $("#mobile").trigger("blur");
        if (mobileFlag) {
           // var mobile = $("input[name='mobile']").val();
           var mobile = $("#mobile").val();
            $.ajax({
                type: "GET",
                url: "${ctx}/user/sendMsgForBack.do?mobile=" + $("#areaInput").val() + mobile,
                dataType: "json"
            });
        }
    }


    var searchUserByEmail = function (email) {

        $.ajax({
            type: "GET",
            url: "${ctx}/user/searchUserByEmail.do?email=" + email,
            dataType: "text",
            success: function (data) {
                if (data != 'Y') {
               	 	$("#emailMsg").addClass("Validform_wrong");
                    $("#emailMsg").html("没有该邮箱帐号");
                    emailFlag = false;
                } else {
                	$("#emailMsg").removeClass("Validform_wrong");
                	$("#emailMsg").addClass("Validform_right");
                    $("#emailMsg").text("通过信息验证");
                    emailFlag = true;
                }
            }
        });
    }



    var searchUserByMobile = function (mobile) {
        $.ajax({
            type: "GET",
            url: "${ctx}/user/searchUserByMobile.do?mobile=" + mobile+"&areaInput="+$("#areaInput").val(),
            dataType: "TEXT",
            async: false,
            success: function (data) {
                if (data != 'Y') {
                	$("#mobileMsg").addClass("Validform_wrong");
                    $("#mobileMsg").text("该手机号未被注册使用");
                    mobileFlag = false;
                } else {
                	$("#mobileMsg").removeClass("Validform_wrong");
                	$("#mobileMsg").addClass("Validform_right");
                    $("#mobileMsg").text("通过信息验证");
                	mobileFlag = true;
                }
            },
        });
    }




	var backPasswordByEmail=function (){
        $("#emailCaptcha").trigger("blur");
		if(captchaFlag && emailFlag){
            var parameters ={};
            parameters["email"]=$("#email").val();
            parameters["captcha"]=$("#emailCaptcha").val();
			 $.ajax({
		            type: "POST",
		            url: "${ctx}/restPassword/backPasswordByEmail.do",
                    data:parameters,
		            dataType: "text",
		            success: function (data) {
                        if(data=="Y"){
                            var email = $("#email").val();

                            showDialogDiv("找回密码邮件已发送","已发送至邮箱"+email);
                            var emailDomain =email.substring(email.indexOf("@")+1);
                            $("#confirmButton").attr("href","javascript:hideshowDialogDiv('"+emailDomain+"')");

                            $("#captchaRefresh").trigger("click");

                        }
		            }
		        });
		}
	}

    function hideshowDialogDiv(t){
        $("#confirmButton").attr("href","javascript:hideshowDialogDiv()");
        $("#showDialogDiv").modal('hide');
        if(t!=undefined){
            if(t =="letv.com"){
                t = "http://email."+t;
            }else{
                t = "http://mail."+t;
            }


            window.open(t);
        }

    }



	var backPasswordByMobile=function (){

		if(captchaFlag && mobileFlag){

//            var parameters ={};
//            parameters["mobile"]=$("#mobile").val();
//            parameters["areaInput"]= $("#areaInput").val();
            <%--$.ajax({--%>
                <%--type: "POST",--%>
                <%--url: "${ctx}/restPassword/backPasswordByMobileView.do",--%>
                <%--data:parameters,--%>
                <%--dataType: "text",--%>
                <%--success: function (data) {--%>
                <%--alert(data);--%>
                <%--}--%>
            <%--});--%>
            return true;

		}else{
            return false;
        }
	}


	var checkCaptcha=function (captcha){
		 $.ajax({
	            type: "GET",
	            url: "${ctx}/captcha/checkCaptcha.do?captcha=" +captcha ,
	            dataType: "text",
                async : false,
	            success: function (data) {
	            	if (data != 'Y') {
	            		$("#captchaMsg").addClass("Validform_wrong");
	                    $("#captchaMsg").html("验证码错误");
                        captchaFlag = false;
	                } else {
	                	$("#emailCaptcha").removeClass("Validform_error");
	                	  $("#captchaMsg").removeClass("Validform_wrong");
	                      $("#captchaMsg").addClass("Validform_right");
	                      $("#captchaMsg").html("验证码通过验证");
	                      captchaFlag = true;
	                }
	            }
	        });
	}



    var addAreaNum = function (areaNum) {
        $("#tel-wraper-span").html("+" + areaNum);
        $("#areaInput").val(areaNum);
        var yzm_phone_val = $("mobile").val();
        var regPhone=/^13[0-9]{9}$|14[0-9]{9}$|15[0-9]{9}$|17[0-9]{9}$|18[0-9]{9}$/,regWgPhone=/^\d+$/;
        if((!regPhone.test(yzm_phone_val) && areaNum=="86")||(!regWgPhone.test(yzm_phone_val) && areaNum!="86")){
            $("#mobileMsg").addClass("Validform_wrong");
            $("#mobileMsg").html("请输入正确的手机号码");
            $("#sendMsg2MobileBtn").addClass("disabled");
            isMobileFlag = false;
            return false;
        }
    }
    $("#emailTab").bind("click",function(){
        $("#mobile").val("");
        $("#checkcode").val("");
        $("#mobileMsg").text("");
        $("#mobileMsg").removeClass("Validform_wrong");
        $("#mobileMsg").removeClass("Validform_right");
        $("#mobileCaptchaMsg").text("");
        $("#mobileCaptchaMsg").removeClass("Validform_wrong");
        $("#mobileCaptchaMsg").removeClass("Validform_right");

    });
    $("#mobileTab").bind("click",function(){
        $("#email").val("");
        $("#emailCaptcha").val("");
        $("#emailMsg").text("");
        $("#emailMsg").removeClass("Validform_wrong");
        $("#emailMsg").removeClass("Validform_right");
        $("#captchaMsg").text("");
        $("#captchaMsg").removeClass("Validform_wrong");
        $("#captchaMsg").removeClass("Validform_right");

    });


</script>
</body>
</html>
<!-- file tree:
|...usercenter-findPassword.html
| |...header-register.html
| |...footer.html
- By MOKTEXT. -->