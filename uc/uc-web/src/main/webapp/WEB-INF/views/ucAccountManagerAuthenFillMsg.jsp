<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/usercenterApp.css"/>
<style>
.istyle{
	color:red; padding-right: 8px; position:relative; top:3px;
}
</style>
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
				<div class="zizhi-state-wj clearfix">
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
					<form class="form-horizontal vform" action="${ctx }/qualificationsAuthenView/executeAuthen.do" onsubmit="return checkSubmit()" method="post" enctype="multipart/form-data">
						<div class="le-col-12">
							<p class="mb-20 mt-20 pl-20"><i class="icon-user-danger" ></i><span><c:if test="${empty NOT_THROUGH}">为保证您尽快通过资质认证，请填写真实信息</c:if><c:if test="${not empty NOT_THROUGH}">您的审核信息未通过，请您修改后重新提交</c:if></span></p>
						</div>
						<div class="form-group clearfix">
						    <label for="zzName" class="le-col-3 le-col-md-3 control-label"><i class="istyle">*</i>企业名称:</label>
						    <div class="le-col-4 le-col-md-6">
						      <input type="text" class="form-control  form-input-required-s2-50" name="enterpriseName" id="zzName" nullmsg="请输入企业名称！" placeholder="乐视云计算有限公司" errormsg="企业名称为2-50字符以内" value="${user.enterpriseName}" maxlength="50"/>
						    </div>
						    <div class="le-col-5 le-col-md-3"><div class="Validform_checktip"></div></div>
						</div>
						<div class="form-group clearfix">
						    <label for="zzJgdm" class="le-col-3 le-col-md-3 control-label"><i class="istyle">*</i>组织机构代码:</label>
						    <div class="le-col-4 le-col-md-6">
						      <input type="text" class="form-control form-input-required organizationCode" id="zzJgdm" name="organizationCode" errormsg="格式为XXXXXXXX-X “X为数字”" nullmsg="请输入组织机构代码！" placeholder="格式为XXXXXXXX-X “X为数字”" value="${user.organizationCode}" />
						    </div>
						    <div class="le-col-5 le-col-md-3"><div class="Validform_checktip"></div></div>
						</div>
						<div class="form-group clearfix">
						    <label for="zzYyzch" class="le-col-3 le-col-md-3 control-label"><i class="istyle">*</i>企业营业执照注册号:</label>
						    <div class="le-col-4 le-col-md-6">
						      <input type="text" class="form-control form-input-required" id="zzYyzch" nullmsg="请输入企业营业执照注册号" name="businessLicenseRegisterNum" placeholder="请填写企业营业执照的注册号" value="${user.businessLicenseRegisterNum}" maxlength="50"/>
						    </div>
						    <div class="le-col-5 le-col-md-3"><div class="Validform_checktip"></div></div>
						</div>
						<div class="form-group clearfix">
						    <label for="uploadImage" class="le-col-3 le-col-md-3 control-label"><i class="istyle">*</i>营业执照：</label>
						    <div class="le-col-6 le-col-md-7">
						       <div class="row clearfix">
						       	   <div class="le-col-4">
							       	  <p class="zizhi-yyzz-face-wj">
								  		<c:if test="${empty user.businessLicense}"><span id="uploadSpan">暂未<br/>上传</span></c:if>
							       	  	<img src="${user.businessLicense}" id="uploadImage" <c:if test="${empty user.businessLicense}"> class="hide"</c:if>/>
							       	  </p>
							       </div>
							       <div class="le-col-8">
							       	  <p class="zizhi-info-wj">JPG,PNG的图片，文件大小不超过2M</p>
									  <p class="zizhi-info-wj"><a href="javascript:showDialogDiv2()" class="text-primary">查看营业执照上传要求</a></p>
									  <div class="clearfix">
										<div class="le-file-input-box pull-left clearfix">
											<button type="button"  id="imgBtn" class="btn btn-default btn-xl le-btn-file" >浏览上传</button>
											<input type="file" id="file" name="file" class="le-file-input" style="z-index: -1;" accept="*.jpg,*.png" value="${user.businessLicense}" />
											<input type="hidden" id="businessLicense" name="businessLicense" class="form-input-required" nullmsg="请上传图片！" value="${user.businessLicense}">
										</div>
										<!-- <input type="file" id=""file"" name="file"> -->
										<div id="checkUpload" class="Validform_checktip pull-left"></div>
									  </div>
							       </div>
						       </div>
						    </div>
						</div>
						<div class="form-group clearfix">
						    <label for="areaLevel1" class="le-col-3 le-col-md-3 control-label"><i class="istyle">*</i>所在地：</label>
						    <div class="le-col-4 le-col-md-6">
								<select class="form-control le-sg-4 from-city-a" id="areaLevel1" name="areaLevel1" onchange="findArea(this.value,'#areaLevel2')">

									<c:forEach var="areaLevel1" items="${areaLevel1}">
										<option value="${areaLevel1.id}" <c:if test="${areaLevel1.id==user.areaLevel1}">selected="selected"</c:if>>${areaLevel1.areaName}</option>
									</c:forEach>
								</select>
								<select class="form-control le-sg-4 from-city-b" id="areaLevel2" name="areaLevel2" onchange="findArea(this.value,'#areaLevel3')">
								<c:forEach var="areaLevel2" items="${areaLevel2}">
										<option value="${areaLevel2.id}" <c:if test="${areaLevel2.id==user.areaLevel2}">selected="selected"</c:if> >${areaLevel2.areaName}</option>
									</c:forEach>
								</select>
								<select class="form-control le-sg-4 from-city-c" name="areaLevel3" id="areaLevel3">
								  <c:forEach var="areaLevel3" items="${areaLevel3}">
										<option value="${areaLevel3.id}" <c:if test="${areaLevel3.id==user.areaLevel3}">selected="selected"</c:if>>${areaLevel3.areaName}</option>
									</c:forEach>
								</select>
						    </div>
						    <div class="le-col-5 le-col-md-3"><div class="Validform_checktip"></div></div>
						</div>
						<div class="form-group clearfix">
						    <label for="address" class="le-col-3 le-col-md-3 control-label">企业地址：</label>
						    <div class="le-col-4 le-col-md-6">
						      <input type="text" class="form-control form-input-s0-100" id="address" value="${user.address}" errormsg="企业地址不得超过100字符，不包含特殊字符" name="address" />
						    </div>
						    <div class="le-col-5 le-col-md-3"><div class="Validform_checktip"></div></div>
						</div>
						<div class="form-group">
							<div class="le-col-9 le-col-offset-3">
						      <input type="submit" class="btn btn-primary btn-xll mt-20" value="提交" />
						    </div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- 左侧/E-->
	</div>
