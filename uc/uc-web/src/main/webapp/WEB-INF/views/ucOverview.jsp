<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="/assets/css/main/usercenterApp.css"/>
<style type="text/css">

    .btn-yzm {
        font-size: 16px;
        height: 35px;
        width: 160px;
        line-height: 35px;
        border-radius: 3px;
        text-align: center;
        display: inline-block;
        line-height: 22px;
        background: #38b8e9;
        position: relative;
        top: -1px;
        left: 3px;
        border: none;
        color: #fff;
    }
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
                <h3 class="title-wj">用户信息</h3>
                <input type="hidden" id="userTypeHide">
                <input type="hidden" id="contactsInput">
                <div class="info-box-borded-wj row clearfix">
                    <div class="le-col-7 le-col-md-8 user-info-wj">
                        <div class="face">
                            <p><img src="<c:if test="${empty userAvatar }">${ctx}/assets/images/st-user-face-default.jpg</c:if>
                            	<c:if test="${not empty userAvatar }">${userAvatar}</c:if>"
                             id="showImgFace" alt="用户头像" title="用户头像"/></p>
                        </div>
                        <div class="info">
                            <h4 class="title-wj"><span style="display: inline-block;float: left;width: 45px;">您好</span><span style="display: inline-block;float: left;width: 230px;white-space: pre-wrap;word-break: break-all;" class="text-primary" id="contacts"></span> </h4>
                            <input type="hidden" id="email">
                            <p>会员类型：<span id="userType"></span></p>

                            <div class="verify clearfix">
                                <!--如果用户已认证某一项 那么加入had -->
                                <a href="#" data-toggle="tooltip" data-placement="bottom" title="手机未认证"><i
                                        class="icon-user-phone"></i></a>
                                <a href="#" data-toggle="tooltip" data-placement="bottom" title="邮箱未验证"><i
                                        class="icon-user-email"></i></a>
                                <a href="#" data-toggle="tooltip"  data-placement="bottom" title="资质未认证"><i
                                        class="icon-user-idcard"></i></a>
                            </div>
                        </div>
                    </div>
                    <div class="le-col-5 le-col-md-4 user-msg-wj">
                        <a href="${ctx }/messageView/msgCenterView.do" class="msg">
                            <i class="icon-user-yuan"></i>
                            <i class="icon-user-msg-h"></i>

                            <p id="msgShow"></p>
                            <i  id="unReadMsgCount"></i>
                        </a>
                    </div>
                </div>
                <h3 class="title-wj">账户余额</h3>

                <div class="info-box-borded-wj row clearfix">
                    <div class="le-col-7 le-col-md-6">
                        <!-- 如果该账户已欠费 才会有arrear样式 这样鼠标滑过才有信息显示-->
                        <a href="javascript:;" class="user-account-wj arrear">
                            <span id="user-account"></span>

                            <!-- <p class="clearfix"><i
                                    class="icon-account-arrow"></i><label>您的账号已欠费，将在5月15日冻结，请您尽快充值</label></p> -->
                        </a>
                    </div>
                    <div class="le-col-5 le-col-md-6">
                        <p class="pull-right btn-groups">
		            <a href="javascript:void(0);" id="btnCz" class="btn btn-important btn-xl">充值</a>
                            <a href="${ctx}/recharge/rechargeDetailsView.do" class="btn btn-primary btn-xl">明细</a>
                        </p>
                    </div>
                </div>
                <c:if test="${isExist}">
                <h3 class="title-wj">已开通业务</h3>
                    <div class="info-box-server-wj row clearfix">
                     <c:if test="${isVod}">
                        <div class="le-col-4 le-col-md-12">
                            <a href="${ctx}/serviceOpen/showVod.do" class="title-server-wj bg-primary" title="云点播">
                                <i class="icon-server-ydb"></i>
                                <span>云点播</span>
                                <i class="icon-arrow-right"></i>
                            </a>

                            <div class="info-server-wj">
                                <ul class="clearfix">
                                    <li>当前计费方式：${vodFeeCodeNow eq '001'?'按流量':'按带宽'}</li>
                                    <li>
                                        业务状态：
                                        <c:choose>
                                            <c:when test="${vodState eq '0'}">
                                                <span class="text-important">欠费</span>
                                            </c:when>
                                            <c:otherwise>
                                                正常
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                    <%--<li>下月计费方式: ${liveFeeCodeNext eq '001'?'按流量':'按带宽'}</li>--%>
                                </ul>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${isLive}">
                        <div class="le-col-4 le-col-md-12">
                            <a href="/serviceOpen/showLive.do" class="title-server-wj bg-success" title="云直播">
                                <i class="icon-server-yzb"></i>
                                <span>云直播</span>
                                <i class="icon-arrow-right"></i>
                            </a>

                            <div class="info-server-wj">
                                <ul class="clearfix">
                                    <li>当前计费方式：${liveFeeCodeNow eq '001'?'按流量':'按带宽'}</li>
                                    <li>
                                        业务状态：
                                        <c:choose>
                                            <c:when test="${liveState eq '0'}">
                                                <span class="text-important">欠费</span>
                                            </c:when>
                                            <c:otherwise>
                                                正常
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                    <%--<li>下月计费方式：${vodFeeCodeNext eq '001'?'按流量':'按带宽'}</li>--%>
                                </ul>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${isCdn}">
                        <div class="le-col-4 le-col-md-12">
                            <a href="/serviceOpen/showCdn.do" class="title-server-wj bg-important" title="CDN">
                                <i class="icon-server-cdn"></i>
                                <span>CDN</span>
                                <i class="icon-arrow-right"></i>
                            </a>
                                <ul class="info-server-wj clearfix">
                                    <c:forEach items="${cdns}" var="service">
                                        <ul class="clearfix">
                                            <li>
                                                <c:if test="${service.serviceCode eq '110'}">
                                                   CDN-流媒体分发
                                                </c:if>
                                                <c:if test="${service.serviceCode eq '111'}">
                                                   CDN-文件加速
                                                </c:if>
                                            </li>
                                            <li>
                                                当前计费方式：
                                                <c:if test="${service.feeCodeNow eq '001'}">
                                                    按流量
                                                </c:if>
                                                <c:if test="${service.feeCodeNow eq '002'}">
                                                    按带宽
                                                </c:if>
                                                <c:if test="${service.feeCodeNow eq '003'}">
                                                    95峰值
                                                </c:if>
                                                <c:if test="${service.feeCodeNow eq '004'}">
                                                    第四峰值
                                                </c:if>
                                                <c:if test="${service.feeCodeNow eq '005'}">
                                                    月最高峰
                                                </c:if>
                                                <c:if test="${service.feeCodeNow eq '006'}">
                                                    总月流量
                                                </c:if>
                                                <c:if test="${service.feeCodeNow eq '007'}">
                                                    日峰均值
                                                </c:if>
                                            </li>
                                        </ul>
                                    </c:forEach>
                                </div>
                        </div>
                    </c:if>
                </div>
                </c:if>
            </div>
        </div>
        <!-- 左侧/E-->
    </div>
</section>
<!-- 中部内容/E-->

