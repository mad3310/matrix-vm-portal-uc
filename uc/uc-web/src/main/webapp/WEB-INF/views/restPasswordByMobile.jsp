<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="/assets/css/main/registerApp.css"/>
<link type="text/css" rel="stylesheet" href="/assets/css/main/usercenterApp.css"/>

<jsp:include page="header-e.jsp"></jsp:include>
<!--head/E-->
<!-- 内容区域/S-->
<div class="password-title text-center">
	<div class="h3">重置密码</div>
	<p class="shortline"></p>
</div>
<section class="le-section-user comwidth clearfix">
	<div class="password">
		<div class="account">联系人手机号码： ${mobile }</div>
		<div class="resetpassword-wraper">
			<form class="form-horizontal vform" action="${ctx }/restPassword/modifyPwdByMobile.do" role="form" onsubmit="return submitCheck()">
				<div class="form-group">
					<input type="hidden" value="${mobile }" name="mobile">
					<input type="hidden" value="${areaInput }" name="areaInput">
					<label for="password" class="col-sm-2 control-label"><span class="bitianxiang">*</span>输入新密码：</label>
					<div class="col-sm-5">
						<input type="password" class="form-control form-input-required form-input-required-pwd" name="password" id="password" nullmsg="请输入新密码！" errormsg="密码必须8-16位字符，且为数字+字母或符号组合！" value="">
					</div>
					<div class="col-sm-4">
						<div class="Validform_checktip" style="width: 380px;"></div>
					</div>
				</div>
				<div class="form-group">
					<label for="password" class="col-sm-2 control-label"><span class="bitianxiang">*</span>确认密码：</label>
					<div class="col-sm-5">
						<input type="password" class="form-control form-input-required form-input-required-pwd" id="password2" name="password2" recheck="password" nullmsg="请输入确认密码！" placeholder="" errormsg="您两次输入的密码不一致！">
					</div>
					<div class="col-sm-4">
						<div class="Validform_checktip" id="password2msg" style="width: 380px;"></div>
					</div>
				</div>
				<div class="form-group btn-wraper">
					<div class="col-sm-offset-2 col-sm-4">
						<button type="submit" class="btn btn-primary btn-lg">设置密码</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</section>
<!-- 内容区域/E-->
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/registerApp.js?t=20150421"></script>
<script type="text/javascript">
	$ = jQuery = require("lib/jquery.min");//jquery
	require("lib/bootstrap.min");//modal
</script>

<script type="text/javascript">
	var sumitflag= false;
	$(".form-input-required").bind("blur",function() {
		var validform = $(this).parent().parent().find(".Validform_checktip");

		if ($(this).val() == "") {
			validform.addClass("Validform_wrong").text($(this).attr("nullmsg"));
		} else if (/^(?![^a-zA-Z]+$)(?!\D+$).{8,16}$/.test($(this).val())==false) {
			validform.addClass("Validform_wrong").text($(this).attr("errormsg"));
		}else{
			validform.removeClass("Validform_wrong").addClass("Validform_right").text("通过信息验证");
		}


	});
	$("#password2").bind("blur",function(){
		if($("#password").val()!=$("#password2").val()){
			$("#password2msg").addClass("Validform_wrong").text($(this).attr("errormsg"));
		}

	});

	var submitCheck=function(){
		$(".form-input-required").trigger("blur");
		$("#password2").trigger("blur");
		if($('.Validform_wrong').size()==0){
			return true;
		}else{
			return false;
		}

	};

</script>
</body>
</html><!-- file tree:
|...usercenter-resetPassword.html
|   |...header-register.html
|   |...footer.html
- By MOKTEXT. -->