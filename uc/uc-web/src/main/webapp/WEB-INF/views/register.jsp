<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="/assets/css/main/zhuceApp.css"/>
<link type="text/css" rel="stylesheet" href="/assets/css/main/usercenterApp.css"/>
<%--<link type="text/css" rel="stylesheet" href="/assets/css/main/registerApp.css"/>--%>
<style type="text/css">
  .btn-yzm.disabled {
    pointer-events: none;
   cursor: not-allowed;
    filter: alpha(opacity = 65);
    -webkit-box-shadow: none;
    box-shadow: none;
    opacity: .65;
     }
  .form-con li .info{
	  height:45px;
  }
	.icon-changer1{
		vertical-align: middle;
		background-size: 100%;
		position: relative;
		left: 10px;
		background-position: 0 -20px;
	}
	.yam-changer1{
		height: 30px;
		top: -5px;
		position: relative;
		left: 5px;
		vertical-align: middle;
	}
	.tschanger1{
		vertical-align: middle;
	}
  .form-con li .info .input-long{
      width: 400px !important;
  }

</style>
<jsp:include page="header-e.jsp"></jsp:include>
	<!--head/E-->
	<!--title/S-->
	<h1 class="title-zhuce">
		<p>新用户注册</p>

		<p>
			<span class="line"></span>
		</p>
	</h1>
	<!--title/E-->
	<!--main /S-->

	<div class="comwidth clearfix">
		<form id="registerForm" class="vform form-sms"
			action="${ctx}/register/registerUser.do" method="post">
			<div class="form-con">
				<ul class="clearfix">
					<li>
						<div class="type">
							<i>*</i>登录邮箱：
						</div>
						<div class="info">
							<span class="pull-left"> <input type="text" name="email"
								placeholder="用于登录及密码找回"
								class="input-long form-input-required form-input-required-email"
								id="Email" onblur="checkEmail(this.value)"  autocomplete="off">
							</span> <span class="Validform_checktip ml-15" id="emailMsg"></span>
						</div>
					</li>
					<li>
						<div class="type">
							<i>*</i>密<span  style="padding-left:30px" class="pl-34"></span>码：
						</div>
						<div class="info">
							<span class="pull-left"> <input type="password"
								name="password" id="Password1" placeholder="8-16字符，数字+字母或符号组合"
								class="input-long form-input-required form-input-required-pwd"
								onblur="OnePwdIsTrue(this.value)">
							</span> <span id="onepwd" class="Validform_checktip ml-15"></span>
						</div>
					</li>
					<li>
						<div class="type">
							<i>*</i>确认密码：
						</div>
						<div class="info">
							<span class="pull-left" onclick=""> <input type="password"
								name="Password2" id="Password2" recheck="password"
								placeholder="再次输入密码" value=""
								class="input-long form-input-required"
								onblur="ConfirmPassWord()">
							</span> <span id="doublepwd" class="Validform_checktip ml-15"></span>
						</div>
					</li>

				</ul>
			</div>
			<div class="form-con">
				<ul class="clearfix">
					<li>
						<div class="type">
							<i>*</i>会员类型：
						</div>
						<div class="info">
							<input type="hidden" id="userType" name="userType" value="2">
							<div class="label-txt" onclick="setUserType(2)" >
								<input name="radioType" type="radio"
									value="2" /><span class="txt">个人会员</span>
							</div>
							<div class="label-txt"  onclick="setUserType(3)" >
								<input name="radioType" type="radio"
									 value="3" /><span class="txt">企业会员</span>
							</div>
						</div>
					</li>
					<li id="vip_company" class="hide">
						<div class="type">
							<i>*</i>企业名称：
						</div>
						<div class="info">
							<span class="pull-left"> <input type="text"
								name="enterpriseName" placeholder="请输入您的企业全称，最多50字符" value=""
								class="input-long form-input-required"
								onblur="checkcompanyname(this.value)">
							</span> <span id="companyname" class="Validform_checktip ml-15"></span>
						</div>
					</li>

					<li>
						<div class="type">
							<i>*</i>联系人姓名：
						</div>
						<div class="info">
							<span class="pull-left"> <input type="text"
								name="contacts" placeholder="请输入真实姓名，支持汉字、字母，最多20字符"
								class="input-long form-input-required"
								onblur="checkname(this.value)" id="relname" maxlength="20">
							</span> <span id="checkname" class="Validform_checktip ml-15"></span>
						</div>
					</li>

					<li>
						<div class="type">
							<i>*</i>国家/地区：
						</div>
						<div class="info">
							<select style="width:232px;" name="CountryCode" class="select" onchange="addAreaNum(this.value)">


								<c:forEach var="country" items="${countryList}">
									<option value="${country.countryAreaNum}">${country.countryName}</option>
								</c:forEach>


							</select>
						</div>
					</li>
					<li>
						<div class="type">
							<i>*</i>联系人手机号：
						</div>
						<div class="info">
							<span class="pull-left tel-wraper tel-wraper-register" style="width: 400px;"> <input
								id="areaInput" type="hidden" value="86"> <span
								class="pull-left clear-left" id="tel-wraper-span" style="height:30px;line-height:30px;top:0;" >+86</span>
								<input style="height:30px;line-height:30px;"
									   type="text" name="mobile" id="mobile"
								placeholder="请输入真实手机号，用于接收业务信息"
								class="form-control form-input-required form-input-required-phone form-sms-phone"
								onblur="checkMobile(this.value)">


							</span> <span class="Validform_checktip ml-15" id="mobileError"></span>
						</div>
					</li>
					<li>
						<div class="type"><i>*</i>图形验证码：</div>
						<div class="info">
							<input type="text" class="input-240 form-input-required" placeholder="请先输入图形验证码"
								   name="captchaCode" id="captchaCode" maxlength="4" onblur="graphCheck();"  autocomplete="off"/>
							<span class="yzm yam-changer1">
                   				<img src="${ctx}/captcha/createCaptchaForPhone.do" id="captcha">
							</span>
							<span class="icon-view icon-refresh icon-changer1" id="captchaRefresh"></span>
							<span class="Validform_checktip ml-15 tschanger1" id="yzmError"></span>
						</div>
					</li>
					<li>
						<div class="type">
							<i>*</i>手机验证码：
						</div>
						<div class="info">
							<span class="pull-left"> <input type="text" name="name"
								placeholder="6位数字" class="input-240 form-input-required"
								onblur="checkMobileCode(this.value)"  autocomplete="off" id="mobilecode">
								<button type="button" class="btn-yzm link-white btn-sms-code disabled"
									onclick="sendMsg2Mobile();">免费获取验证码</button> <!-- <a href="javascript:;" class="btn-yzm link-white btn-sms-code">免费获取验证码</a> -->
							</span> <span class="Validform_checktip ml-15" id="codeError"></span>
						</div>
					</li>
					<li>
						<div class="type">
							<i>*</i>网站类型：
						</div>
						<div class="info">
							<select style="width:232px;" class="select" name="siteType">
								<option value="3">综合门户</option>
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
						</div>
					</li>
					<li>
						<div class="type">网站名称：</div>
						<div class="info">
							<span class="pull-left"> <input type="text"
								name="siteName" placeholder="输入应用视频网站名称" class="input-long"
								onblur="checknet(this.value)" id="siteName" maxlength="50">
							</span> <span id="netname" class="Validform_checktip ml-15"></span>
						</div>
					</li>
					<li>
						<div class="type">网站域名：</div>
						<div class="info">
							<span class="pull-left"> <input type="text"
								name="siteDomain" placeholder="输入应用视频网站名称" class="input-long"
								onblur="checkwww(this.value)" id="siteDomain" maxlength="50">
							</span> <span id="www" class="Validform_checktip ml-15"></span>
						</div>
					</li>
				</ul>
				<div class="btn-con">
					<input type="button" style="width:115px" class="btn-zhuce link-white" value="注册"
						onclick="registerSubmit();" id="registerSubmitBtn" /> <span><input
						type="checkbox" name="remember" id="remember" class="check" checked>创建账号的同时，我同意：<a target="_blank"
						href="http://help.letvcloud.com/Wiki.jsp?page=Protocol" class="link-light-blue">乐视云服务协议</a></span> <span
						class="Validform_checktip ml-15" id="rememberMsg"></span>
				</div>
			</div>
		</form>
	</div>
	<!--main /E-->
	<!-- 引入底部foot-->
	<!-- footer/S-->
    <jsp:include page="footerdiv.jsp"></jsp:include>
	<!-- footer/E-->
	<script type="text/javascript" src="http://static.uc.letvcloud.com/js/main/zhuceApp.js"></script>
	<script type="text/javascript">
		$ = jQuery = require("lib/jquery.min");//jquery
	</script>

	<script type="text/javascript">
		//var flag = true;
		var from_flag_a = false, from_flag_b = false, from_flag_c = false, from_flag_m = false, from_flag_n = false, from_flag_p = false;

		var viewErrorMsg = function(elementId, msg) {
			$(elementId).addClass("Validform_wrong").html(msg);
		}
		var viewSuccessMsg = function(elementId, msg) {
			$(elementId).removeClass("Validform_wrong").addClass(
					"Validform_right").html(msg);
		}

		var sendMsg2Mobile = function() {
			if(!yzmFlag){
				viewErrorMsg("#yzmError", "验证码不正确！");
				return
			}

			var mobile = $("input[name='mobile']").val();
			$.ajax({
				type : "GET",
				url : "${ctx}/user/sendMsgCheckYzm.do?yzm="+$("#captchaCode").val()
						+"&countryCode=" + $("#areaInput").val()
						+ "&mobile=" + mobile,
				dataType : "text",
				success : function(data){
					if(data != "ok"){
						if(data == "1"){
							viewErrorMsg("#mobileError", "该手机号已注册！");
						}else if(data == "2"){
							viewErrorMsg("#mobileError", "超出每日发送限制！");
						}

					}
					if(data == "N"){
						viewErrorMsg("#yzmError", "验证码不正确！");
					}
					if(data == "ok"){
						activeSendMsgBtnFlag = false;
						setTimeout('activeSendMsgBtnFlag=true',60000);

					}

				}
			});
		}

		var checkMobile = function(mobile) {
            if(mobile==""){
                return;
            }
            var areaInput = $("#areaInput").val();
			$.ajax({
				type : "GET",
				url : "${ctx}/user/isMobileNum.do?mobileNum=" + mobile+"&countryCode="+areaInput,
				dataType : "text",
				success : function(data) {
					if (data != "Y") {
						viewErrorMsg("#mobileError", "请输入正确的手机号码！");
						//flag = false;
						from_flag_a = false;
					} else {
						from_flag_a=checkMobileIsExist(mobile);
					}
				}
			});
			return from_flag_a;
		}

		$(".btn-yzm.link-white.btn-sms-code").mouseover(function(){
			var mobile = $("#mobile").val();
			var areaInput = $("#areaInput").val();
			if(mobile == null || mobile == ''){
				return;
			}
//			checkMobileIsExist(mobile);
			$.ajax({
				type : "GET",
				url : "${ctx}/user/mobileIsExist.do?mobile=" + mobile+"&countryCode="+areaInput,
				dataType : "text",
				async: false,
				success : function(data) {
					if (data == 'Y') {
						//加入手机号已被注册使用
						//                    $("#mobileError").addClass("Validform_wrong").html("你的手机号已被注册");
						viewErrorMsg("#mobileError", "您的手机号已被注册！")
						//flag = false;
						$(".btn-yzm.link-white.btn-sms-code ").addClass("disabled");
						from_flag_a = false;
					}else if (data == 'P') {
                        //加入手机号已被注册使用
                        //                    $("#mobileError").addClass("Validform_wrong").html("你的手机号已被注册");
                        viewErrorMsg("#mobileError", "休息半个小时再来注册！")
                        //flag = false;
                        $(".btn-yzm.link-white.btn-sms-code ").addClass("disabled");
                        from_flag_a = false;
                    }
				}
			});
		});

		var checkMobileIsExist = function(mobile) {
            var areaInput = $("#areaInput").val();
			$.ajax({
				type : "GET",
				url : "${ctx}/user/mobileIsExist.do?mobile=" + mobile+"&countryCode="+areaInput,
				dataType : "text",
				async: false,
				success : function(data) {
					if (data == 'Y') {
						//加入手机号已被注册使用
						//                    $("#mobileError").addClass("Validform_wrong").html("你的手机号已被注册");
						viewErrorMsg("#mobileError", "您的手机号已被注册！")
						//flag = false;
						$(".btn-yzm.link-white.btn-sms-code ").addClass("disabled");
						from_flag_a = false;
					} else if(data == 'N'){
						viewSuccessMsg("#mobileError", "通过信息验证！");
						//$(".btn-yzm.link-white.btn-sms-code ").removeClass("disabled");
						from_flag_a = true;
					}else{
						viewErrorMsg("#mobileError", "您已在半小时内查询超过10次，请在半小时后重试！")
						//flag = false;
						$(".btn-yzm.link-white.btn-sms-code ").addClass("disabled");
						from_flag_a = false;
					}
				}
			});
			return from_flag_a;
		}

		var checkEmail = function(email) {
			if(email.length == 0){
				viewErrorMsg("#emailMsg", "请输入正确的邮箱！");
				from_flag_b = false;
				return;
			}
			$.ajax({
				type : "GET",
				url : "${ctx}/user/isEmail.do?email=" + email,
				dataType : "text",
				success : function(data) {
					if (data != 'Y') {
						viewErrorMsg("#emailMsg", "请输入正确的邮箱！");
						//flag = false;
						from_flag_b = false;
					} else {
						from_flag_b=checkEmailIsExist(email);
					}
				}
			});
			return from_flag_b;
		}
	 	function setUserType(v) {
			$("input[name='userType']").val(v);
		}

		var checkEmailIsExist = function(email) {
			$.ajax({
				type : "GET",
				url : "${ctx}/user/emailIsExist.do?email=" + email,
				dataType : "text",
				async: false,
				success : function(data) {
					if (data == 'Y') {
						viewErrorMsg("#emailMsg", "您的邮箱已存在！");
						from_flag_b = false;
					} else if(data == 'N'){
						viewSuccessMsg("#emailMsg", "通过信息验证！");
						from_flag_b = true;
					}else{
						viewErrorMsg("#emailMsg", "您已在半小时内查询超过10次，请在半小时后重试！");
						from_flag_b = false;
					}
				}
			});
			return from_flag_b;
		}

		var checkMobileCode = function(mobileCode) {
			var mobile = $("#areaInput").val() + $("#mobile").val();
            if(mobileCode == ""){
                return;
            }
			if (mobileCode == null || mobileCode == "") {
				viewErrorMsg("#codeError", "手机验证码错误！");
				return false;
			} else {
				$.ajax({
					type : "GET",
					url : "${ctx}/user/checkMobileCode.do?checkCode="
							+ mobileCode + "&mobile=" + mobile,
					dataType : "text",
					success : function(data) {
						if (data == 'N') {
							viewErrorMsg("#codeError", "手机验证码错误！");
							from_flag_c = false;
						} else if(data == 'Y'){
							viewSuccessMsg("#codeError", "通过信息验证！");
							from_flag_c = true;
						}else if(data =='P'){
							viewErrorMsg("#codeError", "手机验证码错误超过10次，请休息半个小时后重试。");
							from_flag_c = false;
						}
					}
				});
					return from_flag_c;
			}

		}

		var addAreaNum = function(areaNum) {
			$("#tel-wraper-span").html("+" + areaNum);
			$("#areaInput").val(areaNum);
			$("#codeError").text("");
			$("#codeError").removeClass("Validform_wrong");
			$("#codeError").removeClass("Validform_right");
			from_flag_c = false;
			$("#mobilecode").trigger("blur");
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

		var from_flag_d = false;
		var registerSubmit = function() {
			if ($("#remember")[0].checked == true) {
				viewSuccessMsg("#rememberMsg", "同意协议！");
				from_flag_d = true;
			} else {
				viewErrorMsg("#rememberMsg", "尚未同意协议！");
                from_flag_d = false;
			}
			if (from_flag_a && from_flag_b && from_flag_c && from_flag_d && from_flag_n && from_flag_m && (from_flag_p || $("#userType").val() == 2)) {
				var reg	= checkEmail($("#Email").val())&ConfirmPassWord()&checkname($("#relname").val())
						&checkMobileCode($("#mobilecode").val())&from_flag_d;
				if(reg){
                    $("#registerSubmitBtn").attr("disabled",true);
					$("#registerForm").submit();
				}else{
					return false;
				}
				//$("#registerForm").submit();
			}
		}

		//8-16字符，数字+字母或符号组合
		function OnePwdIsTrue(pwd) {
			if(pwd.length == 0){
				viewErrorMsg("#onepwd", "密码必须8-16位字符，且为数字+字母或符号组合！");
				return false;
			}
			if (8 > pwd.length || pwd.length > 16 || pwd.length == 0) {
				viewErrorMsg("#onepwd", "密码必须8-16位字符，且为数字+字母或符号组合！");
				return false;
			}

			if(!checkPwd(pwd)){
		          viewErrorMsg("#onepwd", "密码必须8-16位字符，且为数字+字母或符号组合！");
		          return false ;
			  }else{
				viewSuccessMsg("#onepwd", "密码通过！");
				return true;
			}
		}

		//确认密码
		function ConfirmPassWord() {
			var pwd1 = $("#Password1").val();
			var pwd2 = $("#Password2").val();
			from_flag_m = false;
			if(pwd2.length == 0){
				viewErrorMsg("#doublepwd", "密码必须8-16位字符，且为数字+字母或符号组合！");
				return from_flag_m;
			}

			if (8 > pwd2.length || pwd2.length > 16) {
				viewErrorMsg("#doublepwd", "密码必须8-16位字符，且为数字+字母或符号组合！");
				return from_flag_m;
			}
			if (pwd1 == pwd2) {
				viewSuccessMsg("#doublepwd", "密码确认通过！");
				from_flag_m = true;
			} else {
				viewErrorMsg("#doublepwd", "两次输入的密码不一致！");
			}
			if(!checkPwd(pwd2)){
		          viewErrorMsg("#doublepwd", "密码必须8-16位字符，且为数字+字母或符号组合！");
		          return false ;
			}
			return from_flag_m;
		}
		//密码格式校验校验
		function checkPwd(pwd){
            if(pwd.length<8||pwd.length>16){
                return false;
            }
            var istrue = false;
            for(var i =0;i<pwd.length;i++){
                if((pwd[i].charCodeAt())<48||(pwd[i].charCodeAt())>57){
                    if(pwd[i]!=" "){
                        istrue=true;
                        break;
                    }
                }
            }
            if(!istrue){
                return false;
            }
            var haveNum = false;
            for(var i =0;i<pwd.length;i++){
                if((pwd[i].charCodeAt())>=48 && (pwd[i].charCodeAt())<=57){
                    haveNum = true;
                }
            }
            if(!haveNum){
                return false;
            }
            return true;
		}

		function checkname(name) {
			var reg = /[^\u0000-\u00FF]|[A-Za-z]/.test(name);
			//$("#checkname").html("");
			from_flag_n = false;
			if (name.length == 0) {
				viewErrorMsg("#checkname", "请输入联系人姓名！");
				return false;
			} else if (name.length >= 20) {
				viewErrorMsg("#checkname", "姓名最多20字符！");
			} else {
				if (!reg) {
					viewErrorMsg("#checkname", "姓名只可为字母和汉字！");
				} else {
					viewSuccessMsg("#checkname", "姓名确认通过！");
					from_flag_n = true;
				}
			}
			return from_flag_n;
		}
		function checkcompanyname(name) {
			var reg = /[^\u0000-\u00FF]|[A-Za-z]/.test(name);
			$("#checkname").html("");
			from_flag_p = false;
			if (name.length == 0) {
				viewErrorMsg("#companyname", "企业名称不为空！");
			} else if (name.length >= 50) {
				viewErrorMsg("#companyname", "企业名称最多50字符！");
			} else {
				if (!reg) {
					viewErrorMsg("#companyname", "企业名称只可为字母和汉字！");
				} else {
					viewSuccessMsg("#companyname", "企业名称确认通过！");
					from_flag_p = true;
				}
			}
			return from_flag_p;
		}
		function checknet(netname) {
			var reg = /[^\u0000-\u00FF]|[A-Za-z]/.test(netname);

			if (netname.length >= 50) {
				viewErrorMsg("#netname", "网站名称长度不能超过50！");
				return false;
			}else if(!reg && netname!=""){
				viewErrorMsg("#netname", "网站名称只为汉字或字母！");
				return false;
			} else if(netname == null || netname == ""){
				//donothing
			} else {
				viewSuccessMsg("#netname", "通过信息验证！");
				return true;
			}
		}
		function checkwww(www) {
			var re = /[^\u0000-\u00FF]/;
			if (www.length >= 50) {
				viewErrorMsg("#www", "网站域名长度不能超过50！");
				return false;
			} else if (re.test(www)) {
				viewErrorMsg("#www", "网站域名格式不正确！");
				return false;
			} else if(www == null || www == ""){
				//donothing
			}	else {
				viewSuccessMsg("#www", "通过信息验证！");
				return true;
			}
		}
		var activeSendMsgBtnFlag = true;
		var yzmFlag = false;
		function graphCheck(){

			var code = $("#captchaCode").val();
            if(code==""){
                return;
            }
			yzmFlag = false;

			if(code.length != 4){
				viewErrorMsg("#yzmError", "图片验证码不正确！");
				return;
			}
			$.ajax({
				type : "GET",
				url : "${ctx}/captcha/checkCaptchaForPhone.do?captchaCode=" + code,
				dataType : "text",
				success : function(data){
					if(data == "Y"){
						viewSuccessMsg("#yzmError", "验证码通过！");
						yzmFlag = true;
						if(activeSendMsgBtnFlag){
							$(".btn-yzm.link-white.btn-sms-code").removeClass("disabled");
						}else{
							return;
						}
					}else{
						$(".btn-yzm.link-white.btn-sms-code").addClass("disabled");
						yzmFlag = false;
						viewErrorMsg("#yzmError", "图片验证码不正确！");
					}
				}
			});

		}
		$(function(){
			$(".btn-yzm.link-white.btn-sms-code").addClass("disabled","true");
			$("#captchaRefresh").click(function(){
				$("#captcha").attr('src', '${ctx}/captcha/createCaptchaForPhone.do?date=' + new Date());
			});
		})



//		function checkForm() {
//		var reg	= checkEmail($("#Email").val())&ConfirmPassWord()&checkname($("#relname").val())&checkMobile($("#mobile").val())
//		&checkMobileCode($("#mobilecode").val())&from_flag_d;
//			if (reg) {
//				return true;
//			}else{
//				return false;
//			}
//
//		}

	</script>
</body>


</html>
<!-- file tree:
|...zhuce.html
| |...header-zhuce.html
| |...footer.html
- By MOKTEXT. -->
