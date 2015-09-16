var currData;// 当前表单值，重置用
var serData;// 服务器原始数据

/** init */
$(document).ready(function() {
	// $('#formsubmit').attr("disabled", true);
	// 错误处理
	if (response.result == "failed") {
		alert("message:" + res.message);
		return;
	}
	serData = response.data;
	initForm(serData.ucUserInfo);
	currData = $("#ucUserInfoForm").serializeJSON();
	
	showDataGrid(serData.billServiceOpenList);
	window.onresize = function() {
		$("#list_table").datagrid("resize");
	};
});

/** 初始化表单 */
function initForm(data) {
	// 整体初始化
	$('#ucUserInfoForm').form('load', data);
	// initFormCombobox(data);
}

/** 初始化下拉控件 */
function initFormCombobox(data) {
	if (data.province) {
		$('#provinceid').combobox('setText', data.province.regionName);
	}
	if (data.district) {
		$('#areaid').combobox('setText', data.district.regionName);
	}
	if (data.isp) {
		$('#ispid').combobox('setText', data.isp.name);
	}
	if (data.br) {
		$('#bigregion').combobox('setText', data.br.bigregionName);
	}

	if (data.relativeregion == 1) {
		$('#relativeregion').combobox('setText', '国内');
	} else if (data.relativeregion == 2) {
		$('#relativeregion').combobox('setText', '海外');
	}
}
var showColumns = new Array();

/* 显示表格 */
function showDataGrid(resData) {
	showColumns.lenght = 0;
	var index = 0;
	showColumns[index++] = {
		field : 'serviceCode',
		title : '业务',
		width : 100,
		align : 'center',
		styler : leftColor,
		formatter : getServiceName
	};
	showColumns[index++] = {
		field : 'createdTime',
		title : '开通时间',
		width : 100,
		align : 'center'
	};
	showColumns[index++] = {
		field : 'state',
		title : '业务状态',
		width : 100,
		align : 'center',
		formatter : getServiceState
	};
	$("#list_table").datagrid({
		height : 840,
		loadMsg : '数据加载中...',
		rownumbers : false,
		title : '开通业务',
		fitColumns : true,
		singleSelect : true,	
		striped : true,
		pagination : false,
		columns : [ showColumns ],
		data : resData,
	});
}


	
function getServiceName(value, row, index) {
	if (value == 100) {
		return "云直播";
	} else if (value == 101) {
		return "云点播";
	} else if (value == 110) {
		return "直播CDN";
	} else if (value == 111) {
		return "点播CDN";
	} else if (value == 112) {
		return "小文件CDN";
	} else {
		return value;
	}
}
function getServiceState(value, row, index) {
	if (value == 0) {
		return "启用";
	} else if (value == 1) {
		return "禁用";
	} else {
		return value;
	}
}