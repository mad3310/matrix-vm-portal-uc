<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/usercenterApp.css"/>
<style type="text/css">

    .btn-yzm {
        font-size: 16px;
        height: 35px;
        width: 160px;
        line-height: 35px;
        border-radius: 3px;
        text-align: center;
        display: inline-block;
        line-height: 22px;
        background: #38b8e9;
        position: relative;
        top: -1px;
        left: 3px;
        border: none;
        color: #fff;
    }
</style>
<jsp:include page="header-e.jsp"></jsp:include>
<!-- 顶部head/E-->
<!-- 中部内容/S-->
<section class="le-user-main comwidth clearfix">
    <div class="le-user-warp clearfix" id="usercenter">
        <%@include file="ucLeft.jsp" %>
        <!-- 左侧/E-->
        <!-- 右侧/S-->
        <div class="le-user-box clearfix" id="userbox">
            <div class="le-user-con clearfix">
                <h3 class="title-wj">用户信息</h3>
				<div class="info-box-wj row clearfix">
                    <div class="le-col-7 user-info-wj">
                        <div class="face">

                            <p><img src="<c:if test="${empty userAvatar }">http://static.uc.letvcloud.com/images/st-user-face-default.jpg</c:if>
                            	<c:if test="${not empty userAvatar }">${userAvatar}</c:if>"
                             id="showImgFace" alt="用户头像" title="用户头像"/></p>

                            <p class="text-center">
                                <button id="uphead" type="button" class="btn btn-default btn-xl mt-20" data-toggle="modal"
                                 		data-target="#editFaceModal" >修改头像
                                       <!--  data-target="#editFaceModal" onclick="showCurrentFaceImg()" >修改头像 -->
                                </button>
                            </p>
                        </div>
                        <div class="info info-base">
                            <p>会员类型：<span id="userType"></span></p>
							<input type="hidden" id="userTypeHide">
                            <p>注册邮箱：<span id="emailSpan"></span></p>
                            <input type="hidden" id="email">

                          <!--   <p>联系人姓名：<span id="contacts" class="info-modify"></span></p> -->
                            <p>联系人姓名：
                            	<span id="contacts" class="info-modify"></span>
                            	<span class="info-modify-hide hidden" id="contactsSpan">
                            	<input id="contactsInput" type="text" style="width:120px" maxlength="20" placeholder="长度最大为20字符" onblur="checkname()" />
                            </span>
                            <span id="checkname"></span>
                            </p>

                            <p>注册时间：<span id="createdTime"></span></p>
                        </div>
                    </div>
                    <div class="le-col-5">
                        <div class="info-base le-col-offset-1">
                            <p id="enterpriseNameP" class="hidden" style="width: 325px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">企业名称：<span class="info-modify" id="enterpriseName"></span><span class="info-modify-hide hidden" id="enterPriseEditSpan"><input type="text" maxlength="50" placeholder="长度最大为50字符" id="enterpriseNameInput"  /></span></p>
                            <p>网站类型：<span class="info-modify" id="siteType">互联网视频</span><span class="info-modify-hide hidden">
								<select name="sitetypeid" id="sitetypeid">
                                    <option  value="3">综合门户</option>
                                    <option value="9">搜索引擎</option>
                                    <option value="7">网络游戏</option>
                                    <option value="10">动漫网站</option>
                                    <option value="11">亲子&amp;育婴</option>
                                    <option value="4">网络购物</option>
                                    <option value="2">教育培训</option>
                                    <option value="12">视频网站</option>
                                    <option value="5">企业网站</option>
                                    <option value="13">网站导航</option>
                                    <option value="14">新闻资讯</option>
                                    <option value="15">SNS&amp;社区</option>
                                    <option value="16">生活网站</option>
                                    <option value="17">金融&amp;财经</option>
                                    <option value="18">IT科技</option>
                                    <option value="19">汽车网站</option>
                                    <option value="20">影视&amp;娱乐</option>
                                    <option value="21">分类信息</option>
                                    <option value="22">时尚杂志</option>
                                    <option value="23">旅游订票</option>
                                    <option value="24">广播电视</option>
                                    <option value="1">文化传媒</option>
                                    <option value="25">军事网站</option>
                                    <option value="26">健康网站</option>
                                    <option value="27">音乐网站</option>
                                    <option value="28">房产网站</option>
                                    <option value="29">体育网站</option>
                                    <option value="8">其他网站</option>
                                </select>
							</span></p>
                            <p style="width: 325px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">网站名称：<span class="info-modify" id="siteName" ></span><span class="info-modify-hide hidden"><input type="text" id="siteNameInput" maxlength="50" placeholder="长度最大为50字符" /></span></p>
                            <p style="width: 325px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">网站域名：<span class="info-modify"  id="siteDomain"></span><span class="info-modify-hide hidden"><input type="text" id="siteDomainInput" maxlength="50" placeholder="长度最大为50字符" /></span></p>
                        </div>
                        <p class="text-center">
                            <button type="button" class="btn btn-default btn-xl mt-20" id="modify-userinfo-btn">修改账号信息</button>
                            <button type="button" class="btn btn-default btn-xl mt-20 hidden" id="modify-saveuser-btn" onclick="saveUserInfo()">保存</button>
                            <button type="button" class="btn btn-default btn-xl mt-20 hidden" id="modify-cancleuser-btn">取消</button>
                        </p>
                    </div>
                </div>

                <h3 class="title-wj">资质认证</h3>

                <div class="info-box-borded-wj row clearfix">
                    <div class="le-col-10 le-col-md-10">
                        <p>资质认证后才可开具发票及开启云直播服务。</p>
                    </div>
                    <div class="le-col-2 le-col-md-2">
                        <p class="pull-right btn-groups">
                            <a id="authenHref" href="${ctx}/qualificationsAuthenView/fillMsgView.do"
                               class="btn btn-default btn-xl">立即认证</a>
                        </p>
                    </div>
                </div>
                <h3 class="title-wj">登录密码</h3>

                <div class="info-box-borded-wj row clearfix">
                    <div class="le-col-10 le-col-md-10">
                        <p>安全性高的密码可以使账号更安全。建议您定期更换密码，设置一个包括字母、符号或数字中至少两项且长度超过8位的密码。</p>
                    </div>
                    <div class="le-col-2 le-col-md-2">
                        <p class="pull-right btn-groups">
                            <button type="button" class="btn btn-default btn-xl" data-toggle="modal"
                                    data-target="#editPwdModal" id="mobileButton">更换
                            </button>
                        </p>
                    </div>
                </div>
                <h3 class="title-wj">手机绑定</h3>

                <div class="info-box-borded-wj row clearfix">
                    <div class="le-col-10 le-col-md-10">
                        <span id="currentMobile"></span>[手机号可用于接收服务信息、找回密码等]</span>
                    </div>
                    <div class="le-col-2 le-col-md-2">
                        <p class="pull-right btn-groups">
                            <button type="button" class="btn btn-default btn-xl" data-toggle="modal"
                                     id="changeMobile">更换
                            </button>
                        </p>
                    </div>
                </div>
                <h3 class="title-wj">邮箱验证</h3>

                <div class="info-box-wj row clearfix">
                    <div class="le-col-10 le-col-md-10">
                        <p>可用于快速找回密码，接收账户余额变动等信息提醒。</p>
                    </div>
                    <div class="le-col-2 le-col-md-2">
                        <p class="pull-right btn-groups">
                            <a href="javascript:activeEmail()" id="emailHref" class="btn btn-default btn-xl">立即验证</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <!-- 左侧/E-->
    </div>
