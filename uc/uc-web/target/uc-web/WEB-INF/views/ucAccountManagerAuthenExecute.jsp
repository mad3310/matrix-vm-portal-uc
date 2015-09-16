<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
				<h3 class="title-wj">资质信息认证</h3>
				<div class="zizhi-state-wj active-50 clearfix">
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
					<form class="form-horizontal" action="${ctx }/qualificationsAuthenView/saveAuthenView.do" method="post">

						 <div class="le-col-12">
							 <p class="mb-20 mt-20 pl-20"><i class="icon-user-danger"></i><span>认证信息已提交，我们将在2-3个工作日完成审核，结果将以短信、站内信等方式通知。</span></p>
						    </div>
						<div class="form-group clearfix">
						    <label for="enterpriseName" class="le-col-3 le-col-md-4 control-label">企业名称:</label>
						    <div class="le-col-5 le-col-md-6">
						       <p class="form-control-static">${user.enterpriseName }</p>
						        <input type="hidden" id="enterpriseName" name="enterpriseName" value='${user.enterpriseName }'/>
						    </div>
						</div>
						<div class="form-group clearfix">
						    <label class="le-col-3 le-col-md-3 control-label">组织机构代码:</label>
						     <div class="le-col-5 le-col-md-6">
						       <p class="form-control-static">${user.organizationCode }</p>
						    </div>
						</div>
						<div class="form-group clearfix">
						    <label class="le-col-3 le-col-md-3 control-label">企业营业执照注册号:</label>
						     <div class="le-col-5 le-col-md-6">
						       <p class="form-control-static">${user.businessLicenseRegisterNum }</p>
						    </div>
						</div>
						<div class="form-group clearfix">
						    <label for="businessLicense" class="le-col-3 le-col-md-3 control-label">营业执照：</label>
						    <div class="le-col-6 le-col-md-7">
						       <div class="row clearfix">
						       	   <div class="le-col-4">
							       	  <p class="zizhi-yyzz-face-wj" style="border: 0px;">
							       	  	<!-- <span>暂未<br/>上传</span> -->
							       	  	<img id="businessLicense" src="${user.businessLicense}" />
							       	  </p>
							       </div>
							       <div class="le-col-8">
									  <div class="clearfix">
										<div class="le-file-input-box pull-left clearfix">
											<input type="hidden" name="businessLicense" value="${user.businessLicense }" />
										</div>
										<div class="Validform_checktip pull-left"></div>
									  </div>
							       </div>
						       </div>
						    </div>
						</div>
						<div class="form-group clearfix">
						    <label class="le-col-3 le-col-md-3 control-label">所在地：</label>
						    <div class="le-col-4 le-col-md-6">
								<p class="form-control-static">${areaName1 } ${areaName2 } ${areaName3 }</p>

						    </div>
						    <div class="le-col-5 le-col-md-3"><div class="Validform_checktip"></div></div>
						</div>
						<div class="form-group clearfix">
						    <label  class="le-col-3 le-col-md-3 control-label">企业地址：</label>
							<div class="le-col-5 le-col-md-6" style="width: 50%;">
						       <p class="form-control-static">${user.address }</p>
						    </div>
						</div>
						<div class="form-group">
							<div class="le-col-9 le-col-offset-3">
								<input type="button" onclick="showDialogDiv('确认修改认证信息','修改并提交后将重走审核流程')" class="btn btn-primary btn-xll mt-20" value="修改信息" />
							</div>
						</div>
					</form>
				</div>


			</div>
		</div>
		<!-- 左侧/E-->
	</div>
</section>
<!-- 中部内容/E-->
<!-- 提示-->
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
						<a href="${ctx}/qualificationsAuthenView/fillMsgView.do"><button class="btn btn-primary btn-xl">确定</button></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:hideshowDialogDiv()"><button class="btn btn-primary btn-xl">取消</button></a>
						<%--  确定 --%>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/usercenterApp.js?t=20150421"></script>
<script type="text/javascript">
	$ = jQuery = require("lib/jquery.min");//jquery
	require("lib/bootstrap.min");//modal
</script>
<script type="text/javascript">
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
|...usercenter-zizhi-b.html
|   |...header-usercenter.html
|   |...usercenter-header.html
|   |...footer.html
- By MOKTEXT. -->