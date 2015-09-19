<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="/assets/css/main/usercenterApp.css"/>
<style type="text/css">
    .paging {
        margin-top: -20px;
        border: solid 1px #e3e3e3;
        border-top: none;
        padding: 20px 0; }
    .paging .ckbox-wraper {
        width: 40px;
        padding-top: 6px; }
    .paging .btn-del-paging {
        height: 34px;
        padding: 6px 34px;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        -ms-border-radius: 3px;
        -o-border-radius: 3px;
        border-radius: 3px; }
    .paging .info-paging {
        line-height: 34px;
        padding: 0 20px; }
    .paging .info-paging a {
        float: left;
        display: inline-block;
        width: 32px;
        height: 34px;
        border: solid 1px #e3e3e3;
        text-align: center;
        margin-left: 10px; }
    .paging .info-paging a.active-btn-paging {
        background: #077cae;
        color: #fff; }
    .paging .info-paging a.prev-btn-paging {
        background: url(http://static.uc.letvcloud.com/images/base/icon-admin-zb.png) no-repeat 12px -70px; }
    .paging .info-paging a.next-btn-paging {
        background: url(http://static.uc.letvcloud.com/images/base/icon-admin-zb.png) no-repeat -18px -70px; }
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
				<h3 class="title-wj">消息中心</h3>
				<dl class="clearfix ml-media">
					<dt class="pull-left" >
						<span class="tags-gray tags-active" onclick = "search('/message/allMessage.do')" id = "allmessage">全部消息<i class="arrow"></i></span>
						<span class="tags-gray" onclick = "search('/message/unReadMessage.do')" id = "unreadmsg">未读消息<i class="arrow"></i></span>
		                <span class="tags-red ml-15"  onclick = "sign('1')">标记为已读</span>
		                <span class="tags-org ml-15"  onclick = "sign('2')">删除</span>
					</dt>
					<dd class="pull-right">
						<form id="searchForm" class="form-inline form-message-search">
							<div class="form-group">
								<label>发送时间</label>
								<input id="d4321" type="text" name="startTime" class="form-control"
								onFocus="WdatePicker({dateFmt:'yyyy-MM',minDate:'2000-01',maxDate:'#F{$dp.$D(\'d4322\')||\'%y-%M-%d\'}',readOnly:true})" value="2014-08" />
								<label>-</label>
								<input id="d4322" type="text" name="endTime" class="form-control"
								onFocus="WdatePicker({dateFmt:'yyyy-MM',minDate:'#F{$dp.$D(\'d4321\')||\'2000-01\'}',maxDate:'%y-%M-%d',readOnly:true})" value="2015-06" />
								<input type="button" class="btn btn-primary btn-xl" value="搜索"  onclick="searchByDate()" />
							</div>
						</form>
					</dd>
				</dl>
				<ul class="message-list clearfix" id="msgcontent" ></ul>
				<div style="margin-top: 0px;" id="rechargePageTool" class="pull-left ml-20"></div>
			</div>
		</div>
		<!-- 右侧/E-->
	</div>
</section>
<!-- 中部内容/E-->
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/usercenterApp.js?t=20150421"></script>
<!-- 由于My97DatePicker不可以模块化，同时在其js中配置了引用自身相对路径的css 和img，故而先引用一套线上的，回头等咱们的上线的更换为咱们的线上地址 -->
<script type="text/javascript" src="http://www.my97.net/dp/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
    $ = jQuery = require("lib/jquery.min");
</script>
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/page/pageTool.js"></script>

<script type="text/javascript">

$(function () {
	search('/message/allMessage.do');
	var d = new Date();
	var s = d.getFullYear().toString() +"-"+ addzero(d.getMonth());
    var e = d.getFullYear().toString() +"-"+ addzero(d.getMonth() + 1);
	$("input[name='startTime']").val(s);
	$("input[name='endTime']").val(e);
});


//标记为已读
function sign(status){
	var id_array=new Array();
	var type_array=new Array();
	$('input[name="msgTitle"]:checked').each(function(){
	    id_array.push($(this).attr('value'));//向数组中添加元素
	    type_array.push($(this).attr('id'));//向数组中添加状态
	});
	if(id_array.length==0){
		alert("没有选中任何消息，请重新选择");
		return;
	}
	var type = getType();
    $.ajax({
    	type: "GET",
        url: "${ctx}/message/modifyMessage.do?msgId=" + id_array + "&msgStatus=" + status +  "&sysType=" + type_array
        		+ "&type=" + type,
        dataType: "JSON",
        success:function(data){
        	if(data.sign == -1){
        		alert("选择的消息已是已读状态，无需再设置");
        	}else{
        		common(data);
            	setPage(data);
        	}
        }
    });
}


//查询
function search(str){
    $.ajax({
    	type: "GET",
        url: "${ctx}" + str,
        dataType: "JSON",
        success:function(data){
        	common(data);
        	labclass(str);
        	setPage(data);
        }
    });
}

//按照时间搜索
function searchByDate(){
	//console.dir($("#searchForm").serialize());
	var type = getType();
    $.ajax({
    	type: "POST",
        url: "${ctx}/message/searchMessage.do",
        data: $("#searchForm").serialize()+"&type="+type,
        dataType: "JSON",
        success:function(data){
        	common(data);
        	setPage(data,"2");
        }
    });
}

//标签class修改
function labclass(str){
	if(str.indexOf("unReadMessage") >=0){
		$("#allmessage").attr("class","tags-gray");
		$("#unreadmsg").attr("class","tags-gray tags-active");
	}else{
		$("#allmessage").attr("class","tags-gray tags-active");
		$("#unreadmsg").attr("class","tags-gray");
	}
}

//展示消息内容
function common(data){
	var items = data.message;
	var $ul = $("#msgcontent");
	$("#msgcontent").empty();
	//$ul.append( "<input id='checkAll' type='checkbox' onclick='selectAll()'/>全选");
	$.each(items, function(idx, message){
		var $li = $("<li>"),
			$div = $("<div class='info'>"),
			$input = $("<input type='checkbox' name='msgTitle'> ")
				.val(message.id).attr("id",message.msgType + message.msgStatus),
			$i = null,
			$a = $("<a href='#' class='txt gray3'>")
				.html(message.msgTitle).attr("href","${ctx}/messageView/msgCenterDetailView.do?msgId="+message.id +"&msgStatus=" + message.msgStatus),
			$span = $("<span class='time'>")
				.html(formatDate(message.createdTime));
			if(message.msgStatus == '0'){
				$i = $("<i class='message-org'>");
			}else if(message.msgStatus == '1'){
				$i = $("<i class='message-gray'>");
			}
		$div.append($input).append($i).append($a);
		$li.append($div).append($span);
		$ul.append($li);
	});
}

function selectAll(){
	var a = $('input[name="msgTitle"]');
	for(var i = 0;i<a.length;i++){
		a[i].checked = true;
	}
}

//时间戳转日期格式
function formatDate(datetime)   {
	var   d =new Date(parseInt(datetime));
    return d.getFullYear().toString() +"-"+ addzero(d.getMonth() + 1) +"-"+ addzero(d.getDate());
}
function addzero(v){
	if (v < 10){
		return '0' + v;
	}
	return v.toString();
}

//判断是全部消息页面(1)还是未读消息页面(2)
function getType(){

	var p_class = $("#allmessage").attr("class"); //获取allmessage元素的class
	var type = "";
	if(p_class.indexOf("active") >=0){
		type = "1";
	}else{
		type = "2";
	}
	return type;
}

//翻页
function nextPage(pageIndex,str){
	if(str!=2){
		var type = getType();
		var url = "";
		if(type == 1){
			url = "/message/allMessage.do";
		}else{
			url = "/message/unReadMessage.do";
		}
		    $.ajax({
		    	type: "POST",
		        url: "${ctx}"+url,
		        data: {"pageIndex":pageIndex},
		        dataType: "JSON",
		        success:function(data){
		        	common(data);
		        	setPage(data);
		        }
		    });
	}else{//时间查询分页
		//console.dir($("#searchForm").serialize());
		var type = getType();
	    $.ajax({
	    	type: "POST",
	        url: "${ctx}/message/searchMessage.do",
	        data: $("#searchForm").serialize()+"&type="+type+"&pageIndex="+pageIndex,
	        dataType: "JSON",
	        success:function(data){

	        	common(data);
	        	setPage(data,"2");
	        }
	    });
	}
}


//页面重置
function setPage(data,str){

	 // 分页信息
     $("#rechargePageTool").pageTool({
         "total": data.totalCount,
         "fetchSize": data.pageInfo.rows,
         "getPage": function (activePage, fetchSize) {// activePage 当前页,从 1 开始。fetchSize为每页的数量
         		nextPage(activePage,str);
         }
     });
}

</script>
</body>
</html><!-- file tree:
|...usercenter-message.html
|   |...header-usercenter.html
|   |...usercenter-header.html
|   |...footer.html
- By MOKTEXT. -->