</section>
<!-- 中部内容/E-->
<!-- 修改头像/S -->
<div class="modal fade" id="editFaceModal" tabindex="-1" role="dialog" aria-labelledby="editFaceModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" >
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" data-dismiss="modal" id="editFaceClose" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="editFaceModalLabel">修改我的头像</h4>
            </div>
            <div class="modal-body">
                <div class="modal-warp modal-warp-edit-face row clearfix">
                    <form  action="${ctx}/user/updateUserAvatar.do" method="post">
                        <div class="le-col-4">
                            <h5 class="title">头像预览</h5>

                            <p><img src="" id="userAvatarImg" alt="用户头像" class="face"></p>
                        </div>
                        <div class="le-col-8">
                            <h5 class="title">&nbsp;</h5>

                            <div class="clearfix">
                                <div class="le-file-input-box pull-left clearfix">
                                    <button type="button" id="imgBtn" class="btn btn-default btn-xl le-btn-file" >选择图片</button>
                                    <input type="file" name="file" id="file" class="le-file-input" style="z-index: -1;" accept="image/png,image/jpeg"
                                           nullmsg="请上传图片！"/>

                                    <input type="hidden" id="userAvatar" name="userAvatar">
                                </div>
                                <div id="checkUpload" class="Validform_checktip pull-left"></div>
                            </div>

                            <p>支持JPG、PNG格式图片，小于5M</p>

                            <p><input id="imageId" type="button" class="btn btn-primary btn-xl mt-50" value="确定" style="display: none" /></p>
                        </div>
                    </form>
                </div>
            </div>
            <!-- <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
              <button type="button" class="btn btn-primary">保存</button>
            </div> -->
        </div>
    </div>