<!-- 手机绑定/S -->
<div class="modal fade" id="editPhoneModal" tabindex="-1" role="dialog" aria-labelledby="editPhoneModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" style="width: 650px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" data-dismiss="modal" id="editPhoneClose" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="editMobileTitle">更换绑定手机</h4>
            </div>
            <div class="modal-body" style="padding-top: 0;">
                <div class="modal-warp modal-warp-edit-phone row clearfix">
                    <p class="text-color-yao" id="preModifyCurrentMobile"></p>

                    <form class="form-horizontal form-sms" id="modifyMobileForm" >
                        <div class="form-group">
                            <label class="le-col-3 control-label">国家／地区：</label>

                            <div class="le-col-5 tel-wraper clear-left">
                                <select class="select" onchange="addAreaNum(this.value)">


                                    <c:forEach var="country" items="${countryList}">
                                        <option value="${country.countryAreaNum}">${country.countryName}</option>
                                    </c:forEach>


                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="le-col-3 control-label">变更手机号： </label>

                            <div class="le-col-5 tel-wraper clear-left">
                           		<input id="areaInput" name="areaInput" type="hidden" value="86"/>
                                <span class="pull-left" style="left:0" id="tel-wraper-span">+86</span>
                                <input type="text" name="mobile"
                                		class="form-control form-input-required form-input-required-phone form-sms-phone"
                                		id="mobileInput" nullmsg="请输入手机号！" errormsg="请输入正确的手机号"
                                		onblur="isMobile(this.value)"/>
                            </div>
                              <div class="le-col-4">
                                <div class="Validform_checktip ml-15" id="mobileMsg"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="uphoneCode" class="le-col-3 control-label">验证码：</label>

                            <div class="le-col-2 clear-left">
                                <input type="text" class="form-control" id="uphoneCode" placeholder="6位数字"
                                       onblur="checkMobileCode(this.value)"/>
                            </div>
                            <div class="le-col-3">
                                <button type="button" class="btn-yzm btn-sms-code disabled" id="sendMsg2MobileBtn"
                                        onclick="sendMsg2Mobile()">免费获取验证码
                                </button>
                            </div>
                            <div class="le-col-4">
                            	<div class="Validform_checktip ml-15" id="mobileCaptchaMsg"></div>
                           	</div>
                        </div>
                        <div class="form-group">
                            <div class="le-col-8 le-col-offset-2">
                                <input type="button" class="btn btn-primary btn-xl btn-submit mt-20 btn-yao"
                                       value="确定" onclick="submitModifyMobile();"/>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <!-- <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
              <button type="button" class="btn btn-primary">保存</button>
            </div> -->
        </div>
    </div>
</div>
<!-- 手机绑定/E -->
<!-- 手机绑定成功/S -->
<div class="modal fade" id="changePhoneSuccessModal" tabindex="-1" role="dialog" aria-labelledby="changePhoneSuccessModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 540px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
               <a href="${ctx}/logout.do"><button type="button" class="close"><span aria-hidden="true">&times;</span></button></a>
                <h4 class="modal-title" >更换绑定手机</h4>
            </div>
            <div class="modal-body" style="padding-top: 0;">
                <div class="modal-warp modal-warp-edit-phone row clearfix">
                    <div class="icon-success-wraper clearfix"><i class="icon-success"></i><div class="h4 ml-10">更换绑定手机成功</div></div>
                    <p class="text-center" id="ModifiedMobile"></p>
                    <div class="text-center">
                       <a href="${ctx}/logout.do"><button class="btn btn-primary btn-xl">确定</button></a>
                      <%--  确定 --%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 手机绑定成功/E -->

<!-- 已认证通过不允许修改账号信息 -->
<div class="modal fade" id="showDialogDiv" tabindex="-1" role="dialog" aria-labelledby="changePhoneSuccessModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 540px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <a href="javascript:hideshowDialogDiv()"><button type="button" class="close"><span aria-hidden="true">&times;</span></button></a>
                <h4 class="modal-title" id="showTitle">温馨提醒</h4>
            </div>
            <div class="modal-body" style="padding-top: 0;">
                <div class="modal-warp modal-warp-edit-phone row clearfix">
                    <p><i class="icon-user-danger"></i><span class="h4 ml-10" id="dialogInfo">请检查信息录入是否正确</span></p>
                    <div class="text-center">
                        <a href="javascript:hideshowDialogDiv()" id="confirmButton"><button class="btn btn-primary btn-xl">确定</button></a>
                        <%--  确定 --%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 同意协议弹层/S -->
<div class="modal fade" id="deleteModal02" tabindex="-1" role="dialog" aria-labelledby="deleteModal02" aria-hidden="true" >
    <div class="modal-dialog" style="width: 600px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" id="close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >乐视云计算新版官网隆重上线</h4>
            </div>
            <div class="modal-body">
                <div class="login-agree clearfix">
                    <h2>新版官网如约而至，您将得到的是：</h2>
                    <ul>
                        <li>• 云点播新装上线，为您提供全方位的视频服务；</li>
                        <li>• 云直播全新起航，与您共同亲历事件的发生；</li>
                        <li>• 线上充值自助化购买，降低使用门槛；</li>
                    </ul>
                    <h4>全新的视界，全新的云计算！</h4>
                    <h3>请阅读并同意以下条款：</h3>
                    <div class="yunAgree">
                        <h1>乐视云服务协议</h1>
                        <div class="WordSection1" style="layout-grid:15.6pt">
                        <p></p><p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">欢迎您使用<span class="GramE">乐视云服务</span>！<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">为使用乐视云服务（以下简称：本服务），您应当阅读并遵守《乐视云服务协议》（以下简称<span lang="EN-US">:</span>本协议）等相关协议、规则。</span></b><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">请您务必审慎阅读、充分理解各条款内容，特别是限制或免除责任的条款，以及开通或使用某项服务的单独协议、规则。限制或免责条款可能以加粗形式提示您注意。</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">除非您已阅读并接受本协议及相关协议、规则等所有条款，否则，您无权使用本服务。您使用本服务的任何行为，即视为您已阅读并同意上述协议、规则等的约束。您有违反本协议的任何行为时，乐视云有权依照其违反情况随时单方限制、中止或终止向您提供本服务，并有权追究您的相关责任。</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:17.0pt;margin-right:0cm;margin-bottom:16.0pt;margin-left:
0cm"><b><span lang="EN-US" style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">1. </span></b><b><span style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">协议范围</span></b><span lang="EN-US" style="font-size:15.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">1.1 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">协议适用主体范围</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">本协议是您与<b>乐<span class="GramE">视云计算</span>有限公司</b>（本协议中简称为“乐视云”）之间关于您使用<span class="GramE">本服务</span>所订立的协议。<span lang="EN-US">&nbsp;<o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">1.2 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">协议关系及冲突条款</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">本协议内容同时包括乐<span class="GramE">视云可能</span>不断发布的关于<span class="GramE">本服务</span>的相关协议、业务规则等内容。上述内容一经正式发布，即为本协议不可分割的组成部分，<span class="GramE">您同样</span>应当遵守。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:17.0pt;margin-right:0cm;margin-bottom:16.0pt;margin-left:
0cm"><b><span lang="EN-US" style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">2. </span></b><b><span style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">术语含义</span></b><span lang="EN-US" style="font-size:15.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">如无特别说明，下列术语在本协议中的含义为：<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">2.1 </span></b><span class="GramE"><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">乐视云服务</span></b></span><span lang="EN-US" style="font-size:10.5pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span class="GramE"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">乐视云服务</span></span><span style="font-size:9.0pt;font-family:
&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">：指为满足各类网站、应用等各种产品的不同需求，由乐<span class="GramE">视云提供</span>的云点播、云直播、<span lang="EN-US">CDN</span>等各种不同要素组合成的云平台服务。具体服务类别以乐<span class="GramE">视云公开</span>发布的相关服务信息为准。在本协议中称为“本服务”。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">乐视<span class="GramE">云和您均同意</span>和理解：乐<span class="GramE">视云仅</span>向您提供<span class="GramE">各类云平台</span>服务，<span class="GramE">本服务</span>是中立的信息存储空间等网络服务及相关的中立技术支持服务等。<span class="GramE">乐视云不</span>参与您的网站、应用等任何产品、服务及相关内容的开发、运营等，<span class="GramE">乐视云也</span>不会对您的代码和数据等任何内容进行修改、编辑或整理等。您的网站、应用等任何产品、服务及相关内容等，由您自行开发、运营且自行承担全部责任。因您的网站、应用等任何产品、服务及相关内容等产生的任何纠纷、责任等，或因您违反相关法律法规或本协议约定引发的任何后果，均由<span class="GramE">您独立</span>承担责任、赔偿损失，与<span class="GramE">乐视云无关</span>。如侵害到<span class="GramE">乐视云或</span>他人权益的，您须自行承担全部责任和赔偿一切损失。</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">2.2 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">乐<span class="GramE">视云服务</span>使用者</span></b><span lang="EN-US" style="font-size:10.5pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">乐<span class="GramE">视云服务</span>使用者：指使用乐<span class="GramE">视云服务</span>的个人、法人或其他组织，在本协议中简称为“您”或“用户”。<span lang="EN-US">&nbsp;<o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:17.0pt;margin-right:0cm;margin-bottom:16.0pt;margin-left:
0cm"><b><span lang="EN-US" style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">3. </span></b><b><span style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">您的权利和义务</span></b><span lang="EN-US" style="font-size:15.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.1 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">账号注册</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.1.1&nbsp;</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">您应当通过乐<span class="GramE">视云官网或乐视云其他</span>指定途径，使用邮箱或其他<span class="GramE">乐视云认可</span>的方式（如手机等），注册本服务<span class="GramE">帐号</span>并成为乐<span class="GramE">视云服务</span>使用者。<span lang="EN-US">&nbsp;</span></span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.1.2</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;</span><span class="GramE"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">您注册本</span></span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">服务<span class="GramE">帐号</span>使用的手机号码、邮箱等是您登陆及使用<span class="GramE">本服务</span>的凭证，您应当做好其<span class="GramE">帐号</span>、密码以及进入和管理<span class="GramE">本服务</span>中的各类产品与服务的口令、密码等的保密措施。因您保密措施不当或您的行为致使上述口令、密码等丢失或泄漏所引起的一切损失和后果均由您自行承担。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.1.3&nbsp;</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">如您使用邮箱注册本服务<span class="GramE">帐号</span>，您应使用拥有合法使用权的邮箱，<b>本服务<span class="GramE">帐号</span>一经注册成功，相应的邮箱无法变更，您须谨慎操作。</b><span lang="EN-US">&nbsp;</span></span><span lang="EN-US" style="font-size:9.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.1.4</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">您可以根据自己的需求，依照<span class="GramE">本服务</span>规则添加、<span class="GramE">删除您本服务帐号</span>的子账号。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.1.5</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">您保证注册本服务<span class="GramE">帐号</span>以及您添加的本服务<span class="GramE">帐号</span>的子账号使用的邮箱等相关<span class="GramE">帐号</span>均是合法的。前述全部邮箱等在<span class="GramE">本服务</span>中进行的包括但不限于注册本服务<span class="GramE">帐号</span>、提交相应资质材料、确认和同意相关协议和规则、选择具体服务类别以及进行费用结算等事项，均视为您自行或您授权他人进行的行为，对您均有约束力。同时，<span class="GramE">您承担</span>以前述全部邮箱等为标识进行的全部行为的法律责任。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.1.6&nbsp;</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">本服务<span class="GramE">帐号</span>仅供您自己使用，您不得以任何形式将其转让给他人。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.1.7</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">若您发现有他人冒用或盗用您的账户及密码、或任何其他未经您合法授权的情形时，应立即以有效方式通知乐视云（包括但不限于提供您的身份信息和相关身份资料、相关事实情况及您的要求等）。乐<span class="GramE">视云收到</span>您的有效请求并核实身份后，会根据不同情况采取相应措施。若您提供的信息不完全，导致乐<span class="GramE">视云无法</span>核实您的身份<span class="GramE">或乐视云无法判断您</span>的需求等，而导致乐<span class="GramE">视云无法</span>进行及时处理，给您带来的损失，您应自行承担。同时，您理解<span class="GramE">乐视云对</span>您的请求采取措施需要合理期限，对于您通知<span class="GramE">乐视云以及乐视云根据</span>您的有效通知采取措施之前，由于他人行为给您造成的损失，<span class="GramE">乐视云不</span>承担任何责任。<span lang="EN-US">&nbsp;</span></span><span lang="EN-US" style="font-size:9.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.2 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">资质材料</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.2.1&nbsp;</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">您保证具备使用本服务、运营产品或提供服务等的相关合法资质或经过了相关政府部门的审核批准，您的行为不违反任何相关法律法规及协议、规则，也不会侵犯任何人的合法权益。<span lang="EN-US">&nbsp;</span></span><span lang="EN-US" style="font-size:9.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.2.2</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">您应<span class="GramE">按照乐视云</span>要求提交相关主体资质材料，包括但不限于身份证明文件、资质证明文件、联系人姓名（名称）、联系地址、电子邮箱等相关资料。您保证提供的资料真实、合法、准确、完整，并在相关信息发生变更后，及时进行更新。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.2.3&nbsp;</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">您若使用<span class="GramE">本服务</span>进行网站运营、应用运营等任何经营性或非经营性活动，应根据提供产品及服务的不同种类，提供以下可能的相应文件（具体内容可能依照相关法律规定的变更而调整）：</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">（<span lang="EN-US">1</span>）若您提供经营性互联网信息服务的，应提供互联网信息服务增值电信业务经营许可证；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">（<span lang="EN-US">2</span>）若您提供非经营性互联网信息服务的，应提供从事非经营性互联网信息服务的备案手续的证明文件；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">（<span lang="EN-US">3</span>）若您提供电子公告服务的，应提供在申请互联网信息服务增值电信业务经营许可证或者办理非经营性互联网信息服务备案时，已经取得专项批准或者专项备案的证明文件；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">（<span lang="EN-US">4</span>）若<span class="GramE">您经营</span>互联网游戏服务的，应提供网络文化经营许可证等；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">（<span lang="EN-US">5</span>）若您从事其他应当依法进行审批、备案等行为的，应提供相应证明文件。<span lang="EN-US">&nbsp;<o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.2.4&nbsp;</span></b><span class="GramE"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">您承诺</span></span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">具备履行本协议的能力<span lang="EN-US">,</span>且本协议的签订、履行等行为不违反任何对您有约束力的法律文件。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.3 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">服务费用</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.3.1&nbsp;</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">您应根据自身需求，选择<span class="GramE">本服务</span>中的具体项目、使用期限等，您的选择一经做出，即对您有约束力。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.3.2&nbsp;</span></b><span class="GramE"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">本服务</span></span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">中可能包括收费服务、免费服务，具体以乐<span class="GramE">视云对外</span>公布的信息为准。若您使用<span class="GramE">本服务</span>中的收费服务，应按照<span class="GramE">本服务</span>官方网站公布的计费标准和方式支付相关费用。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.3.3</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;
</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">免费服务的使用可能需要满足一定的条件，具体条件以<span class="GramE">本服务</span>官方网站公布的条件为准。对于免费服务，<span class="GramE">乐视云有权</span>根据实际情况，对免费服务的领取时间、具体服务内容、服务期限及服务标准等进行单方变更，对此您无异议，并接受前述的变更，为此，<span class="GramE">乐视云无需</span>向<span class="GramE">您承担</span>任何责任。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.3.4&nbsp;</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">乐<span class="GramE">视云可能</span>根据实际需要对收费服务的收费标准、方式等进行修改和变更，<span class="GramE">乐视云也</span>可能会对部分免费服务开始收费。前述修改、变更或开始收费前，<span class="GramE">乐视云将</span>在相应服务页面进行通知或公告。</span><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.3.5</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;
</span><span class="GramE"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">本服务</span></span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">的充值、冻结、结算、发票开具等规则，参照<span class="GramE">本服务</span>官方网站（<span lang="EN-US">www.letvcloud.com</span>）公布的相关内容（为保障您的权益请务必提前了解相关内容）。<span lang="EN-US">&nbsp;</span></span><span lang="EN-US" style="font-size:9.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.4 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">服务使用规则</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.4.1</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;</span><span class="GramE"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">本服务</span></span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">中可能会使用第三方软件或技术，若有使用，乐<span class="GramE">视云保证</span>已经获得合法授权。同时，<span class="GramE">乐视云将</span>按照相关法规或约定，对相关的协议或其他文件，进行展示。前述通过各种形式展现的相关协议或其他文件，均是本协议不可分割的组成部分，与本协议具有同等的法律效力，您应当遵守这些要求。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.4.2
</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">您购买<span class="GramE">本服务</span>后，仅可供自己使用，不得直接或<span class="GramE">间接以</span>转让、出售、出租、合作等任何形式，有偿或无偿地将部分或全部的服务提供给他人使用。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.4.3</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">
</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">您应自行对因使用<span class="GramE">本服务</span>而存储<span class="GramE">在乐视云服务器</span>的各类数据等信息，在<span class="GramE">本服务</span>之外，采取合理、安全的技术措施，确保其安全性，并对自己的行为（包括但不限于自行安装软件、采取加密措施或进行其他安全措施等）所引起的结果承担全部责任。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.5 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">产品运营</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><b><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.5.1</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">用户不得利用<span class="GramE">乐视云危害</span>国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益，不得利用<span class="GramE">乐视云制作</span>、复制和传播下列信息；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">a. </span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">煽动抗拒、破坏宪法和法律、行政法规实施的；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">b. </span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">煽动颠覆国家政权，推翻社会主义制度的；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">c. </span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">煽动分裂国家、破坏国家统一的；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">d. </span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">煽动民族仇恨、民族歧视，破坏民族团结的；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">e. </span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">捏造或者歪曲事实，散布谣言，扰乱社会秩序的；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">f. </span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">g. </span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">h. </span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">损害国家机关信誉的；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><span class="SpellE"><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">i</span></span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">.
</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">其他违反宪法和法律行政法规的；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">j. </span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">进行违禁物品商业广告行为的。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><b><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.5.2</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">用户保证：<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><span style="font-size:9.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">（<span lang="EN-US">1</span>）用户承诺其所发布的所有视频信息符合国家法律法规的相关规定，不侵犯任何第三方的合法权益；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><span style="font-size:9.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">（<span lang="EN-US">2</span>）用户保证其所发布的所有视频信息的版权的完整性和合法性，为自有版权或已获得版权所有人的同意；如用户违反前述保证，<span class="GramE">乐视云有权</span>删除违反规定之视频信息，并可以暂停或终止本服务。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><span style="font-size:9.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">（<span lang="EN-US">3</span>）用户承诺自己的内容可授权<span class="GramE">乐视云视频</span>做内容输出使用（我们会提前与客户沟通达成协议），<span class="GramE">乐视云视频</span>旨在为广大用户的视频赢得多渠道的曝光。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.6 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">法律责任</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.6.1
</span></b><span class="GramE"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">您承诺</span></span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">会按照本协议及相关协议、规则等支付相关费用。否则，每延期一日，您应当向乐<span class="GramE">视云支付</span>所欠费用千分之一的滞纳金。同时，<span class="GramE">乐视云有权</span>随时单方采取包括但不限于以下措施中的一种或多种，以维护自己的合法权益：<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">（<span lang="EN-US">1</span>）<span class="GramE">乐视云从</span>应支付给您的任何费用中直接抵扣；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">（<span lang="EN-US">2</span>）<span class="GramE">乐视云暂停</span>向您结算或支付任何费用；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">（<span lang="EN-US">3</span>）中止、限制或终止您所有已申请的<span class="GramE">本服务</span>的使用；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">（<span lang="EN-US">4</span>）其他<span class="GramE">乐视云为</span>维护自己权益可以采取的措施。<span lang="EN-US">&nbsp;<o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.6.2
</span></b><span class="GramE"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">若乐视云</span></span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">自行发现或根据相关部门的信息、权利人的投诉等，发现<span class="GramE">您行为</span>违反相关法律法规或本协议的，<span class="GramE">乐视云有权</span>根据自己的独立判断并随时单方采取以下措施中的一种或多种：<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">（<span lang="EN-US">1</span>）要求您立即更换、修改内容；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">（<span lang="EN-US">2</span>）直接删除、屏蔽相关内容或断开链接等；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">（<span lang="EN-US">3</span>）限制、中止您使用本服务（包括但不限于直接对您的部分服务进行下线并收回相关资源、对您的云服务<span class="GramE">帐号</span>进行操作限制等）；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">（<span lang="EN-US">4</span>）终止您使用<span class="GramE">乐视云服务</span>，终止合作（包括但不限于直接对您的全部服务进行下线并收回相关资源等）；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">（<span lang="EN-US">5</span>）<span class="GramE">追究您</span>的法律责任。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3.6.3
</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">您因违反本协议约定所引起的纠纷、责任等一概由您负责，<span class="GramE">乐视云也</span>无需向您退还任何费用，而由此给您带来的损失（包括但不限于通信中断、相关数据清空、未使用服务费用作为违约金而归乐<span class="GramE">视云所有</span>等），由您自行承担，造成<span class="GramE">乐视云或</span>他人损失的，您也应予以赔偿。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:17.0pt;margin-right:0cm;margin-bottom:16.0pt;margin-left:
0cm"><b><span lang="EN-US" style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">4. </span></b><span class="GramE"><b><span style="font-size:15.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">乐视云的</span></b></span><b><span style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">权利义务</span></b><span lang="EN-US" style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">4.1&nbsp;</span></b><span class="GramE"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">乐视云会</span></span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">根据您选择的服务以及交纳费用的情况向您提供相应的服务。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">4.2&nbsp;</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">保护您的信息安全是<span class="GramE">乐视云的</span>一项基本原则，未经您的同意，乐<span class="GramE">视云不会</span>向<span class="GramE">乐视云以外</span>的任何公司、组织和个人披露、提供您的信息，但下列情形除外：</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">（<span lang="EN-US">1</span>）依据本协议或其他相关协议、规则等规定可以提供的；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">（<span lang="EN-US">2</span>）依据法律法规的规定可以提供的；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">（<span lang="EN-US">3</span>）行政、司法等政府部门要求提供的；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">（<span lang="EN-US">4</span>）您同意<span class="GramE">乐视云向</span>第三方提供；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">（<span lang="EN-US">5</span>）为解决举报事件、提起诉讼而需要提供的；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">（<span lang="EN-US">6</span>）为防止严重违法行为或涉嫌犯罪行为发生而采取必要、合理行动所必须提供的。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">4.3</span></b><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">尽<span class="GramE">管乐视云对</span>您的信息保护做了极大的努力，但是仍然不能保证在现有的安全技术措施下，您的信息绝对安全。您的信息可能会因为不可抗力或非乐<span class="GramE">视云因素</span>造成泄漏、被窃取等，由此给您造成损失的，您同意<span class="GramE">乐视云可以</span>免责。<span lang="EN-US">&nbsp;</span></span><span lang="EN-US" style="font-size:9.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:17.0pt;margin-right:0cm;margin-bottom:16.0pt;margin-left:
0cm"><b><span lang="EN-US" style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">5.</span></b><b><span style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">服务保证</span></b><span lang="EN-US" style="font-size:15.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.1</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">定义解释 <span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.1.1</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">服务可用性：指用户使用乐视云云视频服务的流媒体内容是否可以被正常播放；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.1.2</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">服务<span class="GramE">不</span>可用：指用户使用乐视云云视频服务的流媒体内容不可以被正常播放；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.1.3</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">损坏的视频文件：文件损坏的视频文件，即至少得常用播放器能正常播放的；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.1.4</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">可用的视频文件：指云视频服务可支持的视频文件格式范围内的文件<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.1.5</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">服务中断：是指用户使用的云视频服务过程中，出现服务<span lang="EN-US">10</span>分钟以上没有响应，或播放文件内容与用户提供的文件不符合；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.1.6</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">服务故障：是<span class="GramE">指造成</span>部分地区的用户无法正常播放用户使用乐<span class="GramE">视云服务</span>过程中，出现无法正常播放视频内容达<span lang="EN-US">20</span>分钟以上的情况；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.1.7</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">基础电信运营商：是<span class="GramE">指经工信</span>部批准获得《基础电信业务经营许可证》的互联网网络经营单位；主要包括中国电信、中国联通、中国移动；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.2</span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">服务开通保证 </span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><span style="font-size:9.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">开通时间保证： 在本协议生效后，并在用户完成相应技术对接后，<span class="GramE">乐视云在</span><span lang="EN-US"> 3 </span><span class="GramE">个</span>工作日内完成所有服务的初始设置，并以开通确认<span class="GramE">书方式</span>通知用户，用户在<span lang="EN-US">1</span>个工作日内确认无误后，即告服务开通；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.3</span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">服务可用性保证 </span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.3.1</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">乐<span class="GramE">视云保证</span>所提供的内容与用户原服务内容相符，由于乐<span class="GramE">视云原因</span>导致乐<span class="GramE">视云服务</span>内容被更换为非用户许可的内容，被视为服务<span class="GramE">不</span>可用。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.3.2</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">乐<span class="GramE">视云仅</span>提供相关的网络服务，除此之外与相关网络服务有关的设备（如个人电脑、手机、及其他与接入互联网或移动网有关的装置）及所需的费用（如为接入互联网而支付的电话费及上网费、为使用移动网而支付的手机费）均应由用户自行负担。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.3.3</span></b><span class="GramE"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">乐视云根据</span></span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">用户要求，为用户计算每月服务不可用时间，服务不可用时间包括由于<span class="GramE">乐视云设备故障</span>或设计缺陷造成的用户所购买服务的流媒体视频文件不能被正常播放的时间，但不包括服务<span class="GramE">不</span>可用的<span lang="EN-US">24</span>小时之内用户未向乐<span class="GramE">视云报告</span>的情况，以及由于以下原因所导致的服务<span class="GramE">不</span>可用： <span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">a.</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">由于用户或使用该服务的相关用户合作伙伴未仔细阅读云视频服务<span lang="EN-US">API</span>接口文档，错误调用接口导致的服务<span class="GramE">不</span>可用的，<span class="GramE">乐视云不</span>承担责任。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">b. </span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">用户或使用该服务的用户合作伙伴未事先通知乐视云而修改相关接口及配置导致服务不可用的，乐视云不承担责任<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">c.</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">用户或使用该服务的用户合作伙伴须确保<span lang="EN-US">IP</span>地址应为公网地址，由于<span class="GramE">提供提供</span>内网<span lang="EN-US">IP</span>导致的服务<span class="GramE">不</span>可用，<span class="GramE">乐视云不</span>承担责任。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">d</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">．用户或使用该服务的用户合作伙伴须保证上传可用的视频文件，即须提前与<span class="GramE">乐视云列举</span>所需上传视频文件的视频格式，<span class="GramE">经乐视云完全</span>确认支持该格式后再进行相应格式范围的云视频服务提供，如用户上传的视频文件，已经明确在乐<span class="GramE">视云目前</span>不支持的视频格式范围内，<span class="GramE">或乐视云未</span>确定能否完全支持的视频格式的，导致服务<span class="GramE">不</span>可用的，<span class="GramE">乐视云不</span>承担责任。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">e</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">．用户或使用该服务的用户合作伙伴上传视频文件必须保证时长不低于<span lang="EN-US">2</span>秒，上传低于<span lang="EN-US">2</span>秒的文件导致服务<span class="GramE">不</span>可用的，<span class="GramE">乐视云不</span>承担责任。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">f. </span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">用户或使用该服务的用户合作伙伴上传视频文件必须保证文件为非损坏的视频文件，上传损坏的视频文件导致服务不可用的，乐视云不承担责任。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><span class="GramE"><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">g</span></span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">.
</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">任何乐视云设备以外的网络设备故障或配置调整引起的<span lang="EN-US">, </span>导致服务不可用，乐视云不承担责任。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">h.</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">不可抗力引起的<span lang="EN-US">, </span>导致服务<span class="GramE">不</span>可用，<span class="GramE">乐视云不</span>承担责任<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.3.4</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">如果由于用户网站受到黑客攻击，对<span class="GramE">乐视云的</span>服务平台带来运营风险的，用户有义务就可预见的该攻击情况及时告知乐视云。<span class="GramE">乐视云在</span>书面通知（邮件或其他方式）用户的技术负责人的前提下，可以采取将本协议约定之服务暂停，保护<span class="GramE">乐视云运营</span>平台的安全和其他客户的利益。在采取上述措施仍不能避免风险的情况下，<span class="GramE">乐视云有权</span>中止对用户提供的服务，甲乙双方届时须经过进一步协商确定协议继续履行或终止，用户就已发生业务的付款义务并未因此免除。在用户书面通知<span class="GramE">乐视云该次</span>攻击结束，并且<span class="GramE">经乐视云</span>确认属实的，<span class="GramE">乐视云将</span>服务<span class="GramE">切回到</span>正常服务状态。因用户网站受到黑客攻击而对<span class="GramE">乐视云运营</span>平台及其客户造成损失的，用户应承担赔偿责任；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.3.5</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">对于基础电信运营商的线路被人为破坏或运营<span class="GramE">商设备</span>因调试、扩容所引起的网络中断，服务故障的时间不计入累计时间；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.4</span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">统计数据服务</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.4.1</span></b><span class="GramE"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">乐视云在</span></span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">用户使用服务后，用户可以通过专用的<span class="GramE">帐号在乐视云的</span>网站上提取相应的统计数据。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.4.2</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">乐<span class="GramE">视云保证</span>在协议签订后<span lang="EN-US">2-3</span>个工作日内为用户开通相应的<span class="GramE">帐号</span>。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.5</span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">客户服务中心保证 </span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.5.1</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">乐<span class="GramE">视云客户</span>服务支持中心向用户提供如下服务：<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">1)<span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span></span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">云视频服务对接工作受理及进展；
<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">2)<span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span></span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">技术咨询；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">3)<span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span></span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">服务变更受理及进展；<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">4)<span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span></span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">故障排查：收到用户发生故障的通知，<span class="GramE">乐视云协助</span>用户积极排查，由用户原因产生的故障，乐<span class="GramE">视云分析</span>整理后及时发送给用户；由乐<span class="GramE">视云原因</span>产生的故障，<span class="GramE">乐视云在</span>排查原因后积极处理问题解决，及时保障用户后续服务正常。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.5.2</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">乐<span class="GramE">视云提供</span><span lang="EN-US">7</span>天<span lang="EN-US"> X 24</span>小时的故障排查服务，在收到用户服务中断或服务故障信息反馈后立即受理。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.5.3</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">乐<span class="GramE">视云客户</span>服务支持中心设立<span lang="EN-US">7</span>天<span lang="EN-US"> X 24</span>小时的客户服务，报障邮箱为<span lang="EN-US">yunhelp@letv.com<span style="mso-spacerun:yes">&nbsp; </span></span>，处理各类服务建议或投诉。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">5.5.4</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">为保证客户的安全，用户在使用客户服务中心时必须通过密码认证。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:17.0pt;margin-right:0cm;margin-bottom:16.0pt;margin-left:
0cm"><b><span lang="EN-US" style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">6</span></b><b><span style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">．服务计量准确性</span></b><span lang="EN-US" style="font-size:15.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">乐<span class="GramE">视云服务</span>的费用在用户的选购页面和订单页面均有明确展示，用户可自行选择具体服务类型并按列明的价格进行购买。具体价格以乐<span class="GramE">视云官网</span>公布的价格为准，<span class="GramE">乐视云按照</span>用户选购的<span class="GramE">云服务</span>规格和使用时长进行收费，同时也有按带宽结算的方式收费。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:17.0pt;margin-right:0cm;margin-bottom:16.0pt;margin-left:
0cm"><b><span lang="EN-US" style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">7</span></b><b><span style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">．补偿</span></b><span lang="EN-US" style="font-size:15.0pt;font-family:
&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">7.1 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">适用范围</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">适用于由<span class="GramE">乐视云故障</span>原因导致用户在全网不可访问，以及<span class="GramE">乐视云故障</span>导致的网站（开发者服务网站）无法访问长达<span lang="EN-US">6</span>小时以上时，用户要求<span class="GramE">乐视云针对</span>事故<span lang="EN-US">/</span>故障而进行的补偿。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">7.2 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">补偿标准原则</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">故障时间<span lang="EN-US">=</span>故障解决时间<span lang="EN-US">-</span>故障开始时间。按分钟计算故障时间，故障时间小于<span lang="EN-US">1</span>分钟的按<span lang="EN-US">1</span>分钟计算。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">例如，故障时间为<span lang="EN-US">1</span>分<span lang="EN-US">01</span>秒，按<span lang="EN-US">2</span>分钟算。补偿采用延长时间的方式，延长时间与故障时间的比例为<span lang="EN-US">1:1</span>。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:17.0pt;margin-right:0cm;margin-bottom:16.0pt;margin-left:
0cm"><b><span lang="EN-US" style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">8. </span></b><b><span style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">关于免责</span></b><span lang="EN-US" style="font-size:15.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">8.1</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">因电信部门和广电部门例行检修和系统升级等原因造成的服务中断，属正常现象，双方互不承担责任，知情方应尽到及时通知的义务。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">8.2</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">因国家政策法规调整、自然灾害等不可抗力造成服务中断，双方互不承担责任，但<span class="GramE">乐视云有</span>义务在最短的时间内解决所出现的技术问题。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">8.3</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">由于用户原因造成乐<span class="GramE">视云未能</span>准时提供服务，<span class="GramE">乐视云不</span>承担责任。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">8.4</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">由于一方原因，给对方带来损害的，对方保留追究此方相应责任的权利。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:15.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:
0cm;margin-bottom:.0001pt;line-height:27.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">8.5</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">用户承诺严格遵守《全国人民代表大会常务委员会关于维护互联网安全的决定》、《中华人民共和国电信条例》、《电信业务经营许可证管理办法》、《非经营性互联网信息服务备案管理办法》、《互联网信息服务管理办法》、《计算机信息网络国际联网安全保护管理办法》、《互联网电子公告服务管理规定》等有关法规和行政规章制度以及将来颁布并将对其适用的法律法规和规章制度，不得利用乐<span class="GramE">视云提供</span>的服务从事任何违反法律法规、危害国家安全、泄漏国家秘密、违法犯罪、妨碍社会治安的活动，或者在乐<span class="GramE">视云提供</span>的虚拟空间内存放任何违反法律法规、危害国家安全、泄漏国家秘密、违法犯罪、妨碍社会治安的内容。用户承诺严格遵守国家法律法规及中华人民共和国工业和信息化部及其他内容监管相关部门的相关规定的要求，对其所从事的业务获得许可和<span lang="EN-US">/</span>或进行相关备案，向乐<span class="GramE">视云提供</span>真实有效的《电信与信息服务业务经营许可证》复印件（应加盖用户公章）并如实提供其网站备案相关信息，许可证复印件及网站备案信息等应作为本协议附件三附于本协议。用户保证签署《信息安全保障责任书》（附件四）并严格遵守相关规定，承担违反相关规定的全部责任和损失，若因违反相关规定而给乐<span class="GramE">视云造成</span>损失或责任，应由用户负责赔偿。</span><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:17.0pt;margin-right:0cm;margin-bottom:16.0pt;margin-left:
0cm"><b><span lang="EN-US" style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">9. </span></b><b><span style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">服务的中止或终止</span></b><span lang="EN-US" style="font-size:15.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">9.1</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">如您书面通知<span class="GramE">乐视云不</span>接受<span class="GramE">经乐视云修改</span>的新的服务协议的，<span class="GramE">乐视云有权</span>随时暂停或终止向您提供本服务。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">9.2&nbsp;</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">因不可抗力因素导致您无法继续使用<span class="GramE">本服务或乐视云无法提供本服务</span>的，任何一方均有权随时终止协议。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">9.3</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">本协议约定的其他暂停或终止条件发生或实现的，<span class="GramE">乐视云有权</span>随时暂停或终止向您提供本服务。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">9.4</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">由于您违反本协议约定，<span class="GramE">乐视云依约</span>终止向您提供<span class="GramE">本服务</span>后，如您后续再直接或间接，或以他人名义注册使用<span class="GramE">本服务</span>的，<span class="GramE">乐视云有权</span>直接单方面暂停或终止提供本服务。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">9.5</span></b><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">
</span></b><b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">如本协议或<span class="GramE">本服务</span>因为任何原因终止的，<span class="GramE">对于您云服务帐号</span>中的全部数据或您因使用乐<span class="GramE">视云服务</span>而存储<span class="GramE">在乐视云服务器</span>中的数据等任何信息，<span class="GramE">乐视云将</span>为您保留<span lang="EN-US">15</span>天。您应承担保留期限内产生的云服务费用，并在保留期限届满前结清费用、完成全部数据的迁移和备份。保留期限届满后，<span class="GramE">乐视云将</span>终止服务，服务系统将自动<span class="GramE">删除您</span>的所有数据。</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">9.6
</span></b><b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:#333333">如本协议或<span class="GramE">本服务</span>因为任何原因终止的（包括但不限于您欠费），您应自行处理<span class="GramE">好关于</span>数据等信息的备份、费用结算以及与您的客户之间的关系等相关事项。</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:17.0pt;margin-right:0cm;margin-bottom:16.0pt;margin-left:
0cm"><b><span lang="EN-US" style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">10. </span></b><b><span style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">关于通知</span></b><span lang="EN-US" style="font-size:15.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">10.1</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">乐<span class="GramE">视云可能</span>会以网页公告、网页提示、电子邮箱、手机短信、常规的信件传送、<span class="GramE">您注册的本服务</span>账户的管理系统内<span class="GramE">发送站内信等</span>方式中的一种或多种，向您送达关于<span class="GramE">本服务</span>的各种规则、通知、提示等信息，这些信息一经乐<span class="GramE">视云公布</span>或发送，即视为送达，对您产生约束力。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">&nbsp;<o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">10.2</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">由于您未及时查看相关信息内容，或您提供的电子邮箱、手机号码、通讯地址等信息错误，<span class="GramE">导致您未收到</span>相关规则、通知、提示等信息的，一切后果及责任由您自行承担。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">&nbsp;<o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">10.3</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">您同意乐<span class="GramE">视云或乐视云</span>的合作伙伴可以向您的电子邮件、手机号码等发送可能与<span class="GramE">本服务</span>不相关的其他各类信息，包括但不限于商业广告等。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">&nbsp;<o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">10.4</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;</span><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">若您有事项需要通知<span class="GramE">乐视云的</span>，应当通过乐<span class="GramE">视云对外</span>正式公布的通信地址、电子邮箱等途径书面通知乐视云。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:17.0pt;margin-right:0cm;margin-bottom:16.0pt;margin-left:
0cm"><b><span lang="EN-US" style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">11. </span></b><b><span style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">知识产权</span></b><span lang="EN-US" style="font-size:15.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><span style="font-size:9.0pt;
font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">由用户及其用户发布的视频内容的知识产权属于用户所有或用户已取得第三方的合法授权，在合作期间内，<span class="GramE">乐视云可以</span>在双方约定的范围内使用，合作期满，未经用户或原权利人书面授权，乐<span class="GramE">视云不得</span>继续使用；由乐<span class="GramE">视云提供</span>的所有技术方面的知识产权<span class="GramE">为乐视云所有</span>，在合作期限内，<span class="GramE">乐视云授权</span>或提供用户使用；合作期满，未经<span class="GramE">乐视云另行</span>书面授权，用户不得继续使用。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin-top:17.0pt;margin-right:0cm;margin-bottom:16.0pt;margin-left:
0cm"><b><span lang="EN-US" style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">12. </span></b><b><span style="font-size:15.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black">其他</span></b><span lang="EN-US" style="font-size:15.0pt;font-family:
&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">12.1 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">协议的生效与变更</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">您使用<span class="GramE">本服务</span>即视为您已阅读并同意受本协议的约束。<span class="GramE">乐视云有权</span>在必要时修改本协议条款。您可以在相关页面中查阅最新的协议条款。本协议条款变更后，如果您继续使用本服务，即视为您已接受修改后的协议。如果您不接受修改后的协议，应当停止使用本服务。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">12.2 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">协议签订地</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">本协议签订地为北京市朝阳区。<span lang="EN-US">&nbsp;<o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">12.3 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">适用法律</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">本协议的成立、生效、履行、解释及纠纷解决，适用中华人民共和国大陆地区法律。</span></b><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">&nbsp;<o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">12.4 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">争议解决</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><b><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">12.4.1</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">本协议及其修订本的有效性、履行和与本协议及其修订本效力有关的所有事宜，将受中华人民共和国法律管辖，任何争议仅适用中华人民共和国法律。
</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;
color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><b><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">12.4.2</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">用户与乐<span class="GramE">视云双方</span>因协议的解释或履行发生争议时，首先应争取通过友好协商解决，该协商应在三十天内解决。 </span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><b><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">12.4.3</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">如协商不能解决时，协议的任何一方可将争议提交北京市朝阳区人民法院。</span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin-top:7.0pt;margin-right:0cm;margin-bottom:0cm;margin-left:0cm;
margin-bottom:.0001pt;line-height:22.0pt"><b><span lang="EN-US" style="font-size:
9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">12.4.4</span></b><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">争议进行裁决期间，除争议事项外，用户<span class="GramE">及乐视云双方</span>应继续履行各自本协议中规定的义务和行使权利。 </span><span lang="EN-US" style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">12.5 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">条款标题</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">本协议所有条款的标题仅为阅读方便，本身并无实际涵义，不能作为本协议涵义解释的依据。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt"><b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">12.6 </span></b><b><span style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black">条款效力</span></b><span lang="EN-US" style="font-size:10.5pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">本协议条款无论因何种原因部分无效或不可执行，其余条款仍有效，对双方具有约束力。<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p style="margin:0cm;margin-bottom:.0001pt;line-height:18.0pt"><span style="font-size:9.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;color:#333333">（完）<span lang="EN-US"><o:p></o:p></span></span></p>
                        <p></p>
                        <p></p><p class="MsoNormal"><span lang="EN-US" style="font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
                        <p></p>
                        <p></p><p class="MsoNormal"><span lang="EN-US" style="font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
                        <p></p>
                        <p></p></div>
                    </div>
                </div>
                <div class="row" style="padding-bottom: 4px;">
                    <button type="button" class="btn btn-primary" onclick="editUserStatus()" data-dismiss="modal" style="padding: 6px 40px;margin-left: 240px;">同意</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 同意协议弹层/E -->

