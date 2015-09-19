<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
				<h3 class="title-wj">已开通服务</h3>
				<div class="service-yun bottom-line">
					<h3 class="title-wj"><i class="dianbo-ico pull-left mr10"></i>云点播</h3>
					<div class="row" style="overflow: hidden;">
						<div class="le-col-4">
							当前计费方式：${feeCode}
						</div>
						<div class="le-col-4">
							业务状态：<span id="serviceStateSpan" <c:if test="${vodState == 0}">class="text-danger"</c:if>>${state eq "0" ?"欠费":"正常"}</span>
						</div>
						<%--<c:if test="${state eq 0}">--%>
							<div id="chongzhiDiv" class="le-col-4" style="display:${state eq 0?'block':'none'}">
								<a id="btnCz" href="#" class="btn btn-danger">立即充值</a>
							</div>
						<%--</c:if>--%>
					</div>
					<div class="row">
						<div class="le-col-4">
							下月计费方式：${empty feeCodeNext or feeCodeNext eq '' ? feeCode:feeCodeNext} <a href="/serviceOpen/showServiceChange.do?serviceCode=101" class="ml-10">[更改]</a>
						</div>
					</div>
					<div class="row">
						<div class="le-col-4">
							当前存储空间： ${capacity}
						</div>
						<div class="le-col-4">
							本月累计流量： ${traffic}
						</div>
					</div>
					<div class="row">
						<div class="le-col-4">
							本月峰值带宽： ${bandwidth}
						</div>
						<%--<div class="le-col-4">--%>
						<%--本月转码时长： ${increment}分钟--%>
						<%--</div>--%>
					</div>
					</div>

				<div class="service-opened">
					<h3 class="title-wj">已开通的增值服务</h3>
					<div class="row">
						<div class="le-col-md-5 le-col-3">
							<div class="le-col-md-5 le-col-6 text-center">
								离线缓存
							</div>
							<div class="le-col-md-7 text-center le-col-6">
								<div class="opened"><i></i>已开启</div>
								<%--<div class="service-switch">--%>
								<%--<a href="#" class="btn btn-default">关闭</a>--%>
								<%--</div>--%>
							</div>
						</div>
						<div class="le-col-md-5 le-col-3 text-center">
							<div class="le-col-md-5 le-col-6">
								一键社会化分享
							</div>
							<div class="le-col-md-7 text-center le-col-6">
								<div class="opened"><i></i>已开启</div>
								<%--<div class="service-switch">--%>
								<%--<a href="#" class="btn btn-green">开启</a>--%>
								<%--</div>--%>
							</div>
						</div>
						<div class="le-col-md-5 le-col-3 text-center">
							<div class="le-col-md-5 le-col-6">
								自定义水印logo
							</div>
							<div class="le-col-md-7 text-center le-col-6">
								<div class="opened"><i></i>已开启</div>
								<%--<div class="service-switch">--%>
								<%--<a href="#" class="btn btn-green">开启</a>--%>
								<%--</div>--%>
							</div>
						</div>

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
 <script type="text/javascript">
	 document.domain = "letvcloud.com";
  $ = jQuery = require("lib/jquery.min");//jquery
  require("lib/bootstrap.min");//modal
  //充值成功
  function rechargeBackFunction(data){
	  if(data <0){
		  $("#serviceStateSpan").text("欠费").attr("class","text-danger");
		  $("#chongzhiDiv").show();
	  }else{
		  $("#serviceStateSpan").text("正常").attr("class","");
		  $("#chongzhiDiv").hide();
	  }
  }
</script>

<jsp:include page="rechargeFrame.jsp"></jsp:include>
</body>
</html><!-- file tree:
|...usercenter-myservice.html
|   |...header-usercenter.html
|   |...usercenter-header.html
|   |...footer.html
- By MOKTEXT. -->