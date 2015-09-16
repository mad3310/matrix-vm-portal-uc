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
	$("#idcard").html(data.idcard);
	$("#idcardphoto").attr('src', data.idcardphoto);
	$("#address").html(data.address);
	var examinestatus = data.examinestatus;
	var examinestatus_txt = "";
	if (examinestatus == 1) {
		examinestatus_txt = "审核通过";
	} else if (examinestatus == 0) {
		examinestatus_txt = "审核未通过(" + data.reason + ")";
	}
	$("#examinestatus").html(examinestatus_txt);
}
