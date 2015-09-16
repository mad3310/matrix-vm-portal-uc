$(document).ready(function() {
    $(".toolTip").hover(function() {
        this.tip = this.title;
        $(this).append('<div class="toolTipWrapper">' +
        '<div class="toolTipMid">' +
        this.tip +
        '</div>' +
        '</div>');
        this.title = "";
        this.width = $(this).width();
        $(this).find('.toolTipWrapper').css({
            left: this.width + 22
        });
        $('.toolTipWrapper').fadeIn(300);
    }, function() {
        $('.toolTipWrapper').fadeOut(100);
        $(this).children().remove();
        this.title = this.tip;
    });
});

// 格式化DataGrid中的时间列
function formatDateTime(val, row) {
	try{
		if (val) {
			var datetime = new Date();
			datetime.setTime(val);
			return datetime.format("yyyy-MM-dd hh:mm:ss");
		}
	} catch (e){
		alert(e);
		return "";
	}
};


function formatDateTime(val) {
	try{
		if (val) {
			var datetime = new Date();
			datetime.setTime(val);
			return datetime.format("yyyy-MM-dd hh:mm:ss");
		}
	} catch (e){
		alert(e);
		return "";
	}
};

// 格式化True/False或者0,1
function formatTrueFalse(val, row) {
	if (val && (val == "1" || val == true || val == "true")) {
		return "是";
	} else {
		return "否";
	}
};

// 设置一个pannel下面的所有控件为只读的
function disablePannel(pannelId) {
	$('#' + pannelId + ' input').addClass('readonly');
	$('#' + pannelId + ' textarea').addClass('readonly');
	$('#' + pannelId + ' input').attr('readonly','readonly');
	$('#' + pannelId + ' textarea').attr('readonly','readonly');
//	$('#' + pannelId + ' input:checkbox').attr('disabled','disabled');
	$('#' + pannelId + ' input:checkbox').attr('onclick','return false;');
	$('#' + pannelId + ' .easyui-combobox').combobox('disable');
//	$('#' + pannelId + ' .combo-arrow').addClass('displayNone');
	$('#' + pannelId + ' .easyui-linkbutton').addClass('displayNone');
	
}

//设置一个pannel下面的所有控件为可用的
function enablePannel(pannelId) {
	$('#' + pannelId + ' input').removeAttr('readonly');
	$('#' + pannelId + ' textarea').removeAttr('readonly');
//	$('#' + pannelId + ' input:checkbox').removeAttr('disabled');
	$('#' + pannelId + ' input:checkbox').removeAttr('onclick');
	$('#' + pannelId + ' .easyui-combobox').combobox('enable');
//	$('#' + pannelId + ' .combo-arrow').attr('display','');
	$('#' + pannelId + ' .easyui-linkbutton').attr('display','');
}

// 根据编码创建checkbox
function createCodeCheckbox(url, fieldName, divId, disabled) {
    $.ajax({
        type: 'GET',
        url: url,
        success: function (msg) {
            var htmlText = "<table><tr>";
            for (var i = 1; i <= msg.length; i++) {
            	if (disabled) {
            		htmlText += "<td><input type='checkbox' name='" + fieldName + "'  value='" + msg[i-1].code + "' onclick='return false;'/>" + msg[i-1].name + "</td>";
            	} else {
                    htmlText += "<td><input type='checkbox' name='" + fieldName + "'  value='" + msg[i-1].code + "'/>" + msg[i-1].name + "</td>";
            	}
                if (i % 4 == 0) {
                    htmlText += "</tr><tr>";
                }
            }
            htmlText += "</tr></table>";
            $('#' + divId).html(htmlText);
        },
        error: function () {
            $.messager.alert('错误', '获取编码错误。', 'error');
        }
    });
}

// 格式化Form中的日期显示
function formatDateTime2(id) { 
    var val = $(id).val(); 
    if (val) { 
    	var datetime = new Date();
		datetime.setTime(val);
		return $(id).val(datetime.format("yyyy-MM-dd hh:mm:ss"));
    } else { 
    	return ''; 
    } 
};

//格式化Form中的日期显示
function formatDateTime3(val) { 
    if (val) { 
    	var datetime = new Date();
		datetime.setTime(val);
		return datetime.format("yyyy-MM-dd");
    } else { 
    	return ''; 
    } 
};