<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<jsp:include page="rechargeFrame.jsp"></jsp:include>
<script type="text/javascript" src="${ctx}/assets/js/main/usercenterApp.js?t=20150421"></script>
 <script type="text/javascript">
     document.domain = "letvcloud.com";
  $ = jQuery = require("lib/jquery.min");//jquery
  require("lib/bootstrap.min");//modal
</script>

<%--<script type="text/javascript" src="${ctx}/assets/js/main/common.js"></script>--%>
</body>

<script type="text/javascript">
    function rechargeBackFunction(data){
        $("#user-account").text(data);
    }
    $(function(){
        //校验判断当前用户是否老用户
        <c:if test="${login}">
        $("#close").click(function(){
            window.location.href="${ctx}/logout.do";
        });
        </c:if>

        $.ajax({
            type: "GET",
            url: "${ctx}/user/searchCurrentUser.do?t="+new Date().toTimeString(),
            dataType: "JSON",
            success: function (data) {
                $("#email").val(data.email);
                if(data.isOld!="1"){
                    $('#deleteModal02').modal('show');
                }
                if(data.userType == 2) {
                    $("#userType").html("个人会员");
                    $("#contacts").text(data.contacts);
                }else{
                    $("#userType").html("企业客户");
                }
                $("#userTypeHide").val(data.userType);
                $("#contactsInput").val(data.contacts);
                if(data.userType!=1&&data.userType!=2){
                    if((data.enterpriseName!=null)){
                        $("#contacts").text(data.enterpriseName);
                    }
                }
                if (data.userAvatar != null&&data.userAvatar!="") {
                    $("#showImgFace").prop("src", data.userAvatar);
                }

            }
        });


    	   $.ajax({
               type: "GET",
               url: "${ctx}/user/getUserInfoAuthenStatus.do?t="+new Date().toTimeString(),
               dataType: "JSON",
               success: function (data) {
	           	   if(data.state==true){
                       if(data.authenState==undefined){
                           $(".icon-user-idcard").parent().attr("href","${ctx}/qualificationsAuthenView/fillMsgView.do");
                       }else if(data.authenState==1){
		           			$(".icon-user-idcard").addClass("had");
		           			$(".icon-user-idcard").parent().attr("data-original-title","资质已认证");
                            $(".icon-user-idcard").parent().attr("href","${ctx}/qualificationsAuthenView/authenSuccess.do");
	           		   }else if(data.authenState==0){
                           $(".icon-user-idcard").parent().attr("href","${ctx}/qualificationsAuthenView/fillMsgView.do");
                       }else if(data.authenState==2){
                           $(".icon-user-idcard").parent().attr("href","${ctx}/qualificationsAuthenView/executeAuthenView.do");
                       }


	           		   if(data.mobileState==true){
		           			$(".icon-user-phone").addClass("had");
                            $(".icon-user-phone").parent().attr("data-original-title","手机已认证");
                            var alertMobile = "当前认证手机号:"+ data.mobile;
                           $("#preModifyCurrentMobile").text(alertMobile);
                            $(".icon-user-phone").parent().attr("href","javascript:showDialogDiv('手机已认证','"+alertMobile+"')");
	           		   }else{
                           $("#preModifyCurrentMobile").text("");
                           $(".icon-user-phone").parent().attr("href","javascript:showMobileChangeDiv('绑定手机')");
                       }

	           		   if(data.emailState==true){
		           			$(".icon-user-email").addClass("had");
		           			$(".icon-user-email").parent().attr("data-original-title","邮箱已验证");
                           $(".icon-user-email").parent().attr("href","javascript:showDialogDiv('邮箱已验证','邮箱已验证')");
	           		   }else{
                           $(".icon-user-email").parent().attr("href","javascript:activeEmail()");
                       }


               		}
             	}
           });


       $.ajax({
            type: "GET",
            url: "${ctx}/message/getCountUnReadMsg.do?t="+new Date().toTimeString(),
            dataType: "text",
            success: function (data) {
            	if(data=="0"){
            		$("#msgShow").text("消息中心");
            		$("#unReadMsgCount").removeClass();
            	}else{
            		$("#msgShow").text("未读消息");
            		$("#unReadMsgCount").addClass("icon-msg-num animated bounce");
           		  	$("#unReadMsgCount").text(data);
            	}
            }
        });

        $.ajax({
            type: "GET",
            url: "${ctx}/message/getCountUnReadMsg.do?t="+new Date().toTimeString(),
            dataType: "text",
            success: function (data) {
            	if(data=="0"){
            		$("#msgShow").text("消息中心");
            		$("#unReadMsgCount").removeClass();
            	}else{
            		$("#msgShow").text("未读消息");
            		$("#unReadMsgCount").addClass("icon-msg-num animated bounce");
           		  	$("#unReadMsgCount").text(data);
            	}
            }
        });
    });
    var addAreaNum = function (areaNum) {
        $("#tel-wraper-span").html("+" + areaNum);
        $("#areaInput").val(areaNum);
        var yzm_phone_val = $("mobileInput").val();
        var regPhone=/^13[0-9]{9}$|14[0-9]{9}$|15[0-9]{9}$|17[0-9]{9}$|18[0-9]{9}$/,regWgPhone=/^\d+$/;
        if((!regPhone.test(yzm_phone_val) && areaNum=="86")||(!regWgPhone.test(yzm_phone_val) && areaNum!="86")){
            $("#mobileMsg").addClass("Validform_wrong");
            $("#mobileMsg").html("请输入正确的手机号码");
            $("#sendMsg2MobileBtn").addClass("disabled");
            isMobileFlag = false;
            return false;
        }
    }
    /*
     * 用户的余额 /user/searchCurrentUserAmount
     */
    $(function () {
        var useraccount = $("#user-account");
        $.ajax({
            type: "GET",
            url: "/user/userBalance.do",
            dataType: "JSON",
            success: function (data) {
                useraccount.html(data.userAmount + "元");
            }
        });

    });
    //修改老用户为新用户
    function editUserStatus(){
        var parameter ={};
        parameter["isOld"]="1";
        $.ajax({
            type: "POST",
            url: "${ctx}/user/modifyOld.do",
            dataType: "JSON",
            data: parameter,
            success: function () {
            }
        });
    }
    function showMobileChangeDiv(title){
        $("#editMobileTitle").text(title);
    	$('#editPhoneModal').modal('show');
    }
    function showDialogDiv(title,comment){
        $("#showTitle").text(title);
        $("#dialogInfo").text(comment);
    	$("#showDialogDiv").modal('show');
    }
    function hideshowDialogDiv(t){
        $("#confirmButton").attr("href","javascript:hideshowDialogDiv()");
        $("#showDialogDiv").modal('hide');
        if(t!=undefined){
            if(t =="letv.com"){
                t = "http://email."+t;
            }else{
                t = "http://mail."+t;
            }
            window.open(t);
        }
    }

    function activeEmail(){
        $.ajax({
            type: "GET",
            url: "${ctx}/email/sendActivateEmail.do",
            dataType: "text",
            success: function (data) {
                if(data == "Y"){
                    var email = $("#email").val();
                    showDialogDiv("验证邮件已发送","验证邮件已发送至邮箱"+email);
                    var emailDomain =email.substring(email.indexOf("@")+1);
                    $("#confirmButton").attr("href","javascript:hideshowDialogDiv('"+emailDomain+"')");
                }
            }

        });
    }

    var checkMobileCode = function (mobileCode) {
        var mobile = $("#areaInput").val()+$("#mobileInput").val();
        $.ajax({
            type: "GET",
            url: "${ctx}/user/checkMobileCode.do?checkCode=" + mobileCode+"&mobile="+mobile,
            dataType: "TEXT",
            success: function (data) {
                if (data != 'Y') {
                    $("#mobileCaptchaMsg").removeClass();
                    $("#mobileCaptchaMsg").addClass("Validform_checktip Validform_wrong");
                    $("#mobileCaptchaMsg").html("验证码错误");
                    captchaFlag = false;
                } else {
                    $("#mobileCaptchaMsg").removeClass();
                    $("#mobileCaptchaMsg").addClass("Validform_checktip Validform_right");
                    $("#mobileCaptchaMsg").html("验证码正确");
                    captchaFlag = true;
                }
            }
        });
    }
    var isMobileFlag = false;

    var checkMobileCodeFlag = false;
    /*提交修改手机*/

    var submitModifyMobile = function () {
        $("#mobileInput").trigger("blur");
        $("#uphoneCode").trigger("blur");
        if(!checkMobileCodeFlag){
            checkMobileCode($("#uphoneCode").val());
        }
        if($("#uphoneCode").val()==""){
            $("#mobileCaptchaMsg").addClass("Validform_wrong");
            $("#mobileCaptchaMsg").html("验证码不能为空");
        }
        if (isMobileFlag && checkMobileCodeFlag) {
            if(confirm("绑定手机号码，需重新登录，确认绑定吗?")){
                $.ajax({
                    type: "POST",
                    url: "${ctx}/user/modifyMobile.do",
                    data: $("#modifyMobileForm").serialize(),
                    success:function(data){
                        if (data != 'Y') {
                            alert("修改失败");
                        } else {
                            $("#editPhoneModal").modal("hide");
                            $("#changePhoneSuccessModal").modal("show");
                            var str = $("input[name='mobile']").val();
                            var mobile ="+"+$("#areaInput").val()+" "+str.substr(0,3)+"****"+str.substr(7,11);
                            $("#ModifiedMobile").text("当前已绑定手机"+mobile);

                            $("#mobileInput").val("");
                            $("#mobileMsg").text("");
                            $("#mobileMsg").removeClass("Validform_wrong");
                            $("#mobileMsg").removeClass("Validform_right");
                            $("#uphoneCode").val("");
                            $("#mobileCaptchaMsg").text("");
                            $("#mobileCaptchaMsg").removeClass("Validform_wrong");
                            $("#mobileCaptchaMsg").removeClass("Validform_right");
                            $("#sendMsg2MobileBtn").addClass("disabled");
                        }

                    }
                });
            }else{
                $("#editPhoneModal").modal("hide");
            }
        }
    }
    var isMobile = function (mobile) {
        var areaInput = $("#areaInput").val()
        $.ajax({
            type: "GET",
            url: "${ctx}/user/isMobileNum.do?mobileNum=" + mobile+"&countryCode="+areaInput,
            dataType: "TEXT",
            success: function (data) {
                if (data != 'Y') {
                    $("#mobileMsg").addClass("Validform_wrong");
                    $("#mobileMsg").html("请输入正确的手机号码");
                    $("#sendMsg2MobileBtn").addClass("disabled");
                    isMobileFlag = false;
                } else {
                    $.ajax({
                        type: "GET",
                        url: "${ctx}/user/mobileIsExist.do?mobile=" + mobile+"&countryCode="+areaInput,
                        dataType: "TEXT",
                        success: function (data) {
                            if(data=="N"){
                                $("#mobileMsg").removeClass("Validform_wrong");
                                $("#mobileMsg").addClass("Validform_right");
                                $("#mobileMsg").html("通过信息验证！");
                                $("#sendMsg2MobileBtn").removeClass("disabled");
                                isMobileFlag = true;
                            }else{
                                $("#mobileMsg").addClass("Validform_wrong");
                                $("#mobileMsg").html("该手机号已使用");
                                $("#sendMsg2MobileBtn").addClass("disabled");
                                isMobileFlag = false;
                            }

                        }
                    });
                }
            }
        });
    }
    /*校验手机验证码*/
    var checkMobileCode = function (mobileCode) {
        if(mobileCode!=""){
            var mobile = $("#areaInput").val() + $("input[name='mobile']").val();
            $.ajax({
                type: "GET",
                url: "${ctx}/user/checkMobileCode.do?checkCode=" + mobileCode+"&mobile="+mobile,
                dataType: "TEXT",
                success: function (data) {
                    if (data != 'Y') {
                        $("#mobileCaptchaMsg").addClass("Validform_wrong");
                        $("#mobileCaptchaMsg").html("验证码错误");
                        checkMobileCodeFlag = false;
                    } else {
                        $("#mobileCaptchaMsg").removeClass("Validform_wrong");
                        $("#mobileCaptchaMsg").addClass("Validform_right");
                        $("#mobileCaptchaMsg").html("通过信息验证！");
                        checkMobileCodeFlag = true;
                    }
                }
            });
        }
    }

    var sendMsg2Mobile = function () {
        $("#mobileInput").trigger("blur");
        if(isMobileFlag==true){
            var mobile = $("input[name='mobile']").val();
            $.ajax({
                type: "GET",
                url: "${ctx}/user/sendReplaceMobileMsg.do?mobileAll=" + $("#areaInput").val() + mobile+"&mobile="+mobile,
                dataType: "json",
                success: function (data) {
                    if(data=="1"){
                        $("#mobileMsg").addClass("Validform_wrong").text("该手机号已使用");
                    }else if(data=="2"){
                        $("#mobileCaptchaMsg").addClass("Validform_wrong").text("验证码发送超过次数限制");
                    }else if(data=="ok"){
                        $("#mobileCaptchaMsg").removeClass("Validform_wrong").addClass("Validform_right").text("通过信息验证");
                    }

                }
            });
        }

    }

    $("#editPhoneModal").bind("click",function(e){
        e=e||event;
        if($(e.target).attr("id")=="editPhoneClose"||$(e.target).attr("id")=="editPhoneModal"){
            $("#mobileInput").val("");
            $("#mobileMsg").text("");
            $("#mobileMsg").removeClass("Validform_wrong");
            $("#mobileMsg").removeClass("Validform_right");
            $("#uphoneCode").val("");
            $("#mobileCaptchaMsg").text("");
            $("#mobileCaptchaMsg").removeClass("Validform_wrong");
            $("#mobileCaptchaMsg").removeClass("Validform_right");
            $("#sendMsg2MobileBtn").addClass("disabled");
        }


    })

</script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?7185e15eed723b0f77e96a1c31276ef7";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
</html>
<!-- file tree:
|...usercenter.html
| |...header-usercenter.html
| |...usercenter-header.html
| |...footer.html
- By MOKTEXT. -->
