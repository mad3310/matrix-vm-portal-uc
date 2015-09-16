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
		<div class="row"><i class="icon-success-password"></i><div class="h4">注册成功<span class="ml-20">恭喜你成为乐视云计算会员</span></div></div>
		<div class="row mt-20">
			登录账号：${email}
		</div>
		<div class="row mt-20">
			<button class="btn btn-primary btn-xl" onclick="activeEmail();">验证邮箱</button>
			<button class="btn btn-primary btn-xl ml-40" onclick="gotoMain();">立即登录</button>
		</div>
	</div>
</section>
<!-- 已认证通过不允许修改账号信息 -->
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
						<a href="javascript:hideshowDialogDiv()"><button class="btn btn-primary btn-xl">确定</button></a>
						<%--  确定 --%>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
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
	var gotoMain = function(){
		window.location.href = "${ctx }/userView/ucOverview.do";
	}

	function activeEmail(){
		$(".btn.btn-primary.btn-xl").addClass("disabled","true");
		$.ajax({
			type: "GET",
			url: "${ctx}/email/sendActivateEmail.do",
			dataType: "text",
			success: function (data) {
				$(".btn.btn-primary.btn-xl").removeClass("disabled");
				if(data == "Y"){
					showDialogDiv("验证邮件已发送","验证邮件已发送至邮箱${email}");
				}else{
					console.info("发送失败！");
				}
			},error:function (){
                $(".btn.btn-primary.btn-xl").removeClass("disabled");
            }

		});
	}

	function showDialogDiv(title,comment){
		$("#showTitle").text(title);
		$("#dialogInfo").text(comment);
		$("#showDialogDiv").modal('show');
	}
	function hideshowDialogDiv(){
		$("#showDialogDiv").modal('hide');
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