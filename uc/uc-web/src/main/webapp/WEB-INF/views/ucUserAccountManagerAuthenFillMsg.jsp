<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="/assets/css/main/usercenterApp.css"/>
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
					<form class="form-horizontal vform" action="${ctx }/qualificationsAuthenView/executeAuthen.do" method="post" onsubmit="return checkSubmit()" enctype="multipart/form-data">
							<div class="le-col-12">
								<p class="mb-20 mt-20 pl-20"><i class="icon-user-danger" ></i><span><c:if test="${empty NOT_THROUGH}">为保证您尽快通过资质认证，请填写真实信息</c:if><c:if test="${not empty NOT_THROUGH}">您的审核信息未通过，请您修改后重新提交</c:if></span></p>
							</div>
				     	<div class="form-group clearfix">
						    <label for="contacts" class="le-col-3 le-col-md-3 control-label"><i class="istyle">*</i>真实姓名:</label>
						    <div class="le-col-4 le-col-md-6">
						      <input type="text" class="form-control form-input-required-s2-20" name="contacts" id="contacts" placeholder="真实姓名" nullmsg="请输入真实姓名" errormsg="真实姓名为2-20字符以内" value="${user.contacts}" maxlength="20"/>
						    </div>
						    <div class="le-col-5 le-col-md-3"><div class="Validform_checktip"></div></div>
						</div>
						<div class="form-group clearfix">
						    <label for="idCard" class="le-col-3 le-col-md-3 control-label"><i class="istyle">*</i>身份证号:</label>
						    <div class="le-col-4 le-col-md-6">
						      <input type="text" class="form-control form-input-required-idcard" id="idCard" nullmsg="请输入身份证号" errormsg="身份证号格式不正确" name="idCard"  value="${user.idCard}" />
						    </div>
						    <div class="le-col-5 le-col-md-3"><div class="Validform_checktip" id="checkcid"></div></div>
						</div>
						<div class="form-group clearfix">
						    <label for="file" class="le-col-3 le-col-md-3 control-label"><i class="istyle">*</i>身份证：</label>
						    <div class="le-col-6 le-col-md-7">
						       <div class="row clearfix">
						       	   <div class="le-col-4">
							       	  <p class="zizhi-yyzz-face-wj">
										<c:if test="${empty user.idCardPhoto}"><span id="uploadSpan">暂未<br/>上传</span></c:if>
							       	 	<img src="${user.idCardPhoto}" id="uploadImage" <c:if test="${empty user.idCardPhoto}"> class="hide"</c:if>/>
							       	  </p>
							       </div>
							       <div class="le-col-8">
							       	  <p class="zizhi-info-wj">JPG,PNG的图片，文件大小不超过2M </p>
									  <p class="zizhi-info-wj"><a href="javascript:showDialogDiv()" class="text-primary">身份证上传要求</a></p>
									  <div class="clearfix">
										<div class="le-file-input-box pull-left clearfix">
											<input type="button" id="imgBtn" value ="浏览上传"  class="btn btn-default btn-xl le-btn-file" />
											<input type="file" id="file" name="file" class="le-file-input"  style="z-index: -1;" accept="*.jpg,*.png" />
											<input type="hidden" id="idCardPhoto" class="form-input-required" nullmsg="请上传图片！" value="${user.idCardPhoto}" name="idCardPhoto">
										</div>
										<div id="checkUpload" class="Validform_checktip pull-left"></div>
									  </div>
							       </div>
						       </div>
						    </div>
						</div>
						<div class="form-group clearfix">
						    <label for="address" class="le-col-3 le-col-md-3 control-label">联系地址：</label>
						    <div class="le-col-4 le-col-md-6">
						      <input type="text" class="form-control form-input-s0-100" id="address" errormsg="联系地址不得超过100字符，不包含特殊字符" name="address"  value="${user.address}" />
						    </div>
						    <div class="le-col-5 le-col-md-3"><div class="Validform_checktip"></div></div>
						</div>
						<%--<div class="form-group clearfix">--%>
					    <%--<div class="le-col-9 le-col-offset-3">--%>
					       <%--<p><i class="icon-user-danger"></i><span>认证过程中，资质信息将不可修改，请在点击下一步前确保所填信息正确有效</span></p>--%>
					    <%--</div>--%>
						<%--</div>--%>
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
<!-- 中部内容/E-->
<!-- 身份证示例-->
<div class="modal fade" id="showDialogDiv" tabindex="-1" role="dialog" aria-labelledby="changePhoneSuccessModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 540px;">
		<div class="modal-content">
			<div class="modal-header modal-header-primary">
				<a href="javascript:hideshowDialogDiv()"><button type="button" class="close"><span aria-hidden="true">&times;</span></button></a>
				<h4 class="modal-title" id="showTitle">身份证上传示例</h4>
			</div>
			<div class="modal-body" style="padding-top: 0;">
				<div class="modal-warp modal-warp-edit-phone row clearfix">
					<p><img src="http://static.uc.letvcloud.com/images/id_demo.png" width="auto" height="400px" style="    position: relative;left: 85px;top: 15px;"></p>
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
</body>

