<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/registerApp.css"/>

<jsp:include page="header-e.jsp"></jsp:include>
<!--head/E-->
<!-- 内容区域/S-->
<div class="password-title text-center">
	<div class="h3">新用户注册</div>
	<p class="shortline"></p>
</div>
<section class="le-section-user comwidth clearfix">
	<div class="password-success">
		<!--icon-success-password-->
		<div class="row"><i class="icon-user-danger"></i>
			<%--<div class="h4">--%>
				注册失败<span class="ml-20">${errorMsg}</span>
			<%--</div>--%>
		</div>
		<%--<div class="row mt-20">--%>
			<%--登录账号：${email}--%>
		<%--</div>--%>
		<div class="row mt-20">
			<button class="btn btn-primary btn-xl" onclick="gotoReqister();">重新注册</button>
			<button class="btn btn-primary btn-xl ml-40" onclick="gotoLogin();">立即登录</button>
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
</script>

<script type="text/javascript">
	var gotoReqister = function(){
		window.location.href = "${ctx }/registerView/registerUserView.do";
	}
	var gotoLogin = function(){
		window.location.href = "${ctx }/login.do";
	}
</script>
</body>
</html><!-- file tree:
|...usercenter-zhuce-success.html
|   |...header-s.html
|   |...header-e.html
|   |...usercenter-header-unlogin.html
|   |...footer.html
- By MOKTEXT. -->