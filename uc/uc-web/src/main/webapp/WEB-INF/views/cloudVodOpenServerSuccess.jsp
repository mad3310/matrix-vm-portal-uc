<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/registerApp.css"/>
<jsp:include page="header-e.jsp"></jsp:include>
<!--head/E-->
<!-- 内容区域/S-->
<div class="container-pos-relative">
<div class="password-title text-center">
	<div class="h3">云点播服务开通</div>
	<p class="shortline"></p>
</div>
<section class="le-section-user comwidth clearfix">
<div class="service-on">
	<div class="title-service-on">
		<div class="text-center title">云点播服务开通信息确认<i class="down-arrow-ico"></i></div>
	</div>
	<div class="service-on-part1">
	<div class="row">
		<div class="pull-left service-on-left">基础服务： </div>
		<div class="le-col-4 service-on-right">云点播基础服务</div>
	</div>
	<div class="row">
		<div class="pull-left service-on-left">CDN计算：</div>
		<div class="le-col-4 service-on-right">按流量计费</div>
	</div>
	<div class="row">
		<div class="pull-left service-on-left">费用：</div>
		<div class="le-col-4 service-on-right">免费额度10G，10G以上0.1元/G起</div>
	</div>
	<div class="row">
		<div class="pull-left service-on-left">增值服务：</div>
		<div class="le-col-6">
			<div class="le-col-4 service-on-box">
				<div class="bg-whiterou text-center box">去广告</div>
				<div class="text-center">(推广期免费)</div>
			</div>
			<div class="le-col-4 service-on-box">
				<div class="bg-whiterou text-center box">logo去水印</div>
				<div class="text-center">(推广期免费)</div>
			</div>
			<div class="le-col-4 service-on-box" >
				<div class="bg-whiterou text-center box">视频门户推广</div>
				<div class="text-center">(推广期免费)</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="le-col-1 service-on-left">生效时间：</div>
		<div class="le-col-4 service-on-right">开通后实时生效</div>
	</div>
	</div>
	<p class="line"></p>
	<div class="service-on-part2">
	<div class="row service-on-chongzhi">
		<div class="pull-left service-on-left">账户余额 &nbsp;&nbsp;</div><span class="text-warning pull-left ml-10">￥ 0</span>
		<div class="le-col-5 ml-20"><a href="#" class="btn btn-danger">立即充值</a></div>
	</div>
	<div class="row text-left service-on-info text-primary">
		余额充足可保障服务超出免费额度后的正常使用
	</div>
	<div class="row pl-20 mb-10">
		<input type="checkbox" id="" class="pull-left ml-20"/><span class="pull-left ml-10">我同意《服务条款》</span>
	</div>
	<div class="row">
		<a href="javascript:;" class="btn btn-primary btn-lg btn-big ml-20" id="btn-open-service">开通服务</a>
	</div>
	</div>
</div>
</section>
<!--弹框遮罩层/S-->
<div class="layer-yao" id="div-open-service">
	<section class="lyct">
	        <div>开通云直播服务需要进行资质认证，<a href="#" class="text-primary">立即认证</a></div>
	</section>
</div>
<!--弹框遮罩层/E-->
</div>
<!-- 开通成功/S -->
<div class="modal fade" id="uploadSuccessModal" tabindex="-1" role="dialog" aria-labelledby="uploadSuccessModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width: 480px;">
    <div class="modal-content">
      <div class="modal-header modal-header-primary">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="<editPhoneModalLabel></editPhoneModalLabel>">服务开通成功</h4>
      </div>
      <!--//s上传成功-->
      <div class="modal-body" style="display: -none;">
      <div class="row text-center upload-success-tankuang-info">
      	<i class="upload-success-tankuang-icon col-sm-3" style="margin-left: 58px;"></i>
      	<p class="h4">云点播服务（按流量计费）已开通</p>
      	<p class="ml-20">15.07.01变更生效，3s后自动跳转云点播控制台</p>
      </div>
 	  <div class="row" style="padding-bottom: 54px;">
        <button type="button" class="btn btn-primary col-md-offset-4" style="padding: 6px 20px;">点播控制台</button>
        <a href="#" class="text-primary ml-10">了解更多产品>></a>
      </div>
      </div>
    </div>
  </div>
</div>
</div>
<!-- 开通成功/E -->
<!-- 内容区域/E-->
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/registerApp.js?t=20150421"></script>
</body>
</html>
<!-- file tree:
|...yundianbo-fuwu.html
|   |...header-register.html
|   |...footer.html
- By MOKTEXT. -->