</section>
<div class="modal fade" id="showDialogDiv" tabindex="-1" role="dialog" aria-labelledby="changePhoneSuccessModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 540px;">
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<a href="javascript:hideshowDialogDiv()"><button type="button" class="close"><span aria-hidden="true">&times;</span></button></a>
				<h4 class="modal-title" id="<editPhoneModalLabel></editPhoneModalLabel>">温馨提醒</h4>
			</div>
			<div class="modal-body" style="padding-top: 0;">
				<div class="modal-warp modal-warp-edit-phone row clearfix">
					<p><i class="icon-user-danger"></i><span class="h4 ml-10">请检查信息录入是否正确</span></p>
					<div class="text-center">
						<a href="javascript:hideshowDialogDiv()"><button class="btn btn-primary btn-xl">确定</button></a>
						<%--  确定 --%>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 中部内容/E-->
<!-- 营业执照上传示例-->
<div class="modal fade" id="showDialogDiv2" tabindex="-1" role="dialog" aria-labelledby="changePhoneSuccessModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 540px;">
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<a href="javascript:hideshowDialogDiv2()"><button type="button" class="close"><span aria-hidden="true">&times;</span></button></a>
				<h4 class="modal-title" id="showTitle">营业执照上传示例</h4>
			</div>
			<div class="modal-body" style="padding-top: 0;">
				<div class="modal-warp modal-warp-edit-phone row clearfix">
					<p><img src="http://static.uc.letvcloud.com/images/eid_demo.jpg" width="auto" height="400px" style="    position: relative;left: 85px;top: 15px;"></p>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
</body>
<script type="text/javascript" src="${ctx }/assets/js/min/usercenterApp.js?t=20150421"></script>
<script type="text/javascript">
	$ = jQuery = require("lib/jquery.min");//jquery
	require("lib/bootstrap.min");//modal
</script>
<script src="${ctx}/assets/js/main/jquery.ui.widget.js"></script>
<script src="${ctx}/assets/js/main/jquery.iframe-transport.js"></script>
<script src="${ctx}/assets/js/main/jquery.fileupload.js"></script>

