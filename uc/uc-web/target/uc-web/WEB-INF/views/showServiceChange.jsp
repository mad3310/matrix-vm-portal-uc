<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/registerApp.css"/>
<style>
  .nav-tabs-wj li a{ display:block;height:42px; line-height: 42px;}
</style>
<jsp:include page="header-e.jsp"></jsp:include>
<!--head/E-->
<!-- 内容区域/S-->
<div class="password-title text-center">
  <%
    String serviceCode = request.getParameter("serviceCode");
    String serviceName="";
    if("100".equals(serviceCode)){
      serviceName="云直播";
    }
    if("101".equals(serviceCode)){
      serviceName="云点播";
    }
    if("110".equals(serviceCode)){
      serviceName="CDN-流媒体分发";
    }
    if("111".equals(serviceCode)){
      serviceName="CDN-文件加速";
    }
  %>
  <div class="h3"><%=serviceName%>服务变更</div>
  <p class="shortline"></p>
</div>
<section class="le-section-user comwidth clearfix">
  <h4 class="server-bill-title-wj"><span>CDN计费</span><i class="icon-radius-down"></i></h4>
  <div class="server-bill-con-wj border-bottom row clearfix">
    <div class="le-col-6">
      <ul class=" nav-tabs-wj clearfix" role="tablist" id="feeTypes">
        <li role="presentation" class="${feeCode eq "001"? 'active':'unActive'}" value="001"><a id="byliuliang" href="#liuliang" aria-controls="liuliang" role="tab" data-toggle="tab">按流量</a><i class="down-arrow-ico"></i></li>
        <li role="presentation" class="${feeCode eq "002"? 'active':'unActive'}" value="002"><a id="bydaikuan" href="#kuandai" aria-controls="kuandai" role="tab" data-toggle="tab">按带宽</a><i class="down-arrow-ico"></i></li>
      </ul>
      <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="liuliang">
          <%--<p>资费：月使用流量10G以下免费，？G以上0.1元/G起</p>--%>
          <p>生效日期： ${date}</p>
        </div>
        <div role="tabpanel" class="tab-pane" id="kuandai">
          <%--<p>资费：月使用流量20G以下免费，？G以上0.1元/G起</p>--%>
          <p>生效日期： ${date}</p>
        </div>
      </div>
    </div>
    <div class="le-col-3">
      <p class="mt-15"><a href="http://help.letvcloud.com/Wiki.jsp?page=BillingProcess" target="_blank" class="text-important">详细计费规则 &gt;</a></p>
      <%--<p class="mt-30"><a href="http://help.letvcloud.com/Wiki.jsp?page=BillingProcess" target="_blank" class="text-important">联系商务了解更多计费方式 &gt;</a></p>--%>
    </div>
  </div>
  <div class="server-bill-con-wj row clearfix">
    <div class="le-col-6">
      <div class="server-bill-open-wj clearfix">
        <p class="yue"><span>账户余额</span><span id="user_account" class="money">￥ ${amount}</span>
          <%--<a id="btnCz" href="#" class="btn btn-important btn-xl">立即充值</a></p>--%>
        <p class="text-primary mt-30">余额充足可保障服务超出免费额度后的正常使用</p>
        <!-- 如果金额充足 那么就可以点击开通服务-->
        <%--<p class="mt-50"><button type="button" class="btn btn-primary btn-xxl" data-toggle="modal" data-target="#openServerModal">开通服务</button></p>--%>
        <p class="mt-50"><button type="button" class="btn btn-primary btn-xxl" id="changeService">变更服务</button>
        <!-- 金额不足那是不可点击的,那么这样写 <p class="mt-50"><button type="button" class="btn btn-primary btn-xxl disabled" data-toggle="modal" data-target="#openServerModal">开通服务</button></p>-->
      </div>
    </div>
  </div>
</section>
<!-- 内容区域/E-->
<!-- 开通服务/S -->
<div class="modal fade" id="openServerModal" tabindex="-1" role="dialog" aria-labelledby="openServerModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header modal-header-primary">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="openServerModalLabel">&nbsp;</h4>
      </div>
      <div class="modal-body">
        <div class="modal-warp modal-warp-open-server row clearfix">
          <h3 class="text-center"><i class="icon-modal-ok"></i>云点播服务（<span id="popFeeModspan">按流量</span>计费）已变更</h3>
          <p id="changeDate" class="text-center">${date}变更生效，3s后自动跳转我的服务</p>
          <p class="text-center mt-20"><a href="http://vod.letvcloud.com/user/userinfo" class="btn btn-primary btn-xl">点播控制台</a> <a href="http://help.letvcloud.com/" class="text-primary ml-10">了解更多产品>></a></p>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- 开通服务/E -->
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>

<!-- footer/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/serverApp.js?t=20150421"></script>
<script type="text/javascript">
  document.domain = "letvcloud.com";
  $=require("lib/jquery.min");
  require("lib/bootstrap.min");
  $(function(){
    var feeCode = '${feeCode}';

//    if(feeCode == '001'){
//      var current=$("#feeTypes").find("li").eq(0);
//      current.click(function () {
//        return false;
//      })
//    }else{
//      var current=$("#feeTypes").find("li").eq(1);
//      current.click(function () {
//        return false;
//      })
//    }
    var changeService=$("#changeService");
    changeService.addClass("disabled");
    $("#feeTypes li.unActive").click(
            function () {
                changeService.removeClass("disabled");
            }
    );
    $("#feeTypes li.active").click(
            function () {
              changeService.addClass("disabled");
            }
    );
    var serviceCode='${serviceCode}';
    var urlSuc;
    if(serviceCode=='100'){
      urlSuc='/serviceOpen/showLive.do';
    }
    if(serviceCode=='101'){
      urlSuc='/serviceOpen/showVod.do';
    }
    $("#changeService").click(
            function(){
              $("#popFeeModspan").text($("#feeTypes li.active a").text());
              var params={
                serviceCode:serviceCode,
                feeCodeNext:$("#feeTypes li.active").attr("value"),
                featherCode:serviceCode+'100'
              }
              var url="/serviceOpen/changeService.do";
              $.post(url,params,function(data){
                if(data.state == 1){
                  $("#changeDate").text(data.date+"变更生效，3s后自动跳转我的服务");
                  $("#openServerModal").modal("show");
                  setTimeout(function () {
                    window.location.href = urlSuc
                  }, 3000);
                }
              },"json");
            }
    );
  });
  //充值成功的操作
  function rechargeBackFunction(data){
    $("#user_account").text("￥ "+data);
  }
</script>
<jsp:include page="rechargeFrame.jsp"></jsp:include>
</body>
</html><!-- file tree:
|...yundianbo-fuwu-change.html
|   |...header-register.html
|   |...footer.html
- By MOKTEXT. -->