// 显示对话框
function showDialog($div, title, width, height, top) {
	$div.window({
        title: title,
        modal: true,
        shadow: true,
        top:top,
        width: width,
        draggable: true,
        modal: true,
        collapsible: false,
        shadow: true,
        maximizable: false,
        minimizable: false,
        closable: true,
        closed: false,
        height: height,
        resizable: false
    });
}

//validatebox的检查规则扩展
$.extend($.fn.validatebox.defaults.rules, {
    numeric: {
        validator: function(value, param){
        	if (value) {
        		var exp = new RegExp("^-?\\d+$");
            	return exp.test(value);
        	} else {
        		return true;
        	}
        },
        message: '请输入数字。'
    },
	datetime: {
		validator: function(value, param){
        	if (value) {
        		var exp = new RegExp("^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}$");
            	return exp.test(value);
        	} else {
        		return true;
        	}
        },
        message: '日期必须满足“yyyy-MM-dd hh:mm:ss”格式。'
	},
	time: {
		validator: function(value, param){
        	if (value) {
        		var exp = new RegExp("\\d{2}:\\d{2}:\\d{2}$");
            	return exp.test(value);
        	} else {
        		return true;
        	}
        },
        message: '时间必须满足“HH:mm:ss”格式。'
	},
	integer: {
        validator: function(value, param){
        	if (value) {
        		var exp = new RegExp("^\\d+$");
            	return exp.test(value);
        	} else {
        		return true;
        	}
        },
        message: '必须输入正整数。'
    },
	url: {
        validator: function(value, param){
        	if (value) {
        		var exp = new RegExp("^(http|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?$");
            	return exp.test(value);
        	} else {
        		return true;
        	}
        },
        message: '必须输入正确的url。'
    },
    mobile: {
    	 validator: function (value) {
             return /^(13|15|18)\d{9}$/i.test(value);
         },
         message: '手机号码格式不正确'
    }
});

Date.prototype.format = function(format) {
	var date = {
		"M+" : this.getMonth() + 1,
		"d+" : this.getDate(),
		"h+" : this.getHours(),
		"m+" : this.getMinutes(),
		"s+" : this.getSeconds(),
		"q+" : Math.floor((this.getMonth() + 3) / 3),
		"S+" : this.getMilliseconds()
	};
	if (/(y+)/i.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + '')
				.substr(4 - RegExp.$1.length));
	}
	for ( var k in date) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? date[k]
					: ("00" + date[k]).substr(("" + date[k]).length));
		}
	}
	return format;
};

String.prototype.startWith = function (str) {
    var reg = new RegExp("^" + str);
    return reg.test(this);
};

String.prototype.endWith = function (str) {
    var reg = new RegExp(str + "$");
    return reg.test(this);
};

/**
 * 关闭tabs
 * @author wangjunfeng
 * */
function closeTabs(tabsObj) {
    var tabs = tabsObj.tabs("tabs");
    for (var i = tabs.length - 1; i >= 0; i--) {
        tabsObj.tabs('close', tabsObj.tabs("getTabIndex",tabs[i]));
    }
}

//格式化时长
function formatDuration(value, row, index) {
	if (value) {
		return formatSeconds(value);
	}else{
        return 0;
    }
}
//将节目时长（秒）转换为小时和分钟
function formatSeconds(seconds) {
    var days = parseInt(seconds / 86400);
    var hours = parseInt((seconds % 86400) / 3600);
    var minusts = parseInt((seconds % 3600) / 60);
    seconds = seconds % 60;
    var results = "";
    if (hours == 0 && days == 0) {
    	if (minusts == 0) {
    		results = seconds + "秒";
    	} else {
    		if (seconds == 0) {
    			results = minusts + "分钟";
    		} else {
    			results = minusts + "分钟" + seconds + "秒";
    		}
    	}
    } else {
    	if (seconds == 0) {
    		if (minusts == 0) {
    			results = (hours + days * 24) + "小时";
    		} else {
    			results = (hours + days * 24) + "小时" + minusts + "分钟";
    		}
    	} else {
    		results = (hours + days * 24) + "小时" + minusts + "分钟" + seconds + "秒";
    	}
    }
    
    return results;
}

