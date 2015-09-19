<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="/assets/css/main/usercenterApp.css"/>
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
			<div class="le-user-con clearfix" id="detail">
				<h3 class="title-wj">消息中心</h3>
				<dl class="message clearfix">
					<dt class="pull-left" id="msgId">
		                <a href="${ctx}/messageView/msgCenterView.do"><span class="tags-red">返回消息列表</span></a>
		                <a href="${ctx}/message/delMessage.do?msgId=${message.id}" id="hrefId"> <span class="tags-org ml-15" >删除</span></a>
					</dt>
					<dd class="pull-right">
						<span class="btn-pre"  onClick="preNextMsg(${message.id},0)" id="preId"></span>
						<span class="btn-next" onClick="preNextMsg(${message.id},1)" id="nextId"></span>
					</dd>
				</dl>
				<p class="list-title clearfix">
				    <span class="txt" id="msgTitle">${message.msgTitle}</span>
				    <span class="time" id="createdTime"><fmt:formatDate value="${message.createdTime}" pattern="yyyy-MM-dd"/></span>
				</p>
				<div class="message-info"  id="msgContent">
				    <p>${message.msgContent}</p>
				</div>
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
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/jquery-1.7.2.min.js"></script>
<script type="text/javascript">

//上一条、下一条
function preNextMsg(msgId,type){

    //alert("成功");

    $.ajax({
		type: "POST",
	    url: "${ctx}/message/preNextMessage.do?msgId="+msgId+"&type="+type,
	    dataType: "JSON",
	    success:function(data){
	    	message = data.message;
	    	$("#hrefId").attr("href","${ctx}/message/delMessage.do?msgId="+message.id);
	    	$("#preId").attr("onClick","preNextMsg('"+message.id+"',0)");
	    	$("#nextId").attr("onClick","preNextMsg('"+message.id+"',1)");
	    	$("#msgTitle").html(message.msgTitle);
	    	$("#createdTime").html(formatDate(message.createdTime));
	    	$("#msgContent").html($("<p>").html(message.msgContent));
	    	debugger;
	    	if(data.pre == 0){
	    		$("#preId").hide();
	    	}else{
	    		$("#preId").show();
	    	}
	    	if(data.next == 0){
	    		$("#nextId").hide();
	    	}else{
	    		$("#nextId").show();
	    	}
	    }
	});
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

$(function(){
	var pre = "${pre}";
	if(pre!=''&&pre==0){
		$("#preId").hide();
	}
	var next = "${next}";
	if(next!=''&&next==0){
		$("#nextId").hide();
	}
});

 </script>
</body>
</html><!-- file tree:
|...usercenter-message-detail.html
|   |...header-usercenter.html
|   |...footer.html
- By MOKTEXT. -->