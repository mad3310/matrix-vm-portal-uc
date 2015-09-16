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

/** 初始化表单 */
function initForm(data) {
	// $('#ucUserInfoPQForm').form('load', data);
	$("#id").html(data.id);
	$("#email").html(data.email);

}

$("#formsubmitConfirm").click(function() {
	formSubmit();
});
function formSubmit() {

	var getdata = {
		usertype : $('#usertype').val()
	};
	$.ajax({
		url : ctx + '/ucUserInfo/' + serData.id + '?' + $.param(getdata),// 临时传参方式(应该使用body)
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
				alert("upgrade success!");
			}
		}
	});
}