//开始时间与结束时间大小校验
//yyyy-MM-dd HH:mm:ss
function isStartEndDate(startDate, endDate) {
	if (startDate.length > 0 && endDate.length > 0) {
		var startDateTemp = startDate.split(" ");
		var endDateTemp = endDate.split(" ");
		var arrStartDate = startDateTemp[0].split("-");
		var arrEndDate = endDateTemp[0].split("-");
		var arrStartTime = startDateTemp[1].split(":");
		var arrEndTime = endDateTemp[1].split(":");
		var allStartDate = new Date(arrStartDate[0], arrStartDate[1],
				arrStartDate[2], arrStartTime[0], arrStartTime[1],
				arrStartTime[2]);
		var allEndDate = new Date(arrEndDate[0], arrEndDate[1],
				arrEndDate[2], arrEndTime[0], arrEndTime[1], arrEndTime[2]);
		if (allStartDate.getTime() > allEndDate.getTime()) {
			return false;
		}
	}
	return true;
}

//开始时间与结束时间大小校验
//yyyy-MM-dd
function isStartEndDate2(startDate, endDate) {
	startDate=$.trim(startDate);
	endDate=$.trim(endDate);
	
	if (startDate.length > 0 && endDate.length > 0) {
		var arrStartDate = startDate.split("-");
		var arrEndDate = endDate.split("-");
		var allStartDate = new Date(arrStartDate[0], arrStartDate[1], arrStartDate[2], '00', '00', '00');
		var allEndDate = new Date(arrEndDate[0], arrEndDate[1], arrEndDate[2], '00', '00', '00');
		if (allStartDate.getTime() > allEndDate.getTime()) {
			return false;
		}
	}
	return true;
}

//开始时间与结束时间大小校验
//HH:mm:ss
function isStartEndDate3(startDate, endDate) {
	startDate=$.trim(startDate);
	endDate=$.trim(endDate);
	
	if (startDate.length > 0 && endDate.length > 0) {
		var arrStartTime = startDate.split(":");
		var arrEndTime = endDate.split(":");
		var allStartDate = new Date('1970', '01', '01', arrStartTime[0], arrStartTime[1], arrStartTime[2]);
		var allEndDate = new Date('1970', '01', '01', arrEndTime[0], arrEndTime[1], arrEndTime[2]);
		if (allStartDate.getTime() > allEndDate.getTime()) {
			return false;
		}
	}
	return true;
}


// 格式化预览图
function formatPicURL(value, row, index) {
	if (value) {
		return '<a class="Pic" target="blank" href="'+ value + '"><img src="' + value + '" width="24px" height="18px" alt="预览图" title="预览图"/></a>';
	} else {
		return "";
	}
}

function showPic(){
    $('.Pic').each(function(i, n){
        $(this).tooltip({
            position: 'right',
            content: '<span style="color:#fff"><img src='+n+' alt="预览图" title="预览图"/> </span>',
            onShow: function(){
                $(this).tooltip('tip').css({
                    backgroundColor: '#666',
                    borderColor: '#666'
                });
            }
        });
    });
}

function formatWaterMark(row){
    var s ='<div style=" width:100%; bordercolor:red; "><span style="font-weight:bold;float: left; width: 70%;height:30px;padding-top:10px;">'+row.waterMarkName+'</span>'+
        '<span style="float: left; width: 15%;"><img   alt="预览图" style="width:30px;height:30px;background-color: #000000" src="' + row.url +
        '"></span></div>';
    return s;
}

