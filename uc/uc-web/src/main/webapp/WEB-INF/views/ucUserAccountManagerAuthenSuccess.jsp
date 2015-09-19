<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="/assets/css/main/usercenterApp.css"/>

<jsp:include page="header-e.jsp"></jsp:include>
<!-- 顶部head/E-->
<!-- 中部内容/S-->
<section class="le-user-main comwidth clearfix">
	<div class="le-user-warp clearfix" id="usercenter">
		<!-- 左侧/S-->
		<%@include file="ucLeft.jsp" %>
		<!-- 左侧/E-->
		<!-- 右侧/S-->
		<div class="le-user-box clearfix" id="userbox">
			<div class="le-user-con clearfix">
				<h3 class="title-wj">资质信息认证</h3>
				<div class="zizhi-state-wj active-100 clearfix">
					<em class="zz-now"></em>
					<div class="zz-left">
						<i class="icon-user-zz-state"></i>
						<p>填写资质信息</p>
					</div>
					<div class="zz-center">
						<i class="icon-user-zz-state"></i>
						<p>认证审核</p>
					</div>
					<div class="zz-right">
						<i class="icon-user-zz-state"></i>
						<p>认证成功</p>
					</div>
				</div>
				<div class="zizhi-edit-wj clearfix" style="padding-top:0px">
					<form class="form-horizontal" action="" method="">
				     	<div class="form-group clearfix">
						    <label  class="le-col-3 le-col-md-4 control-label">真实姓名：</label>
						    <div class="le-col-5 le-col-md-6">
						      <p class="form-control-static">${user.contacts }</p>
						    </div>
						</div>
						<div class="form-group clearfix">
						    <label  class="le-col-3 le-col-md-4 control-label">身份证号：</label>
						    <div class="le-col-5 le-col-md-6">
						      <p class="form-control-static">${user.idCard }</p>
						    </div>
						</div>
						<div class="form-group clearfix">
						    <label  class="le-col-3 le-col-md-4 control-label">身份证：</label>
						    <div class="le-col-5 le-col-md-6">
						       <p><img src="${user.idCardPhoto }" alt="身份证" class="zizhi-card-img-wj" /></p>
						    </div>
						</div>

						<div class="form-group clearfix">
						    <label  class="le-col-3 le-col-md-4 control-label">联系地址：</label>
						    <div class="le-col-5 le-col-md-6" style="width: 50%;">
						       <p class="form-control-static">${user.address }</p>
						    </div>
						</div>
						<%--<div class="form-group">--%>
							<%--<div class="le-col-9 le-col-md-8 le-col-offset-3 le-col-md-offset-4">--%>
						      <%--<a href="${ctx }/qualificationsAuthenView/fillMsgView.do" class="btn btn-primary btn-xll mt-20">修改资质内容</a>--%>
						    <%--</div>--%>
						<%--</div>--%>
					</form>
				</div>
			</div>
		</div>
		<!-- 左侧/E-->
	</div>
</section>
<!-- 中部内容/E-->
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/usercenterApp.js?t=20150421"></script>
</body>
</html><!-- file tree:
|...usercenter-zizhi-c.html
|   |...header-usercenter.html
|   |...usercenter-header.html
|   |...footer.html
- By MOKTEXT. -->