<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/usercenterApp.css"/>

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
				<h3 class="title-wj">已开通服务</h3>
				<div class="service-yun no-bottom">
					<h3 class="title-wj"><i class="cdn-ico pull-left mr10"></i>CDN</h3>
					<div class="row">
						<div class="le-col-6 padding-service le-col-md-10">
							<div class="title-wj bottom-line">
								<div class="short-line">云点播CDN</div>
							</div>
							<div class="row">
								<div class="le-col-6">当前计费方式：<c:if test="${billServiceOpenOnDemand.feeCodeNow == '001'}">
									按流量
								</c:if>
									<c:if test="${billServiceOpenOnDemand.feeCodeNow == '002'}">
										按带宽
									</c:if>
								</div>
								<div class="le-col-6">业务状态：<c:if test="${billServiceOpenOnDemand.amountState == '0'}">
									欠费
								</c:if>

									<c:if test="${billServiceOpenOnDemand.amountState == '1'}">
										正常
									</c:if>
								</div>
							</div>
							<div class="row">
								<div class="le-col-6">下月计费方式：<c:if test="${billServiceOpenOnDemand.feeCodeNext == '001'}">
									按流量
								</c:if>
									<c:if test="${billServiceOpenOnDemand.feeCodeNext == '002'}">
										按带宽
									</c:if> <a href="${ctx}/businessView/modifyBillWayView.do?featherCode=${billServiceOpenOnDemand.featherCode}&serviceCode=${billServiceOpenOnDemand.serviceCode}" class="ml-10">[更改]</a>
								</div>
							</div>
							<div class="row">
								<div class="le-col-6">本月累计流量： 200G</div>
								<div class="le-col-6">本月峰值带宽： 2000G</div>
							</div>
						</div>
						<div class="le-col-6 padding-service le-col-md-10">
							<div class="title-wj bottom-line">
								<div class="short-line">云直播CDN</div>
							</div>
							<div class="row">
								<div class="le-col-6">当前计费方式：<c:if test="${billServiceOpenLive.feeCodeNow == '001'}">
									按流量
								</c:if>
									<c:if test="${billServiceOpenLive.feeCodeNow == '002'}">
										按带宽
									</c:if></div>
								<div class="le-col-6">业务状态：<span class="text-danger">
									<c:if test="${billServiceOpenLive.amountState == '0'}">
										欠费
									</c:if>

									<c:if test="${billServiceOpenLive.amountState == '1'}">
										正常
									</c:if></span>
								</div>
							</div>
							<div class="row">
								<div class="le-col-6">下月计费方式：<c:if test="${billServiceOpenLive.feeCodeNext == '001'}">
									按流量
								</c:if>
									<c:if test="${billServiceOpenLive.feeCodeNext == '002'}">
										按带宽
									</c:if> <a href="${ctx}/businessView/modifyBillWayView.do?featherCode=${billServiceOpenLive.featherCode}&serviceCode=${billServiceOpenLive.serviceCode}" class="ml-10">[更改]</a>
								</div>
							</div>
							<div class="row">
								<div class="le-col-6">本月累计流量： 200G</div>
								<div class="le-col-6">本月峰值带宽： 2000G</div>
							</div>
						</div>
						<div class="le-col-12 le-col-md-10 mt-20">
							<a href="#" class="btn btn-danger pull-right mr20">立即充值</a>
						</div>
					</div>
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
|...usercenter-myservice-cdn.html
|   |...header-usercenter.html
|   |...usercenter-header.html
|   |...footer.html
- By MOKTEXT. -->