//预览flash
function flashGetUserSSOUID(){return "87654321";}
//预览flash
function preViewLive(stream_name,width,height,vip) {
	var url = "http://player.hz.letv.com/live.swf";
	var htmlstr = "<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' width='"+width+"' height='"+height+"' id='httpLivePlayer' align='middle'>";
	htmlstr += "<param name='movie' value='"+url+"' />";
	htmlstr += "<param name='quality' value='high' />";
	htmlstr += "<param name='bgcolor' value='#000000' />";
	htmlstr += "<param name='play' value='true' />";
	htmlstr += "<param name='loop' value='true' />";
	htmlstr += "<param name='wmode' value='transparent' />";
	htmlstr += "<param name='scale' value='showall' />";
	htmlstr += "<param name='menu' value='true' />";
	htmlstr += "<param name='devicefont' value='false' />";
	htmlstr += "<param name='salign' value='' />";
	htmlstr += "<param name='allowScriptAccess' value='always' />";
	htmlstr += "<param name='allowFullScreen' value='true' />";
	htmlstr += "<param name='flashVars' value='autoplay=true&ipa=0&newp2p=1&cid=test&usewhitelist=0&musttype=m3u8&ext=m3u8&streamid=" + stream_name + "'/>";
	htmlstr += "<!--[if !IE]>-->";
	htmlstr += "<object type='application/x-shockwave-flash' id='httpLivePlayer1' data='"+url+"' width='"+width+"' height='"+height+"'>";
	htmlstr += "<param name='movie' value='"+url+"' />";
	htmlstr += "<param name='quality' value='high' />";
	htmlstr += "<param name='bgcolor' value='#000000' />";
	htmlstr += "<param name='play' value='true' />";
	htmlstr += "<param name='loop' value='true' />";
	htmlstr += "<param name='wmode' value='transparent' />";
	htmlstr += "<param name='scale' value='showall' />";
	htmlstr += "<param name='menu' value='true' />";
	htmlstr += "<param name='devicefont' value='false' />";
	htmlstr += "<param name='salign' value='' />";
	htmlstr += "<param name='allowScriptAccess' value='always' />";
	htmlstr += "<param name='allowFullScreen' value='true' />";
	htmlstr += "<param name='flashVars' value='autoplay=true&ipa=0&newp2p=1&cid=test&usewhitelist=0&musttype=m3u8&ext=m3u8&streamid=" + stream_name + "&gslb=http://live.gslb.letv.com/" + vip + "'/>";
	htmlstr += "<!--<![endif]-->";
	htmlstr += "<a href='http://www.adobe.com/go/getflash'>";
	htmlstr += "<img src='http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='获得 Adobe Flash Player' />";
	htmlstr += "</a>";
	htmlstr += "<!--[if !IE]>-->";
	htmlstr += "</object>";
	htmlstr += "<!--<![endif]-->";
	htmlstr += "</object>";
    htmlstr += "</p>"
	htmlstr += "<span style='font-size: 10px;display: none;'>" + url + "?autoplay=true&ipa=0&newp2p=1&cid=test&usewhitelist=0&musttype=m3u8&ext=m3u8&streamid=" + stream_name + "&gslb=http://live.gslb.letv.com/" + vip + "</span>"
	$('#sp').html(htmlstr);
}

//校验日期是否合法
$.extend($.fn.validatebox.defaults.rules, {
    validDate: {
        validator: function(value){
            var date = $.fn.datebox.defaults.parser(value);
            var s = $.fn.datebox.defaults.formatter(date);
            return s==value;
        },
        message: '请输入合法的日期'
    }
});

//取得日期字符串,返回YYYY-MM-DD
function getDate()
{
    var today = new Date();
    var day = today.getDate();
    var month = today.getMonth() + 1;
    var year = today.getFullYear();
    var date = year + "-" + month + "-" + day;
    return date;
}

function formatQuickReply(value, row, index){
	if(value==''){
		return '';
		}
	if(value.length<40){
		return value;
	}else{
		return '<span title="' + value+ '" width="24px" height="18px">'+value+'</span>';
	}
};
//中英文字符校验
$.extend($.fn.validatebox.defaults.rules,
    {
        maxCNLen: {
            validator: function (value, param) {
                var cArr = value.match(/[^\x00-\xff]/ig);
                var len = value.length + (cArr == null ? 0 : cArr.length);
                return len <= param[0]*2;
            },
            message: '长度不能大于{0}个字符'
        },
        maxLen: {
            validator: function (value, param) {
                var len = value.length ;
                return len <= param[0];
            },
            message: '长度不能大于{0}个字符'
        },
        compareEndDateTime: {
            validator: function(value,param){
                var dateTime = $("#"+param[0]).datetimebox('getValue');
                if(dateTime){
                    return value > dateTime;
                }else{
                    return true;
                }

            },
            message: '结束时间必须大于开始时间'
        },
        compareStartDateTime: {
            validator: function(value,param){
                var dateTime = $("#"+param[0]).datetimebox('getValue');
                if(dateTime){
                    return value < dateTime;
                }else{
                    return true;
                }
            },
            message: '结束时间必须大于开始时间'
        }
    });