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

var showColumns = new Array();
/* 显示表格 */
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
		field : 'opt',
		title : '操作',
		width : 70,
		align : 'center',
		formatter : function(value, row, index) {
			var userid = row.id;
			var examinestatus = row.examinestatus;// 审核状态
			var usertype = row.usertype;
			var page = "";
			var xq = "";
			var href = "";
			if (examinestatus == 2) {// 待审核
				if (usertype == 2) {// 个人
					page = "/ucUserInfoPQ";
					xq = "pq/";
				} else {
					page = "/ucUserInfoCQ";
					xq = "cq/";
				}
				var url = ctx + "/ucUserInfo/" + xq + userid + page;
				href = '<a href="' + url + '" target="_blank" >用户审核</a>';
			} else {
				if (usertype == 2) {// 个人
					page = "/ucUserInfoBrowsePQ";
					xq = "pq/";
				} else {
					page = "/ucUserInfoBrowseCQ";
					xq = "cq/";
				}
				var url = ctx + "/ucUserInfo/" + xq + userid + page;
				href = '<a href="' + url + '" target="_blank" >查看</a>';
			}
			var state = row.state;
			if (state == 1) {// 云直播未开通(临时写法)
				var page = '/ucUserInfoLQ';
				var url = ctx + "/ucUserInfo/lq/" + userid + page;
				href += '&nbsp&nbsp<a href="' + url
						+ '" target = "_blank">直播审核</a>';
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
	if ($("#ucUserInfoCertificateForm").form('validate')) {
		// 组装参数
		var getdata = {};
		var id = $("#id").val();
		var contacts = $('#contacts').val();
		if (id != "" || contacts != "") {// id、contacts优先作为参数
			if (id != "") {
				getdata = {
					id : id
				};
			} else {
				getdata = {
					contacts : contacts
				};
			}
		} else {
			getdata = {
				usertype : $('#usertype').combobox('getValue'),
				mobile : $('#mobile').val(),
				email : $('#email').val(),
				examinestatus : $('#examinestatus').combobox('getValue'),
				starttime : $('#starttime').val(),
				endtime : $('#endtime').val()
			};
		}
		$("#list_table").datagrid({
			url : ctx + "/ucUserInfo/certificate",
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
			}
		});
	}
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