</div>
<!-- 修改头像/E -->
<!-- 修改密码/S -->
<div class="modal fade" id="editPwdModal" tabindex="-1" role="dialog" aria-labelledby="editPwdModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" style="width:700px">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button id="editPwdClose" type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="editPwdModalLabel">修改密码</h4>
            </div>
            <div class="modal-body">
                <div class="modal-warp modal-warp-edit-pwd clearfix">
                    <form class="form-horizontal vform" action="${ctx}/user/modifyPassword.do" method="post"
                          id="modifyPasswordForm">
                        <div class="form-group">
                            <label for="upwdOlder" class="le-col-4 control-label">当前登录密码：</label>

                            <div class="le-col-8">
                                <span class="pull-left"><input type="password" id="upwdOlder" name="upwdOlder" class="form-control" nullmsg="请输入旧密码！" errormsg="密码必须8-16位字符，且为数字+字母或符号组合！" placeholder="旧密码" value="" onblur="checkOldPassword(this.value)"/></span>
                                <span class="Validform_checktip ml-15" id="passwordMsg"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="upwdNew" class="le-col-4 control-label">新的登录密码：</label>

                            <div class="le-col-8">
                                <span class="pull-left"><input type="password" id="upwdNew" name="upwdNew" class="form-control" errormsg="8-16位数字+字母或符号组合！"  nullmsg="请输入新密码" placeholder="新密码" value=""  /></span>
                                <span class="Validform_checktip ml-15" id="upwdNewSpan"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="upwdNewRe" class="le-col-4 control-label">确认新的登录密码：</label>

                            <div class="le-col-8">
                                <span class="pull-left"><input type="password" id="upwdNewRe" name="upwdNewRe" class="form-control form-input-required-repwd" recheck="upwdNew"  nullmsg="请输入确认密码" placeholder="确认新密码" errormsg="两次输入密码不一致" value="" onblur="recheackpwd(this)" /></span>
                                <span id="repwd" class="Validform_checktip ml-15"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="le-col-8 le-col-offset-4">
                                <input type="button" id="submitModifyBtn" class="btn btn-primary btn-xl mt-20" value="确定"
                                       onclick="submitModifyPassword();"/>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <!-- <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
              <button type="button" class="btn btn-primary">保存</button>
            </div> -->
        </div>
    </div>
</div>
<!-- 修改密码/E -->
<!-- 手机绑定/S -->
<div class="modal fade" id="editPhoneModal" tabindex="-1" role="dialog" aria-labelledby="editPhoneModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" style="width: 650px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" id="editPhoneClose" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="editMobileTitle">更换绑定手机</h4>
            </div>
            <div class="modal-body" style="padding-top: 0;">
                <div class="modal-warp modal-warp-edit-phone row clearfix">
                    <p class="text-color-yao" id="preModifyCurrentMobile"></p>

                    <form class="form-horizontal form-sms" id="modifyMobileForm" >
                        <div class="form-group">
                            <label class="le-col-3 control-label">国家／地区：</label>

                            <div class="le-col-5 tel-wraper clear-left">
                                <select class="select" onchange="addAreaNum(this.value)">


                                    <c:forEach var="country" items="${countryList}">
                                        <option value="${country.countryAreaNum}">${country.countryName}</option>
                                    </c:forEach>


                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="le-col-3 control-label">变更手机号： </label>

                            <div class="le-col-5 tel-wraper clear-left">
                           		<input id="areaInput" type="hidden" name="areaInput" value="86"/>
                                <span class="pull-left" style="left:0" id="tel-wraper-span">+86</span>
                                <input type="text" name="mobile"
                                		class="form-control form-input-required form-input-required-phone form-sms-phone"
                                		id="mobileInput" nullmsg="请输入手机号！" errormsg="请输入正确的手机号"
                                		onblur="isMobile(this.value)"/>
                            </div>
                              <div class="le-col-4">
                                <div class="Validform_checktip ml-15" id="mobileMsg"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="uphoneCode" class="le-col-3 control-label">验证码：</label>

                            <div class="le-col-2 clear-left">
                                <input type="text" class="form-control" id="uphoneCode" placeholder="6位数字"
                                       onblur="checkMobileCode(this.value)"/>
                            </div>
                            <div class="le-col-3" style="position:reletive; left:-15px;">
                                <button type="button" class="btn-yzm btn-sms-code disabled" id="sendMsg2MobileBtn"
                                        onclick="sendMsg2Mobile()">免费获取验证码
                                </button>
                            </div>
                            <div class="le-col-4">
                            	<div class="Validform_checktip ml-15" id="mobileCaptchaMsg"></div>
                           	</div>
                        </div>
                        <div class="form-group">
                            <div class="le-col-8 le-col-offset-2">
                                <input type="button"  class="btn btn-primary btn-xl btn-submit mt-20 btn-yao"
                                       value="确定" onclick="submitModifyMobile();"/>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <!-- <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
              <button type="button" class="btn btn-primary">保存</button>
            </div> -->
        </div>
    </div>
</div>
<!-- 手机绑定/E -->
<!-- 手机绑定成功/S -->
<div class="modal fade" id="changePhoneSuccessModal" tabindex="-1" role="dialog" aria-labelledby="changePhoneSuccessModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 540px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
               <a href="${ctx}/logout.do"><button type="button" class="close"><span aria-hidden="true">&times;</span></button></a>
                <h4 class="modal-title" id="">更换绑定手机</h4>
            </div>
            <div class="modal-body" style="padding-top: 0;">
                <div class="modal-warp modal-warp-edit-phone row clearfix">
                    <div class="icon-success-wraper clearfix"><i class="icon-success"></i><div class="h4 ml-10">更换绑定手机成功</div></div>
                    <p class="text-center" id="ModifiedMobile"></p>
                    <div class="text-center">
                       <a href="${ctx}/logout.do"><button class="btn btn-primary btn-xl">确定</button></a>
                      <%--  确定 --%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 手机绑定成功/E -->
