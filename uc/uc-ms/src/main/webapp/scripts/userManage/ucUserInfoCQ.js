var serData;// 服务器原始数据

/** init */
$(document).ready(function() {
	// 错误处理
	if (response.result == "failed") {
		alert("message:" + res.message);
		return;
	}
	serData = response.data;
	initForm(serData);
});

$("#formsubmitpass").click(function() {
	formSubmit(1);
});

$("#formsubmitnopass").click(function() {
	formSubmit(0);
});

/** 初始化表单 */
function initForm(data) {
	// $('#ucUserInfoPQForm').form('load', data);
	$("#id").html(data.id);
	$("#enterprisename").html(data.enterprisename);
	$("#organizationcode").html(data.organizationcode);
	$("#businesslicenseregisternum").html(data.businesslicenseregisternum);
	$("#businesslicense").attr('src', data.businesslicense);
	$("#address").html(data.address);
}

function formSubmit(status) {

	var getdata = {
		reason : $('#reason').val(),
		reasonid : -1,// 自定义原因
		examinestatus : status
	};
	// alert(ctx + '/ucUserInfo/' + serData.id + '?' + $.param(getdata));
	$.ajax({
		url : ctx + '/ucUserInfo/certificate/' + serData.id + '?'
				+ $.param(getdata),// 临时传参方式(应该使用body)
		type : 'PUT',
		datatype : 'json',
		// contentType : 'application/json',
		// data : getdata,
		success : function(response) {
			if (response != null) {
				var res = jQuery.parseJSON(response);
				// 错误处理
				if (res.result == "failed") {
					alert("message:" + res.message);
					return;
				}
				alert("approve success!");
				window.close();
			}
		}
	});
}