<script type="text/javascript" src="http://static.uc.letvcloud.com/js/main/zhuceApp.js"></script>
<script src="http://static.uc.letvcloud.com/js/main/jquery.ui.widget.js"></script>
<script src="http://static.uc.letvcloud.com/js/main/jquery.iframe-transport.js"></script>
<script src="http://static.uc.letvcloud.com/js/main/jquery.fileupload.js"></script>

 <script type="text/javascript">
  $ = jQuery = require("lib/jquery.min");//jquery
</script>
<script type="text/javascript">
$(function(){
	$('.form-input-required').bind("blur",function(){
		var validform =$(this).parent().parent().find(".Validform_checktip");
		if($(this).val()==""){
			validform.addClass("Validform_wrong").text($(this).attr("nullmsg"));
		}else{
			validform.removeClass("Validform_wrong").addClass("Validform_right").text("通过信息验证");
		}
	})
	$('.form-input-required-idcard').bind("blur",function(){
		var validform =$(this).parent().parent().find(".Validform_checktip");
		if($(this).val()==""){
			validform.addClass("Validform_wrong").text($(this).attr("nullmsg"));
		}else if(/^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/.test($(this).val())){
			validform.removeClass("Validform_wrong").addClass("Validform_right").text("通过信息验证");
		}else{
			validform.addClass("Validform_wrong").text($(this).attr("errormsg"));
		}


	})
	$('.form-input-required-s2-20').bind("blur",function(){
		var validform =$(this).parent().parent().find(".Validform_checktip");
		if($(this).val()=="") {
			validform.addClass("Validform_wrong").text($(this).attr("nullmsg"));
		}else if($(this).val().length>=2&&$(this).val().length<=20){
			validform.removeClass("Validform_wrong").addClass("Validform_right").text("通过信息验证");
		}else{
			validform.addClass("Validform_wrong").text($(this).attr("errormsg"));
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
})
function checkSubmit(){
	$('.form-input-required').trigger("blur");
	$('.form-input-required-s2-20').trigger("blur");
	$('.form-input-required-idcard').trigger("blur");
	$('.form-input-s0-100').trigger("blur");
	if($('.Validform_wrong').size()==0&&$("#businessLicense").val()!=""){
		return true;
	}else{
		return false;
	}
}
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
			$("#idCardPhoto").val(data.path);
			$("#idCardPhoto").trigger("blur");
		}else{
			if(data.msgCode=="0")$("#checkUpload").addClass("Validform_wrong").html("请选择图片");
			if(data.msgCode=="1")$("#checkUpload").addClass("Validform_wrong").html("图片大于2M");
			if(data.msgCode=="2")$("#checkUpload").addClass("Validform_wrong").html("图片限于png,jpg格式");
		}
	}
});

	function checkcid(code){
		if(code==null || code.length==0){
			$("#checkcid").html("<font size='3' color='red'>身份证号不为空！</font>");
		}else if(/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
			$("#checkcid").html("<font size='3' color='green'>OK！</font>");
		}else{
			$("#checkcid").html("<font size='3' color='red'>身份证号格式不对！</font>");
		}
	}
	function showDialogDiv(){
		$("#showDialogDiv").modal('show');
	}
	function hideshowDialogDiv(){
		$("#showDialogDiv").modal('hide');
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