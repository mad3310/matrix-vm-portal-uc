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

                <div class="service-yun bottom-line">
                    <h3 class="title-wj"><i class="zhibo-ico pull-left mr10"></i>云直播</h3>

                    <div class="row">
                        <div class="le-col-4">
                            当前计费方式：：<c:if test="${billServiceOpen.feeCodeNow == '001'}">
                            按流量
                        </c:if>
                            <c:if test="${billServiceOpen.feeCodeNow == '002'}">
                                按带宽
                            </c:if>
                        </div>
                        <div class="le-col-4">
                            业务状态：<span class="text-danger">
										<c:if test="${billServiceOpen.amountState == 0}">
                                            欠费
                                        </c:if>
                                        <c:if test="${billServiceOpen.amountState == 1}">
                                            正常
                                        </c:if>
									</span>
                        </div>
                        <div class="le-col-4">
                            <a href="#" class="btn btn-danger">立即充值</a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="le-col-4">
                            下月计费方式：<c:if test="${billServiceOpen.feeCodeNext == '001'}">
                            按流量
                        </c:if>
                            <c:if test="${billServiceOpen.feeCodeNext == '002'}">
                                按带宽
                            </c:if>
                            <a href="${ctx}/businessView/modifyBillWayView.do?featherCode=${billServiceOpen.featherCode}&serviceCode=${billServiceOpen.serviceCode}" class="ml-10">[更改]</a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="le-col-4">
                            本月峰值带宽： 2000G
                        </div>
                        <div class="le-col-4">
                            本月转码时长： 6000分钟
                        </div>
                    </div>
                </div>
                <div class="service-opened">
                    <h3 class="title-wj">已开通的增值服务</h3>

                    <div class="row">
                        <div class="le-col-md-5 le-col-3">
                            <div class="le-col-6">
                                logo去水印
                            </div>
                            <div class="text-center le-col-6">
                                <div class="opened"><i></i>已开通</div>
                                <div class="service-switch">
                                    <a href="#" class="btn btn-default">关闭</a>
                                </div>
                            </div>
                        </div>
                        <div class="le-col-3 le-col-md-5">
                            <div class="le-col-6">
                                去逛逛
                            </div>
                            <div class="text-center le-col-6">
                                <div class="closed"><i></i>已关闭</div>
                                <div class="service-switch">
                                    <a href="#" class="btn btn-green">开启</a>
                                </div>
                            </div>
                        </div>
                        <div class="le-col-3 le-col-md-5">
                            <div class="le-col-6">
                                视频门户推广
                            </div>
                            <div class="text-center le-col-6">
                                <div class="opened"><i></i>已开通</div>
                                <div class="service-switch">
                                    <a href="#" class="btn btn-default">关闭</a>
                                </div>
                            </div>
                        </div>
                        <div class="le-col-3 le-col-md-5">
                            <div class="le-col-6">
                                logo去水印
                            </div>
                            <div class="text-center le-col-6">
                                <div class="opened"><i></i>已开通</div>
                                <div class="service-switch">
                                    <a href="#" class="btn btn-default">关闭</a>
                                </div>
                            </div>
                        </div>
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
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/usercenterApp.js?t=20150421"></script>
</body>
</html>
<!-- file tree:
|...usercenter-myservice-zb.html
| |...header-usercenter.html
| |...usercenter-header.html
| |...footer.html
- By MOKTEXT. -->