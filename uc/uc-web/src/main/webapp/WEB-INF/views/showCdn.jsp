<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/usercenterApp.css"/>
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
        <h3 class="title-wj">已开通服务</h3>
        <div class="service-yun no-bottom">
          <h3 class="title-wj"><i class="cdn-ico pull-left mr10"></i>CDN</h3>
          <div class="row">
            <div class="le-col-6 padding-service le-col-md-10">
              <div class="title-wj bottom-line">
                <c:if test="${vodExist}">
                    <div class="">CDN-文件加速</div>
                  </div>
                  <div class="row">
                    <div class="le-col-6">当前计费方式：${vodFeeCode}</div>
                    <div class="le-col-6">业务状态：<span id="serviceStateSpan" <c:if test="${vodState == 0}">class="text-danger"</c:if>>${vodState eq 0 ? "欠费":"正常"}</span></div>
                  </div>
                  <%--<div class="row">--%>
                    <%--<div class="le-col-6">下月计费方式：${empty vodFeeCodeNext or vodFeeCodeNext eq ''? vodFeeCode:vodFeeCodeNext} <a href="/serviceOpen/showServiceChange.do?serviceCode=111" class="ml-10">[更改] </a>--%>
                    <%--</div>--%>
                  <%--</div>--%>
                  <div class="row">
                    <div class="le-col-6">本月累计流量： ${vodTraffic}</div>
                    <div class="le-col-6">本月峰值带宽： ${vodBandwidth}</div>
                  </div>
                </div>
            </c:if>
            <c:if test="${liveExist eq true}">
                  <div class="le-col-6 padding-service le-col-md-10">
                    <div class="title-wj bottom-line">
                      <div class="">CDN-流媒体分发</div>
                    </div>
                    <div class="row">
                      <div class="le-col-6">当前计费方式：${liveFeeCode}</div>
                      <div class="le-col-6">业务状态：<span <c:if test="${liveState == 0}">class="text-danger"</c:if>>${liveState eq 0 ? "欠费":"正常"}</span>
                      </div>
                    </div>
                    <%--<div class="row">--%>
                      <%--<div class="le-col-6">下月计费方式：${empty liveFeeCodeNext or liveFeeCodeNext eq ''? liveFeeCode:liveFeeCodeNext} <a href="/serviceOpen/showServiceChange.do?serviceCode=111" class="ml-10">[更改] </a>--%>
                      <%--</div>--%>
                    <%--</div>--%>
                    <div class="row">
                      <div class="le-col-6">本月累计流量： ${liveTraffic}</div>
                      <div class="le-col-6">本月峰值带宽： ${liveBandwidth}</div>
                    </div>
                  </div>
              </c:if>
            <%--<c:if test="${liveState eq 0 || vodState eq 0}">--%>
              <div id="chongzhiDiv" class="le-col-12 le-col-md-10 mt-20" style="display:${liveState eq 0 || vodState eq 0 ?'block':'none'}">
                <a id="btnCz" href="#" class="btn btn-danger pull-right mr20">立即充值</a>
              </div>
            <%--</c:if>--%>
          </div>
        </div>
      </div>
    </div>
    <!-- 左侧/E-->
  </div>
</section>
<!-- 中部内容/E-->
<!-- 引入底部foot-->
<!-- footer/S-->
<footer class="footer">
  <div class="comwidth clearfix">
    <div class="pull-left">
      <p class="clearfix"><a href="#">云产品</a><span class="space">|</span><a href="#">解决方案</a><span class="space">|</span><a href="#">帮助与支持</a><span class="space">|</span><a href="#">关于</a></p>
      <p class="clearfix"><a href="#">京ICP备09045969号-7</a><span class="company">Copyright © 2004-2012 乐视网（letv.com）All right</span><a href="#"><i class="icon-nation-a"></i></a><a href="#"><i class="icon-nation-b"></i></a></p>
      <p class="clearfix"><a href="#"><i class="icon-foot-sina"></i></a><a href="#"><i class="icon-foot-wechat"></i></a></p>
    </div>
    <div class="pull-right">
      <span><label>可信云认证</label><i class="icon-authentication-a"></i></span>
      <span><label>ISO27001认证</label><i class="icon-authentication-b"></i></span>
    </div>
  </div>
</footer>
<!-- footer/E-->

 <script type="text/javascript" src="${ctx}/assets/js/min/usercenterApp.js?t=20150421"></script>
 <script type="text/javascript">
   document.domain = "letvcloud.com";
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