<!-- 提示 -->
<div class="modal fade" id="showDialogDiv" tabindex="-1" role="dialog" aria-labelledby="changePhoneSuccessModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 540px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <a href="javascript:hideshowDialogDiv()"><button type="button" class="close"><span aria-hidden="true">&times;</span></button></a>
                <h4 class="modal-title" id="showTitle">温馨提醒</h4>
            </div>
            <div class="modal-body" style="padding-top: 0;">
                <div class="modal-warp modal-warp-edit-phone row clearfix">
                    <p style="width:auto; margin:0 auto; text-align:center; margin-bottom: 10px;"><i class="icon-user-danger" style="display:inline-block;"></i><span class="h4 ml-10" id="dialogInfo" style="display:inline;">请检查信息录入是否正确</span></p>
                    <div class="text-center">
                        <a href="javascript:hideshowDialogDiv()" id="confirmButton"><button class="btn btn-primary btn-xl">确定</button></a>
                        <%--  确定 --%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->

 <script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/usercenterApp.js?t=20150421"></script>
 <script type="text/javascript">
  $ = jQuery = require("lib/jquery.min");//jquery
  require("lib/bootstrap.min");//modal
</script>

<script src="http://static.uc.letvcloud.com/js/main/jquery.ui.widget.js"></script>
<script src="http://static.uc.letvcloud.com/js/main/jquery.iframe-transport.js"></script>
<script src="http://static.uc.letvcloud.com/js/main/jquery.fileupload.js"></script>

