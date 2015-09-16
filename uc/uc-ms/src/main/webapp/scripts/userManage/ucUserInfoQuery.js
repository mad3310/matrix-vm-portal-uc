/** init */
$(document).ready(function() {
	showDataGrid();
	window.onresize = function() {
		$("#list_table").datagrid("resize");
	};
});

/** 开始时间 */
$("#starttime").click(function() {
	WdatePicker({
		maxDate : '#F{$dp.$D(\'endtime\')}',
		dateFmt : 'yyyy-MM-dd HH:mm:ss'
	});
});

/** 结束时间 */
$("#endtime").click(function() {
	WdatePicker({
		minDate : '#F{$dp.$D(\'starttime\')}',
		dateFmt : 'yyyy-MM-dd HH:mm:ss'
	});
});

/**
 * 点击查询
 */
$("#search").click(function() {
	submitQueryForm();
});

/**
 * 点击重置
 */
$("#reset").click(function() {
	//TODO
});

var showColumns = new Array();
/**
 * 显示表格
 */
function showDataGrid() {

	showColumns.lenght = 0;
	var index = 0;
	showColumns[index++] = {
		field : 'id',
		title : '用户ID',
		width : 100,
		align : 'center',
		styler : leftColor
	};
	showColumns[index++] = {
		field : 'contacts',
		title : '用户名',
		width : 100,
		align : 'center'
	};
	showColumns[index++] = {
		field : 'usertype',
		title : '用户类型',
		width : 100,
		align : 'center',
		formatter : getUserType
	};

	showColumns[index++] = {
		field : 'mobile',
		title : '手机号',
		width : 100,
		align : 'center'
	};
	showColumns[index++] = {
		field : 'email',
		title : '邮箱',
		width : 100,
		align : 'center'
	};
	showColumns[index++] = {
		field : 'examinestatus',
		title : '资质状态',
		width : 100,
		align : 'center',
		formatter : getExamineStatus
	};
	showColumns[index++] = {
		field : 'createdtime',
		title : '注册时间',
		width : 100,
		align : 'center'
	};
	showColumns[index++] = {
		field : 'enterprisename',
		title : '公司名称',
		width : 100,
		align : 'center'
	};
	showColumns[index++] = {
		field : 'userstatus',
		title : '用户状态',
		width : 100,
		align : 'center',
		formatter : getUserStatus
	};
	showColumns[index++] = {
		field : 'opt',
		title : '操作',
		width : 70,
		align : 'center',
		formatter : function(value, row, index) {
			var userid = row.id;

			var url = ctx + "/ucUserInfo/serviceState/" + userid;
			var usertype = row.usertype;
			var href = '<a href="' + url + '" target="_blank" >编辑</a>';
			if (usertype != 6 && usertype != 2) {
				var page = '/ucUserInfoUsertype';
				var url = ctx + "/ucUserInfo/cq/" + userid + page;
				href += '&nbsp&nbsp<a href="' + url
						+ '" target = "_blank">升级</a>';
			}
			return href;
		}
	};
	submitQueryForm();
}

/**
 * form表单提交
 */
function submitQueryForm() {
	if ($("#ucUserInfoQueryForm").form('validate')) {

		// 组装参数
		var getdata = {};
		var q_id = $("#q_id").val();
		var q_contacts = $('#q_contacts').val();
		if (q_id != "" || q_contacts != "") {// q_id、contacts优先作为参数
			if (q_id != "") {
				getdata = {
					id : q_id
				};
			} else {
				getdata = {
					contacts : q_contacts
				};
			}
		} else {
			getdata = {
				usertype : $('#q_usertype').combobox('getValue'),
				mobile : $('#q_mobile').val(),
				email : $('#q_email').val(),
				enterprisename : $('#q_enterprisename').val(),
				examinestatus : $('#q_examinestatus').combobox('getValue'),
				userstatus : $('#q_userstatus').combobox('getValue'),
				starttime : $('#q_starttime').val(),
				endtime : $('#q_endtime').val()
			};
		}
		$("#list_table").datagrid({
			url : ctx + "/userManage/pageList",
			method : 'get',
			queryParams : getdata,
			height : 560,
			loadMsg : '数据加载中...',
			rownumbers : false,
			fitColumns : true,
			singleSelect : true,
			pagination : true,
			pageNumber : 1,
			pageList : [ 10, 15, 20, 30, 40, 50 ],
			pageSize : 15,
			striped : true,
			columns : [ showColumns ],
			onLoadError : function(error) {
				alert("查询错误:" + error);
			},
			onDblClickRow : function(rowIndex,rowData){
				open4Edit(rowIndex,rowData);
			}
		});
	}
}

// 添加
function open4Add() {
	$('#ucUserInfoEditForm').form('clear');
	$('#dlg_editInfo').dialog('open');
}

// 编辑
function open4Edit(rowIndex, rowData) {
	var id;
	if (rowData) {
		id = rowData.serverIp;
	} else {
		var row = $("#dgd_result").datagrid("getSelected");
		if (!row) {
			$.messager.alert("提示", "请至少选择一行！", "error");
			return;
		}
		id = row.serverIp;
	}
	$('#ucUserInfoEditForm').form('clear');
	$('#dlg_editInfo').dialog('open');
	$('#ucUserInfoEditForm #serverIp').attr("readonly", "readonly");
	$('#ucUserInfoEditForm #serverIp').addClass("readonly");
	$('#ucUserInfoEditForm').form('load', '<%=basePath%>/uc/transcodeServer/getByIp?serverIp=' + id);
}

// 保存
function save4Edit() {
	$.messager.progress();
	$('#ucUserInfoEditForm').form('submit', {
		url: '<%=basePath%>/uc/transcodeServer/saveOrUpdate',
		onSubmit: function (param) {
			var serverIp = $("#serverIp").val();
			if (!ipvalidate(serverIp)) {
				$.messager.alert("提示", "转码机IP不合法", "warning");
				$.messager.progress('close');
				return false;
			}
			var totalCapacity = $("#totalCapacity").val();
			if (isNaN(totalCapacity)) {
				$.messager.alert("提示", "总转码能力为整数", "warning");
				$.messager.progress('close');
				return false;
			}
			var isValid = $(this).form('validate');
			if (!isValid) {
				$.messager.progress('close');
				return false;
			}
			return true;
		},
		success: function (data) {
			$.messager.progress('close');
			if (data) {
				var result = eval('(' + data + ')');
				$.messager.alert("提示", result.errorMessage, "error");
				return;
			}
			$('#dgd_result').datagrid("reload");
			$('#dlg_editInfo').dialog('close');
		},
		error: function () {
			$.messager.alert("提示", "session过期,请刷新页面重试!", "info");
		}
	});
}

function getExamineStatus(value, row, index) {
	switch (value) {
	case 0:
		return "审核未通过";
	case 1:
		return "审核通过";
	case 2:
		return "待审核";
	default:
		return value;
	}
}

function getUserStatus(value, row, index) {
	switch (value) {
	case 0:
		return "删除";
	case 1:
		return "正常";
	case 2:
		return "禁用";
	default:
		return value;
	}
}

function getUserType(value, row, index) {
	if (value == 1) {
		return "";
	} else if (value == 2) {
		return "个人会员";
	} else if (value == 3) {
		return "企业会员";
	} else if (value == 4) {
		return "一级代理";
	} else if (value == 5) {
		return "二级代理";
	} else if (value == 6) {
		return "大客户";
	} else if (value == 7) {
		return "代理商用户";
	} else {
		return value;
	}
}