<script type="text/javascript">
var findArea = function (areaCode,areaLevel) {
    $.ajax({
        type: "GET",
        url: "${ctx}/area/getArea.do?upAreaCode=" + areaCode,
        dataType: "JSON",
        success: function (data) {
            var area = "";
            $.each(data, function(index, item){

                area += "<option value = '" + item.id + "'>" + item.areaName + "</option>";
            });
            $(areaLevel).html(area);
            if("#areaLevel2"==areaLevel){
                var areaCode2 = $("#areaLevel2").val();
          	    findArea(areaCode2,"#areaLevel3");
            }
         }
    });
}

$(function(){

	$('.form-input-required').bind("blur",function(){
		var validform =$(this).parent().parent().find(".Validform_checktip");
		if($(this).val()==""){
			validform.addClass("Validform_wrong").text($(this).attr("nullmsg"));
		}else{
			validform.removeClass("Validform_wrong").addClass("Validform_right").text("通过信息验证");
		}
	})
	$('.form-input-s0-100').bind("blur",function(){
		var validform =$(this).parent().parent().find(".Validform_checktip");
        if($(this).val()==""||$(this).val().length>=0&&$(this).val().length<=100&&/^[a-zA-Z0-9_\u4e00-\u9fa5\" "]+$/.test($(this).val())){
			validform.removeClass("Validform_wrong").addClass("Validform_right").text("通过信息验证");
		}else{
			validform.addClass("Validform_wrong").text($(this).attr("errormsg"));
		}
	})
	$('.form-input-required-s2-50').bind("blur",function(){
		var validform =$(this).parent().parent().find(".Validform_checktip");
		if($(this).val()==""){
			validform.addClass("Validform_wrong").text($(this).attr("nullmsg"));
		}else if($(this).val().length>=2&&$(this).val().length<=50){
			validform.removeClass("Validform_wrong").addClass("Validform_right").text("通过信息验证");
		}else{
			validform.addClass("Validform_wrong").text($(this).attr("errormsg"));
		}

	})
	$('.organizationCode').bind("blur",function(){
		var validform =$(this).parent().parent().find(".Validform_checktip");
		var check = /^\d{8}-\d/;
		if(check.test($(this).val())==true){
			validform.removeClass("Validform_wrong").addClass("Validform_right").text("通过信息验证");
		}else{
			validform.addClass("Validform_wrong").text($(this).attr("errormsg"));
		}

	})

})
function checkSubmit(){
	$('.form-input-required').trigger("blur");
	$('.form-input-required-s2-50').trigger("blur");
	$('.form-input-s0-100').trigger("blur");
	$('.organizationCode').trigger("blur");
	if($('.Validform_wrong').size()==0&&$("#businessLicense").val()!=""){
		return true;
	}else{
		$("#showDialogDiv").modal('show');
		return false;
	}
}
function hideshowDialogDiv(){
	$("#showDialogDiv").modal('hide');
}


$("#file").fileupload({
	url:"${ctx}/fileUpload/uploadFile.do",//文件上传地址，当然也可以直接写在input的data-url属性内
	formData:{size:"2"},//如果需要额外添加参数可以在这里添加
	done:function(e,result) {
		var data = result.result;
		data = JSON.parse(data);
		if(data.msgCode==undefined){
			$("#checkUpload").removeClass("Validform_wrong").addClass("Validform_right");
			$("#checkUpload").html("通过信息验证");
			$("#uploadSpan").css('display','none');
			$("#uploadImage").removeClass();
			$("#uploadImage").prop("src", data.path);
			$("#businessLicense").val(data.path);
			$("#businessLicense").trigger("blur");
		}else{
			if(data.msgCode=="0")$("#checkUpload").addClass("Validform_wrong").html("请选择图片");
			if(data.msgCode=="1")$("#checkUpload").addClass("Validform_wrong").html("图片大于2M");
			if(data.msgCode=="2")$("#checkUpload").addClass("Validform_wrong").html("图片限于png,jpg");
		}
	}
	});

	function showDialogDiv2(){
		$("#showDialogDiv2").modal('show');
	}
	function hideshowDialogDiv2(){
		$("#showDialogDiv2").modal('hide');
	}
	$("#imgBtn").bind("click",function(){
		$("#file").trigger("click");
	});


</script>

</html><!-- file tree:
|...usercenter-zizhi-a.html
|   |...header-usercenter.html
|   |...usercenter-header.html
|   |...footer.html
- By MOKTEXT. -->