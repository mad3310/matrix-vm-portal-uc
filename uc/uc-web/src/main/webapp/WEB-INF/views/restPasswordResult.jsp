<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/registerApp.css"/>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/usercenterApp.css"/>
<jsp:include page="header-e.jsp"></jsp:include>
<!--head/E-->
<!-- 内容区域/S-->
<div class="password-title text-center">
	<div class="h3">重置密码</div>
	<p class="shortline"></p>
</div>
<section class="le-section-user comwidth clearfix">
	<c:if test="${flag==true}">
	<div class="password-success " >
		<div class="row"><i class="icon-success-password"></i><div class="h4">重置密码成功<span class="ml-20"><span id="timeSpan">5</span>s后跳转登录页面</span></div></div>
		<div class="row mt-20">
			登录账号：${email }${mobile }
		</div>
		<div class="row mt-20">
			<button class="btn btn-primary btn-xxl" onclick="login()">立即登录</button>
		</div>
	</div>
	</c:if>
	<c:if test="${flag==false}">
	<div class="password-success ">
		<%--<div class="row"><i class="icon-user-danger" ></i><div  class="h4">重置密码失败<span class="ml-20"><span id="timeSpan">5s</span>后跳转找回密码页面</span></div></div>--%>
		<span><i class="icon-user-danger"></i><span class="h4">重置密码失败</span><span class="ml-20"></span> <span id="timeSpan">5</span>s后跳转找回密码页面</span></p>
		<div class="row mt-20">

		</div>
		<div class="row mt-20">
			<button class="btn btn-primary btn-xxl" onclick="login()">立即跳转</button>
		</div>
	</div>
	</c:if>
</section>
<!-- 内容区域/E-->
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/registerApp.js?t=20150421"></script>
<script type="text/javascript">
	$ = jQuery = require("lib/jquery.min");//jquery
</script>

<script type="text/javascript">
var count = 5;
$(function(){
	Countdown();
});
function Countdown(){
	$("#timeSpan").text(count);
	count = count -1;
	if(count>0){
		setTimeout(Countdown, 1000)
	}else{
		login();
	}
}
function login(){

	if("${flag}"=="true"){
		document.location.href ="${ctx}/login.do";
	}else{
		document.location.href ="${ctx}/restPassword/backPasswordView.do";
	}

}
</script>
</body>
</html><!-- file tree:
|...usercenter-resetPassword-success.html
|   |...header-register.html
|   |...footer.html
- By MOKTEXT. -->