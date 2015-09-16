<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/registerApp.css"/>

<jsp:include page="header-e.jsp"></jsp:include>
<!--head/E-->
<!-- 内容区域/S-->
<div class="password-title text-center">
    <div class="h3">修改计费方式</div>
    <p class="shortline"></p>
</div>
<section class="le-section-user comwidth clearfix">

    <form id="modifyBillWayForm" action="${ctx}/business/modifyBillWay.do" method="post">
        <input type="hidden" name="featherCode" value="${featherCode}">
        <input type="hidden" name="serviceCode" value="${serviceCode}">
        <h4 class="server-bill-title-wj"><span>计费方式</span><i class="icon-radius-down"></i></h4>

        <div class="server-bill-con-wj border-bottom row clearfix">
            <div class="le-col-6">
                <ul class="nav nav-tabs-wj" role="tablist">
                    <li role="presentation" class="active"><a href="#liuliang" aria-controls="liuliang" role="tab"
                                                              data-toggle="tab">按流量</a><i class="down-arrow-ico"></i>
                    </li>
                    <li role="presentation"><a href="#kuandai" aria-controls="kuandai" role="tab"
                                               data-toggle="tab">按宽带</a><i class="down-arrow-ico"></i></li>
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="liuliang">
                        <p>资费：月使用流量10G以下免费，？G以上0.1元/G起</p>

                        <p>生效日期： 2015.07.01</p>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="kuandai">
                        <p>资费：月使用流量20G以下免费，？G以上0.1元/G起</p>

                        <p>生效日期： 2015.07.01</p>
                    </div>
                </div>
            </div>
            <div class="le-col-3">
                <p class="mt-15"><a href="#" target="_blank" class="text-important">详细计费规则 &gt;</a></p>

                <p class="mt-30"><a href="#" target="_blank" class="text-important">联系商务了解更多计费方式 &gt;</a></p>
            </div>
        </div>
        <div class="server-bill-con-wj row clearfix">
            <div class="le-col-6">
                <div class="server-bill-open-wj clearfix">
                    <p class="yue"><span>账户余额</span><span class="money">￥ 0</span><a href="#"
                                                                                     class="btn btn-important btn-xl">立即充值</a>
                    </p>

                    <p class="text-primary mt-30">余额充足可保障服务超出免费额度后的正常使用</p>
                    <!-- 如果金额充足 那么就可以点击开通服务-->
                    <p class="mt-50">
                        <button type="submit" class="btn btn-primary btn-xxl" data-toggle="modal"
                                data-target="#openServerModal">修改
                        </button>
                    </p>
                    <!-- 金额不足那是不可点击的,那么这样写 <p class="mt-50"><button type="button" class="btn btn-primary btn-xxl disabled" data-toggle="modal" data-target="#openServerModal">开通服务</button></p>-->
                </div>
            </div>
        </div>
    </form>
</section>
<!-- 内容区域/E-->
<!-- 开通服务/S -->
<div class="modal fade" id="openServerModal" tabindex="-1" role="dialog" aria-labelledby="openServerModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="openServerModalLabel">&nbsp;</h4>
            </div>
            <div class="modal-body">
                <div class="modal-warp modal-warp-open-server row clearfix">
                    <h3 class="text-center"><i class="icon-modal-ok"></i>云点播服务（按流量计费）已开通</h3>

                    <p class="text-center">15.07.01变更生效，3s后自动跳转云点播控制台</p>

                    <p class="text-center mt-20"><a href="#" class="btn btn-primary btn-xl">点播控制台</a> <a href="#"
                                                                                                         class="text-primary ml-10">了解更多产品>></a>
                    </p>
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
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/jquery-1.7.2.min.js"></script>

<script type="text/javascript">


</script>
</body>
</html>
<!-- file tree:
|...yundianbo-fuwu-change.html
| |...header-register.html
| |...footer.html
- By MOKTEXT. -->