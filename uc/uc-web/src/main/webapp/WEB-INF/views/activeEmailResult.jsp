<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/usercenterApp.css"/>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/registerApp.css"/>
<jsp:include page="header-e.jsp"></jsp:include>
<!--head/E-->
<!-- 内容区域/S-->
<div class="password-title text-center">
	<div class="h3">邮箱激活</div>
	<p class="shortline"></p>
</div>
<section class="le-section-user comwidth clearfix">
	<div class="password-success">
		<div class="row"><i class="icon-success-password"></i><div class="h4">${activeFlag}<span class="ml-20"><span id="timeSpan">5s</span>后跳转登录页面</span></div></div>
		<div class="row mt-20">
			<button class="btn btn-primary btn-xxl" onclick="login()">立即登录</button>
		</div>
	</div>
</section>
<!-- 内容区域/E-->
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/registerApp.js?t=20150421"></script>
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/jquery-1.7.2.min.js"></script>

<script type="text/javascript">
var count = 5;
$(function(){
	Countdown();
});
function Countdown(){
	$("#timeSpan").html(count+"s");
	count = count -1;
	if(count>0){
		setTimeout(Countdown, 1000)
	}else{
		login();
	}
}
function login(){
	/* window.location.href("${ctx}/login.do"); */
	document.location.href ="${ctx}/login.do";
}
</script>
</body>
</html><!-- file tree:
|...usercenter-resetPassword-success.html
|   |...header-register.html
|   |...footer.html
- By MOKTEXT. -->