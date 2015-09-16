<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/usercenterApp.css"/>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/usercenterNullApp.css"/>
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
        <div class="null-img"></div>
        <div class="null-intro row">
          <div class="null-db le-col-6">
            <h1>为您提供全方位视频服务</h1>
            <a href="${ctx}/serviceOpen/vodOpen.do"><input type="button" value="立刻开通"></a>
            <a href="http://help.letvcloud.com/Wiki.jsp?page=CloudDemandLetv">了解更多</a>
          </div>
          <div class="null-zb le-col-6">
            <h1>与您共同亲历事件的发生</h1>
            <a href="${ctx}/serviceOpen/openLiveConfirm.do"><input type="button" value="立刻开通"></a>
            <a href="http://help.letvcloud.com/Wiki.jsp?page=CloudSeedingLetv">了解更多</a>
          </div>
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
 <script type="text/javascript">
  $ = jQuery = require("lib/jquery.min");//jquery
  require("lib/bootstrap.min");//modal
  //充值成功
  function rechargeBackFunction(data){
    if(data <0){
      $("#serviceStateSpan").text("欠费").attr("class","text-danger");
      $("#chongzhiDiv").show();
    }else{
      $("#serviceStateSpan").text("正常").attr("class","");
      $("#chongzhiDiv").hide();
    }
  }
</script>
<jsp:include page="rechargeFrame.jsp"></jsp:include>
</body>
</html><!-- file tree:
|...usercenter-myservice-cdn.html
|   |...header-usercenter.html
|   |...usercenter-header.html
|   |...footer.html
- By MOKTEXT. -->