<script type="text/javascript">
    document.domain="letvcloud.com";

    //    var modifyPasswordFlag = false;

    var isMobileFlag = false;

    var checkMobileCodeFlag = false;
    var isMobile = function (mobile) {
        var areaInput = $("#areaInput").val();
        $.ajax({
            type: "GET",
            url: "${ctx}/user/isMobileNum.do?mobileNum=" + mobile+"&countryCode="+areaInput,
            dataType: "TEXT",
            success: function (data) {
                if (data != 'Y') {
               	 	$("#mobileMsg").addClass("Validform_wrong");
                    $("#mobileMsg").html("请输入正确的手机号码");
                    $("#sendMsg2MobileBtn").addClass("disabled");
                    isMobileFlag = false;
                } else {
                    var countryCode =$("#areaInput").val();
                    $.ajax({
                        type: "POST",
                        url: "${ctx}/user/mobileIsExist.do?mobile=" + mobile+"&countryCode="+countryCode,
                        dataType: "TEXT",
                        success: function (data) {
                            if(data=="N"){
                                $("#mobileMsg").removeClass("Validform_wrong");
                                $("#mobileMsg").addClass("Validform_right");
                                $("#mobileMsg").html("通过信息验证");
                                $("#sendMsg2MobileBtn").removeClass("disabled");
                                isMobileFlag = true;
                            }else{
                                $("#mobileMsg").addClass("Validform_wrong");
                                $("#mobileMsg").html("该手机号已使用");
                                $("#sendMsg2MobileBtn").addClass("disabled");
                                isMobileFlag = false;
                            }

                        }
                    });
                }
            }
        });
    }

    var compareOldNewPWd=function(){

        if($("#upwdOlder").val()==$("#upwdNew").val()){
            $("#upwdNewSpan").addClass("Validform_wrong");
            $("#upwdNewSpan").text("旧密码不能与新密码相同！");
        }
    }


    /*校验手机验证码*/
    var checkMobileCode = function (mobileCode) {
    	if(mobileCode!=""){
	    	var mobile = $("#areaInput").val() + $("input[name='mobile']").val();
	        $.ajax({
	            type: "GET",
	            url: "${ctx}/user/checkMobileCode.do?checkCode=" + mobileCode+"&mobile="+mobile,
	            dataType: "TEXT",
	            success: function (data) {
	                if (data != 'Y') {
	                	$("#mobileCaptchaMsg").addClass("Validform_wrong");
	                    $("#mobileCaptchaMsg").html("验证码错误");
	                    checkMobileCodeFlag = false;
	                } else {
	                    $("#mobileCaptchaMsg").removeClass("Validform_wrong");
	                    $("#mobileCaptchaMsg").addClass("Validform_right");
	                    $("#mobileCaptchaMsg").html("通过信息验证！");
	                    checkMobileCodeFlag = true;
	                }
	            }
	        });
    	}
    }


    /*提交修改手机*/

    var submitModifyMobile = function () {
        $("#mobileInput").trigger("blur");
        $("#uphoneCode").trigger("blur");
		if(!checkMobileCodeFlag){
    		checkMobileCode($("#uphoneCode").val());
    	}
		if($("#uphoneCode").val()==""){
    		$("#mobileCaptchaMsg").addClass("Validform_wrong");
            $("#mobileCaptchaMsg").html("验证码不能为空");
		}
    	if (isMobileFlag && checkMobileCodeFlag) {
    		if(confirm("绑定手机号码，需重新登录，确认绑定吗?")){
   			    $.ajax({
   			    	type: "POST",
   			        url: "${ctx}/user/modifyMobile.do",
   			        data: $("#modifyMobileForm").serialize(),
   			        success:function(data){
   			        	if (data != 'Y') {
   	                		alert("修改失败");
   		                } else {
   		                	$("#editPhoneModal").modal("hide");
   		                	$("#changePhoneSuccessModal").modal("show");
   		                	var str = $("input[name='mobile']").val();
   		                	var mobile ="+"+$("#areaInput").val()+" "+str.substr(0,3)+"****"+str.substr(7,11);
   		                	$("#ModifiedMobile").text("当前已绑定手机"+mobile);

                            $("#mobileInput").val("");
                            $("#mobileMsg").text("");
                            $("#mobileMsg").removeClass("Validform_wrong");
                            $("#mobileMsg").removeClass("Validform_right");
                            $("#uphoneCode").val("");
                            $("#mobileCaptchaMsg").text("");
                            $("#mobileCaptchaMsg").removeClass("Validform_wrong");
                            $("#mobileCaptchaMsg").removeClass("Validform_right");
                            $("#sendMsg2MobileBtn").addClass("disabled");
   		                }

   			        }
   			    });
   	    	 }else{
   	    		$("#editPhoneModal").modal("hide");
   	    	}
    	}
    }


    /*是否是当前用户的密码*/
    var checkOldPassword = function (oldPassword) {
        $.ajax({
            type: "GET",
            url: "${ctx}/user/isCurrentPassword.do?password=" + oldPassword,
            dataType: "text",
            async: false,
            success: function (data) {
                if (data == 'N') {
                    $("#passwordMsg").addClass("Validform_wrong");
                    $("#passwordMsg").html("当前用户密码错误");
                    $("#modifyPasswordForm").submit.disabled = true;

                } else {
                    $("#passwordMsg").removeClass("Validform_wrong");
                    $("#passwordMsg").addClass("Validform_right");
                    $("#passwordMsg").html("信息通过验证！");
                    $("#modifyPasswordForm").submit.disabled = false;

                }
            }
        });
    }

    $.ajax({
        type: "GET",
        url: "${ctx}/user/getUserInfoAuthenStatus.do?t="+new Date().toTimeString(),
        dataType: "JSON",
        success: function (data) {
            if(data.state==true){

                if(data.mobileState==true){
                    var alertMobile = "当前认证手机号:"+ data.mobile;
                    $("#preModifyCurrentMobile").text(alertMobile);
                    $("#changeMobile").text("更换");
                    $("#changeMobile").bind("click",function(){
                        showMobileChangeDiv("更换绑定手机");
                    });
                    $("#currentMobile").text("您已认证手机:"+data.mobile);
                }else {
                    $("#changeMobile").text("认证");
                    $("#preModifyCurrentMobile").text("");
                    $("#changeMobile").bind("click",function(){
                        showMobileChangeDiv("绑定手机");
                    });
                    $("#currentMobile").text("您尚未认证手机");
                }


            }
        }
    });
    function showMobileChangeDiv(title){
        $("#editMobileTitle").text(title);
        $('#editPhoneModal').modal('show');
    }


    <%--提交修改密码--%>
    var submitModifyPassword = function () {
        $("#upwdOlder").trigger("blur");
        $('.modal-warp-edit-pwd').find(".form-input-required").trigger("blur");
        $(".form-input-required-repwd").trigger("blur");
        $("#upwdNew").trigger("blur");
        if ( $('.modal-warp-edit-pwd').find(".Validform_wrong").size()==0) {
        	var parameter ={};
        	parameter["newPassword"]=$("#upwdNew").val();
        	parameter["upwdOlder"]=$("#upwdOlder").val();
             $.ajax({
            type: "POST",
            url: "${ctx}/user/modifyPassword.do",
            data: parameter,
            dataType: "text",
            success: function (data) {
                $("#editPwdModal").modal('hide');
               if(data=="Y"){
                   showDialogDiv("修改密码","修改密码成功。");
                   $("#upwdOlder").val("");
                   $("#upwdNew").val("");
                   $("#upwdNewRe").val("");
                   $("#repwd").text("");
                   $("#repwd").removeClass("Validform_wrong");
                   $("#repwd").removeClass("Validform_right");
                   $("#upwdNewSpan").text("");
                   $("#upwdNewSpan").removeClass("Validform_wrong");
                   $("#upwdNewSpan").removeClass("Validform_right");
                   $("#passwordMsg").text("");
                   $("#passwordMsg").removeClass("Validform_wrong");
                   $("#passwordMsg").removeClass("Validform_right");
               }else{
                   showDialogDiv("修改密码","修改密码失败");
               }
            }
        });


        }

    }
    $("#imageId").bind("click",function(){
        var parameter ={};
        parameter["userAvatar"]=$("#userAvatar").val();
        $.ajax({
            type:"post",
            url:"${ctx}/user/updateUserAvatar.do",
            dataType:"text",
            data:parameter,
            success: function(data){
                if(data=="Y"){
                    $("#editFaceModal").modal("hide");
                    initUserInfo();
                }
            }
        });
    });

    $(function () {
    	initUserInfo();
    	showAuthenButtonText();

    	$('#modify-userinfo-btn').on('click',function () {
    		$.ajax({
    	        type: "GET",
    	        url: "${ctx}/qualificationsAuthenView/getEnterpriseAuthenStatus.do",
    	        dataType: "text",
    	        success: function (data) {
    				if(data == "1"){
                        //通过
                        var userType;
                        $.ajax({
                            type: "GET",
                            url: "${ctx}/user/searchCurrentUser.do",
                            dataType: "JSON",
                            async:false,
                            success: function (data) {
                                userType =  data.userType
                            }
                        });

                        if(userType==1||userType==2){
                            //个人 不允许修改姓名

                            $('.info-modify').hide();
                            $('.info-modify-hide').removeClass('hidden');
                            $('#contacts').show();
                            $('#contactsSpan').addClass('hidden');
                            $('#modify-userinfo-btn').hide().siblings('button').removeClass('hidden');
                        }else{
                            //企业 不允许修改企业名称
                            $('.info-modify').hide();
                            $('.info-modify-hide').removeClass('hidden');
                            $('#enterpriseName').show();
                            $('#enterPriseEditSpan').addClass('hidden');
                            $('#modify-userinfo-btn').hide().siblings('button').removeClass('hidden');

                        }

    				}else{
                        //未通过 待审核 未填写
                        $('.info-modify').hide();
                        $('.info-modify-hide').removeClass('hidden');
                        $('#modify-userinfo-btn').hide().siblings('button').removeClass('hidden');

    				}
    	        }
    	        });

		});

    	$('#modify-saveuser-btn,#modify-cancleuser-btn').on('click',function () {
			$('.info-modify').show();
			$('.info-modify-hide').addClass('hidden');
			$('#modify-userinfo-btn').show().siblings().addClass('hidden');

		});
        $('.form-input-required').bind("blur",function(){
            var validform =$(this).parent().parent().find(".Validform_checktip");
            if($(this).val()==""){
                validform.addClass("Validform_wrong").text($(this).attr("nullmsg"));
            }else{
                if($(this).attr("id")!="mobileInput"){
                    validform.removeClass("Validform_wrong").addClass("Validform_right").text("通过信息验证");
                }
            }
        })
        $("#upwdNew").bind("blur",function(){
            if($("#upwdOlder").val()==""){
                return;
            }
            if($("#upwdOlder").val()==$("#upwdNew").val()){
                $("#upwdNewSpan").addClass("Validform_wrong");
                $("#upwdNewSpan").text("旧密码不能与新密码相同！");
            }
        })
    });

    function initUserInfo(){
    	$.ajax({
            type: "GET",
            url: "${ctx}/user/searchCurrentUser.do?t="+new Date().toTimeString(),
            dataType: "json",
            success: function (data) {
                $("#email").val(data.email);
                $("#siteName").text(data.siteName);
                $("#siteNameInput").val(data.siteName);
                $("#siteDomain").text(data.siteDomain);
                $("#siteDomainInput").val(data.siteDomain);
                $("#sitetypeid").val(data.siteType);
                $("#siteType").text($("#sitetypeid option:selected").text());
//                var newDate = new Date(data.createdTime);
                //var date= newDate.getFullYear()+"-"+appendZero(newDate.getMonth() + 1)+"-"+appendZero(newDate.getDate());
                var date = data.createdTime.split(" ")[0];
                $("#createdTime").text(date);
                $("#emailSpan").text(data.email);
                $("#userTypeHide").val(data.userType);
               	if(data.userType == "2"){
               		$("#userType").text("个人会员");
                }else{
                    $("#userType").text("企业客户");
                }
                $("#contacts").text(data.contacts);
                $("#contactsInput").val(data.contacts);
               	if(data.userType == "2"){
                    $("#enterpriseNameP").addClass("hidden")
               	}else{
                    $("#enterpriseNameP").removeClass("hidden")
                    if(data.enterpriseName!=null){
                        $("#enterpriseName").text(data.enterpriseName);
                        $("#enterpriseNameInput").val(data.enterpriseName);
                    }


               	}
               	if(data.emailStatus=="1"){
                    $("#emailHref").attr("href","javascript:showDialogDiv('邮箱已验证','邮箱已验证');");
                    $("#emailHref").text("邮箱已验证");

                }else{
                    $("#emailHref").attr("href","javascript:activeEmail()");
                    $("#emailHref").text("立即验证");
                }


               	$("#siteName").text(data.siteName);
               	$("#siteDomain").text(data.siteDomain);

               	if(data.userAvatar!=null&&data.userAvatar!=""){
            	   $("#showImgFace").prop("src",data.userAvatar);
               	}

               	$("#userAvatarImg").prop("src", $("#showImgFace").attr("src"));
            }
        });
    }

    function appendZero(s){return ("00"+ s).substr((s+"").length);}
   /*  function showCurrentFaceImg(){
    	 $.ajax({
             type: "GET",
             url: "${ctx}/user/searchCurrentUser.do",
             dataType: "JSON",
             success: function (data) {
                 $("#userAvatarImg").attr("src",data.userAvatar);
             }
         });
    } */

    var flag = false;


    var sendMsg2Mobile = function () {
        $("#mobileInput").trigger("blur");
        if(isMobileFlag==true){
            var mobile = $("input[name='mobile']").val();
            $.ajax({
                type: "GET",
                url: "${ctx}/user/sendReplaceMobileMsg.do?mobileAll=" + $("#areaInput").val() + mobile+"&mobile="+mobile,
                dataType: "json",
                success: function (data) {
                    if(data=="1"){
                        $("#mobileMsg").addClass("Validform_wrong").text("该手机号已使用");
                    }else if(data=="2"){
                        $("#mobileCaptchaMsg").addClass("Validform_wrong").text("验证码发送超过次数限制");
                    }else if(data=="ok"){
                        $("#mobileCaptchaMsg").removeClass("Validform_wrong").addClass("Validform_right").text("通过信息验证");
                    }

                }
            });
        }

    }


    var addAreaNum = function (areaNum) {
        $("#tel-wraper-span").html("+" + areaNum);
        $("#areaInput").val(areaNum);
        var yzm_phone_val = $("mobileInput").val();
        var regPhone=/^13[0-9]{9}$|14[0-9]{9}$|15[0-9]{9}$|17[0-9]{9}$|18[0-9]{9}$/,regWgPhone=/^\d+$/;
        if((!regPhone.test(yzm_phone_val) && areaNum=="86")||(!regWgPhone.test(yzm_phone_val) && areaNum!="86")){
            $("#mobileMsg").addClass("Validform_wrong");
            $("#mobileMsg").html("请输入正确的手机号码");
            $("#sendMsg2MobileBtn").addClass("disabled");
            isMobileFlag = false;
            return false;
        }
    }

    $("#file").fileupload({
        url:"${ctx}/fileUpload/uploadFile.do",//文件上传地址，当然也可以直接写在input的data-url属性内
       formData:{size:"5"},//如果需要额外添加参数可以在这里添加
        done:function(e,result){

            //done方法就是上传完毕的回调函数，其他回调函数可以自行查看api
            //注意result要和jquery的ajax的data参数区分，这个对象包含了整个请求信息
            //返回的数据在result.result中，假设我们服务器返回了一个json对象

            var data = result.result;
            data = JSON.parse(data);
            if(data.msgCode==undefined){
                $("#imageId").removeAttr('disabled');
                $("#checkUpload").removeClass("Validform_wrong").addClass("Validform_right");
                $("#checkUpload").html("");
                $("#userAvatarImg").prop("src", data.path);
                $("#userAvatar").val(data.path);
                $("#imageId").show();
                if (typeof (data.error) != 'undefined') {
                    if (data.error != '') {
                        alert(data.error);
                    } else {
                        alert(data.msg);
                    }

                }
            }else{
                if(data.msgCode=="0")$("#checkUpload").addClass("Validform_wrong").html("请选择图片");
                if(data.msgCode=="1")$("#checkUpload").addClass("Validform_wrong").html("图片大于5M");
                if(data.msgCode=="2")$("#checkUpload").addClass("Validform_wrong").html("图片限于jpg,png格式");
                $("#imageId").prop("disabled", true);
                $("#imageId").hide();
            }
        }
    });

    var hide = function(){
    	//${ctx}/logout.do
    	$("#changePhoneSuccessModal").modal("hide");
    }

    function saveUserInfo(){
        if(checkname()){
            var parameter ={};
            parameter["userType"]=$("#userTypeHide").val();
            parameter["contacts"]=$("#contactsInput").val();
            parameter["enterpriseName"]=$("#enterpriseNameInput").val();
            parameter["siteName"]=$("#siteNameInput").val();
            parameter["siteDomain"]=$("#siteDomainInput").val();
            parameter["siteType"]=$("#sitetypeid").val();
            $.ajax({
                type: "POST",
                url: "${ctx}/user/modifyUserInfo.do",
                data :parameter,
                dataType: "text",
                success: function (data) {
                    initUserInfo();
                }

            });
        }

	}


    function showAuthenButtonText(){
    	$.ajax({
	        type: "GET",
            url:"${ctx}/qualificationsAuthenView/getEnterpriseAuthenStatus.do?t="+new Date().toTimeString(),
	        dataType: "text",
	        success: function (data) {
                if(data==1){
                    $("#authenHref").text("资质已认证");
                    $("#authenHref").attr("href","${ctx}/qualificationsAuthenView/authenSuccess.do");
                }else if(data==2){
                    $("#authenHref").text("资质认证");
                    $("#authenHref").attr("href","${ctx}/qualificationsAuthenView/executeAuthenView.do");

                }else {
                    $("#authenHref").text("资质认证");
                    $("#authenHref").attr("href","${ctx}/qualificationsAuthenView/fillMsgView.do");
                }
	        }

        });
    }


    function showDialogDiv(title,comment){
        $("#showTitle").text(title);
        $("#dialogInfo").text(comment);
    	$("#showDialogDiv").modal('show');
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

    function activeEmail(){

        $.ajax({
            type: "GET",
            url: "${ctx}/email/sendActivateEmail.do",
            dataType: "text",
            success: function (data) {
                if(data == "Y"){
                    var email = $("#email").val();
                    showDialogDiv("验证邮件已发送","验证邮件已发送至邮箱"+email);
                    var emailDomain =email.substring(email.indexOf("@")+1);
                    $("#confirmButton").attr("href","javascript:hideshowDialogDiv('"+emailDomain+"')");
                }
            }

        });
    }
    function  checkname(){
        var name = $("#contactsInput").val();
    	var reg =/[^\u0000-\u00FF]|[A-Za-z]/.test(name);
    		if(name.length==0){
                showDialogDiv("修改信息提示","姓名不能为空");
                return false;
    	    }else{
    	    	if(!reg){
                    showDialogDiv("修改信息提示","姓名只能为字母和汉字！");
                    return false;
    	    	}
    	    }
        return true;
    }
    function recheackpwd(o){
    	var upwdNew = $("#upwdNew").val();
        var validform =$(o).parent().parent().find(".Validform_checktip");
    	if($(o).val()==""){
            validform.addClass("Validform_wrong").text($(o).attr("nullmsg"));
        }else if($(o).val()!=upwdNew){
            validform.addClass("Validform_wrong").text($(o).attr("errormsg"));
        }else if(/^(?![^a-zA-Z]+$)(?!\D+$).{8,16}$/.test($(o).val())==false) {
            validform.addClass("Validform_wrong").text("8-16位数字+字母或符号组合！");
        }else{
            validform.removeClass("Validform_wrong").addClass("Validform_right").text("通过信息验证");
        }

    }
    $("#upwdNew").bind("blur",function(){
        if(/^(?![^a-zA-Z]+$)(?!\D+$).{8,16}$/.test($(this).val())==false){
            $("#upwdNewSpan").addClass("Validform_wrong").text($("#upwdNew").attr("errormsg"));
        }else if($("#upwdNewRe").val()!=$(this).val()&&$("#upwdNewRe").val()!=""){
            $("#repwd").addClass("Validform_wrong").text($("#upwdNewRe").attr("errormsg"));
        }else{
            $("#upwdNewSpan").removeClass("Validform_wrong").addClass("Validform_right").text("通过信息验证");
        }
    })




    $("#editPhoneModal").bind("click",function(e){
        e=e||event;
        if($(e.target).attr("id")=="editPhoneClose"||$(e.target).attr("id")=="editPhoneModal"){
            $("#mobileInput").val("");
            $("#mobileMsg").text("");
            $("#mobileMsg").removeClass("Validform_wrong");
            $("#mobileMsg").removeClass("Validform_right");
            $("#uphoneCode").val("");
            $("#mobileCaptchaMsg").text("");
            $("#mobileCaptchaMsg").removeClass("Validform_wrong");
            $("#mobileCaptchaMsg").removeClass("Validform_right");
            $("#sendMsg2MobileBtn").addClass("disabled");
        }


    });
    $("#editFaceModal").bind("click",function(e){
        e=e||event;
        if($(e.target).attr("id")=="editFaceClose"||$(e.target).attr("id")=="editFaceModal"||$(e.target).attr("id")=="imageId"){
            $("#checkUpload").text("");
            $("#checkUpload").removeClass("Validform_wrong");
            $("#checkUpload").removeClass("Validform_right");
            $("#userAvatarImg").attr("src","http://static.uc.letvcloud.com/images/st-user-face-default.jpg");
        }


    });

    $("#editPwdModal").bind("click",function(e){
        e=e||event;
        if($(e.target).attr("id")=="editPwdClose"||$(e.target).attr("id")=="editPwdModal"){
            $("#upwdOlder").val("");
            $("#upwdNew").val("");
            $("#upwdNewRe").val("");
            $("#repwd").text("");
            $("#repwd").removeClass("Validform_wrong");
            $("#repwd").removeClass("Validform_right");
            $("#upwdNewSpan").text("");
            $("#upwdNewSpan").removeClass("Validform_wrong");
            $("#upwdNewSpan").removeClass("Validform_right");
            $("#passwordMsg").text("");
            $("#passwordMsg").removeClass("Validform_wrong");
            $("#passwordMsg").removeClass("Validform_right");
        }


    });
    $("#imgBtn").bind("click",function(){
        $("#file").trigger("click");
    });


</script>

</body>
</html>
<!-- file tree:
|...usercenter-zhanghao.html
| |...header-usercenter.html
| |...usercenter-header.html
| |...footer.html
- By MOKTEXT. -->