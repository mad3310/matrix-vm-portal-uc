<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>

<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/statusCueApp.css"/>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/usercenterApp.css"/>
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/statusCueApp.js?t=20150623"></script>
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/tx.js"></script>

<style>
    .grey_color {
        background-color: #aeaeae !important;
    }
    .selectWidth {
         width : 102px !important;
    }
    .selfPadding {
        padding: 5px 42px 10px !important;
    }
    .fapiao-tankuang-info .fapiao-ensure-group{
        padding :12px 0px !important;
    }
    .redColor{
        color:#fb040d;
    }

    .a_cls:hover {
        text-decoration:underline;
        cursor: pointer;
    }
    .a_cls_com {
        float: right;
        margin-top: 12px;
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
                <h3 class="title-wj">账单信息</h3>

                <div class="account-yao">
                    <table class="table table-zhang">
                        <thead>
                        <tr>
                            <th>产品名称</th>
                            <th>计费类型</th>
                            <th>账单时间</th>
                            <th>费用</th>
                            <th style="background:#1073c2;">已结算费用</th>
                            <c:if test="${billMonthBillingVo.oweMoney > 0}">
                                <th>欠费</th>
                            </c:if>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>${billUserBillingVo.serviceCodeDesc}</td>
                            <td>按流量</td>
                            <td>${billUserBillingVo.billingMonth}</td>
                            <td>${billUserBillingVo.billingMoney}</td>
                            <td style="border-left:0px">${billUserBillingVo.clearMoney}</td>
                            <c:if test="${billMonthBillingVo.oweMoney > 0}">
                                <td>
                                    <span id="user-account">${billMonthBillingVo.oweMoney}</span>
                                    <br/>
                                    <!--<a href="#" id="btnCz" class="btn btn-danger btn-lg" role="button">立即充值</a>-->
                                </td>
                            </c:if>
                        </tr>
                        </tbody>
                    </table>
                    <p class="line"></p>

                    <div class="account-mingxi clearfix">
                        <h3 class="title-wj">账单详情</h3>
                        <table class="table">
                            <thead>
                            <tr>
                                <th>名称</th>
                                <th>使用量</th>
                                <th>单价</th>
                                <th>总计</th>
                            </tr>
                            </thead>
                            <tbody>

                            <c:forEach var="billMonthDetailBillingVo" items="${billMonthDetailBillingVos}">
                                <tr>
                                    <td>${billMonthDetailBillingVo.featherCodeDesc}</td>
                                    <td>${billMonthDetailBillingVo.totalAmount}</td>
                                    <td>${billMonthDetailBillingVo.discountPrice}</td>
                                    <td>${billMonthDetailBillingVo.totalFee}</td>
                                </tr>
                            </c:forEach>

                            </tbody>
                        </table>
                        <div class="pull-right table-btn-wraper" style="width:200px;">
                            <a href="javascript:;" class="btn btn-green" onclick="exportExcel('${billUserBillingVo.orderId}', '${billUserBillingVo.billingId}', '${billUserBillingVo.billingMonth}', '${billUserBillingVo.serviceCode}')">导出明细</a>
                            <c:if test="${billUserBillingVo.invoiceState == 0 and !isRejectInvoice}">
                                <a href="javascript:;" class="btn btn-primary ml-10" onclick="getInvoiceConfirm('${billUserBillingVo.billingMoney}', '${billUserBillingVo.billingMonth}', '${billUserBillingVo.serviceCode}', '${billUserBillingVo.orderId}', '${billUserBillingVo.billingId}', '${billUserBillingVo.billingMoney}')">索取发票</a>
                            </c:if>
                            <c:if test="${billUserBillingVo.invoiceState == 1 or (billUserBillingVo.invoiceState == 0 and isRejectInvoice)}">
                                <a href="javascript:;" class="btn btn-primary grey_color" style="border-color: gray;">索要发票</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 左侧/E-->
    </div>
</section>
<!-- 中部内容/E-->


<!-- 索取发票未认证/S -->
<div class="modal fade" id="askBillUnautherizeModal" tabindex="-1" role="dialog" aria-labelledby="askBillUnautherizeModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 538px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="<editPhoneModalLabel></editPhoneModalLabel>">索取发票未认证</h4>
            </div>
            <div class="modal-body">
                <div class="row text-center fapiao-tankuang-info" style="padding:0px 40px">
                    <div class="del-tankuang clearfix" style="padding:10px 20px">
                        <i class="del-tankuang-jinggao pull-left"></i>
                        <p class="del-tankuang-tips pull-left ml-10">请先到<a href="${ctx}/qualificationsAuthenView/fillMsgView.do"> 用户中心-账号管理 </a>页面进行资质认证</p>
                    </div>

                </div>
                <div class="row" style="padding-bottom: 21px;text-align: center;">
                    <button id="qualifyAuthenId" type="button" class="btn btn-primary btn-xl" style="padding: 10px 20px;">现在进行资质认证</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 索取发票未认证/E -->

<!-- 索取发票  资质认证审核中/S -->
<div class="modal fade" id="askBillingModal" tabindex="-1" role="dialog" aria-labelledby="askBillingModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 538px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="<editPhoneModalLabel></editPhoneModalLabel>">索取发票未认证</h4>
            </div>
            <div class="modal-body">
                <div class="row text-center fapiao-tankuang-info" style="padding:0px 40px">
                    <div class="del-tankuang clearfix" style="padding:10px 20px">
                        <i class="del-tankuang-jinggao pull-left"></i>
                        <p class="del-tankuang-tips pull-left ml-10">您的资质认证正在审核中，请耐心等待</p>
                    </div>

                </div>
                <div class="row" style="padding-bottom: 21px;text-align: center;">
                    <button type="button" class="btn btn-primary btn-xl" style="padding: 10px 20px;" onclick="javascript:void($('#askBillingModal').modal('hide'))">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 索取发票  资质认证审核中/E -->

<!-- 发票信息确认/S -->
<div class="modal fade" id="billConfirmModal" tabindex="-1" role="dialog" aria-labelledby="billConfirmModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 700px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="<editPhoneModalLabel></editPhoneModalLabel>">发票信息确认</h4>
            </div>
            <div class="modal-body">
                <form id="billConfirm_formId" method="post" onsubmit="return false">
                    <input type="hidden" name="id" id="billConfirm_id"/>
                    <input type="hidden" name="orderId" id="billConfirm_orderId"/>
                    <input type="hidden" name="activeMonth" id="billConfirm_activeMonth"/>
                    <input type="hidden" name="billingId" id="billConfirm_billingId"/>
                    <input type="hidden" name="billingMoney" id="billConfirm_billingMoney"/>
                    <div class="row text-center fapiao-tankuang-info selfPadding">
                        <div class="fapiao-ensure-tittle clearfix">
                            <h4>发票信息</h4>
                            <a href="http://help.letvcloud.com/Wiki.jsp?page=Receipt" class="a_cls a_cls_com">单次邮寄发票总金额大于¥100免邮，小于¥100顺丰到付</a>
                        </div>
                        <div class="fapiao-ensure-group clearfix">
                            <div class="col-sm-6">
                                <p>发票抬头：<span id="billConfirm_invoiceTitle"></span></p>
                                <input type="hidden" name="invoiceTitle" id="billConfirm_invoiceTitle_input">
                                <p>发票内容：<span id="billConfirm_invoiceContent"></span></p>
                                <input type="hidden" name="invoiceContent" id="billConfirm_invoiceContent_input">
                            </div>
                            <div class="col-sm-6">
                                <p>发票类型：<span id="billConfirm_issueTypeName"></span></p>
                                <input type="hidden" name="issueTypeName" id="billConfirm_issueTypeName_input">
                                <p>发票金额：<span id="billConfirm_invoiceMoney"></span></p>
                                <input type="hidden" name="invoiceMoney" id="billConfirm_invoiceMoney_input">
                            </div>
                        </div>
                        <div class="fapiao-ensure-tittle clearfix">
                            <h4>邮寄地址</h4>
                        </div>
                        <div id="showAddressDivId" class="fapiao-ensure-group clearfix">
                            <div class="col-sm-8">
                                <p>
                                    <span class="info-modify" id="billConfirm_receiveName"></span>
                                    <span class="ml-20">联系电话：</span><span class="info-modify" id="billConfirm_mobile"></span>
                                </p>
                                <p>
                                    <span class="info-modify" id="billConfirm_address"></span>
                                </p>
                            </div>
                            <div class="col-sm-4">
                                <a class="btn btn-default" id="modifyInvoiceBtn">修改邮寄信息</a>
                                <button type="button" class="btn btn-default btn-xl mt-20 hidden" id="modify-save-btn">保存</button>
                                <button type="button" class="btn btn-default btn-xl mt-20 hidden" id="modify-cancle-btn" onclick="javascript:void($('#billConfirmModal').modal('hide'))">取消</button>
                            </div>
                        </div>

                        <div id="modifyAddressDivId" class="fapiao-ensure-group clearfix fapiao-ensure-group-addr hidden">
                            <div class="row">
                                <div class="col-sm-3 row-left"><span class="redColor">*&nbsp;&nbsp;</span>收件人姓名：</div>
                                <div class="col-sm-9 row-right">
                                    <input class="form-input-required" placeholder="请填写姓名" type="text" value="" name="receiveName" id="billConfirm_receiveName_mfy"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 row-left"><span class="redColor">*&nbsp;&nbsp;</span>所在地区：</div>
                                <div class="col-sm-9 row-right">
                                    <select class="select selectWidth form-select-required" name="areaLevel1" id="areaLevel1" onchange="findArea12(this.value,'#areaLevel2')">
                                    </select>
                                    <select class="select selectWidth" name="areaLevel2" id="areaLevel2"  onchange="findArea(this.value,'#areaLevel3')">
                                        <option value=''>请选择</option>
                                    </select>
                                    <select class="select selectWidth" name="areaLevel3" id="areaLevel3">
                                        <option value=''>请选择</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 row-left"><span class="redColor">*&nbsp;&nbsp;</span>街道地址：</div>
                                <div class="col-sm-9 row-right">
                                    <input class="form-input-required" placeholder="请填写详细街道地址" type="text" value="" name="address" id="billConfirm_address_mfy"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 row-left"><span class="redColor">*&nbsp;&nbsp;</span>邮政编码：</div>
                                <div class="col-sm-9 row-right">
                                    <input class="form-input-required-zcode" placeholder="请输入6位有效数字" type="text" value="" name="zipCode" id="billConfirm_zipCode_mfy"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 row-left"><span class="redColor">*&nbsp;&nbsp;</span>手机号码：</div>
                                <div class="col-sm-9 row-right">
                                    <input class="form-input-required-phone" placeholder="请输入正确手机号码" type="text" value="" name="mobile" id="billConfirm_mobile_mfy"/>
                                </div>
                            </div>
                        </div>


                        <div class="fapiao-ensure-tittle clearfix">
                            <h4>相关账单</h4>
                        </div>
                        <div class="fapiao-ensure-group clearfix">
                            <div class="col-sm-12">
                                <p>
                                    <span id="billConfirm_serviceCodeName"></span>
                                    <input type="hidden" name="serviceCodeName" id="billConfirm_serviceCodeName_input">
                                    <span id="billConfirm_billTypeName"></span>
                                    <input type="hidden" name="billTypeName" id="billConfirm_billTypeName_input">
                                    账单周期：
                                    <span id="billConfirm_billStartTime"></span>-
                                    <span id="billConfirm_billEndTime"></span>
                                </p>
                            </div>
                        </div>
                    </div>
                </form>
                <div class="row" style="padding-bottom: 8px;text-align: left;">
                    <button type="button" id="billConfirmForm_btn" class="btn btn-primary" style="padding: 8px 40px;margin-left: 288px;">确定</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 发票信息确认/E -->
<!-- 索取发票/S -->
<div class="modal fade" id="askBillModal" tabindex="-1" role="dialog" aria-labelledby="askBillModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 700px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="<editPhoneModalLabel></editPhoneModalLabel>">索取发票</h4>
            </div>
            <div class="modal-body">
                <form id="modifyInvoice_formId" method="post" onsubmit="return false;">
                    <input type="hidden" name="id" id="askBill_id"/>
                    <input type="hidden" name="orderId" id="askBill_orderId"/>
                    <input type="hidden" name="activeMonth" id="askBill_activeMonth"/>
                    <input type="hidden" name="billingId" id="askBill_billingId"/>
                    <input type="hidden" name="billingMoney" id="askBill_billingMoney"/>
                    <div class="row text-center fapiao-tankuang-info">
                        <div class="fapiao-ensure-tittle clearfix">
                            <h4>发票信息</h4>
                            <a href="http://help.letvcloud.com/Wiki.jsp?page=Receipt" class="a_cls a_cls_com">单次邮寄发票总金额大于¥100免邮，小于¥100顺丰到付</a>
                        </div>
                        <div class="fapiao-ensure-group clearfix">
                            <div class="col-sm-6">
                                <p>发票抬头：<span id="askBill_invoiceTitle"></span></p>
                                <input type="hidden" name="invoiceTitle" id="askBill_invoiceTitle_input">
                                <p>发票内容：<span id="askBill_invoiceContent"></span></p>
                                <input type="hidden" name="invoiceContent" id="askBill_invoiceContent_input">
                            </div>
                            <div class="col-sm-6">
                                <p>发票类型：<span id="askBill_issueTypeName"></span></p>
                                <input type="hidden" name="issueTypeName" id="askBill_issueTypeName_input">
                                <p>发票金额：<span id="askBill_invoiceMoney"></span></p>
                                <input type="hidden" name="invoiceMoney" id="askBill_invoiceMoney_input">
                            </div>
                        </div>
                        <div class="fapiao-ensure-tittle clearfix">
                            <h4>邮寄地址</h4>
                        </div>
                        <div class="fapiao-ensure-group clearfix fapiao-ensure-group-addr">
                            <div class="row">
                                <div class="col-sm-3 row-left"><span class="redColor">*&nbsp;&nbsp;</span>收件人姓名：</div>
                                <div class="col-sm-9 row-right">
                                    <input class="form-input-required" placeholder="请填写姓名" type="text" value="" name="receiveName" id="askBill_receiveName"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 row-left"><span class="redColor">*&nbsp;&nbsp;</span>所在地区：</div>
                                <div class="col-sm-9 row-right">
                                    <select class="select selectWidth form-select-required" name="areaLevel1" id="areaLevel1_up" onchange="findArea12(this.value,'#areaLevel2_up')">
                                    </select>
                                    <select class="select selectWidth" name="areaLevel2" id="areaLevel2_up"  onchange="findArea(this.value,'#areaLevel3_up')">
                                        <option value=''>请选择</option>
                                    </select>
                                    <select class="select selectWidth" name="areaLevel3" id="areaLevel3_up">
                                        <option value=''>请选择</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 row-left"><span class="redColor">*&nbsp;&nbsp;</span>街道地址：</div>
                                <div class="col-sm-9 row-right">
                                    <input class="form-input-required" placeholder="请填写详细街道地址" type="text" value="" name="address" id="askBill_address"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 row-left"><span class="redColor">*&nbsp;&nbsp;</span>邮政编码：</div>
                                <div class="col-sm-9 row-right">
                                    <input class="form-input-required-zcode" placeholder="请输入6位有效数字" type="text" value="" name="zipCode" id="askBill_zipCode"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 row-left"><span class="redColor">*&nbsp;&nbsp;</span>手机号码：</div>
                                <div class="col-sm-9 row-right">
                                    <input class="form-input-required-phone" placeholder="请输入正确手机号码" type="text" value="" name="mobile" id="askBill_mobile"/>
                                </div>
                            </div>
                        </div>
                        <div class="fapiao-ensure-tittle clearfix">
                            <h4>相关账单</h4>
                        </div>
                        <div class="fapiao-ensure-group clearfix">
                            <div class="col-sm-12">
                                <p>
                                    <span id="askBill_serviceCodeName"></span>
                                    <input type="hidden" name="serviceCodeNam" id="askBill_serviceCodeName_input"/>
                                    <span id="askBill_billTypeName"></span>
                                    <input type="hidden" name="billTypeName" id="askBill_billTypeName_input">
                                    账单周期：
                                    <span id="askBill_billStartTime"></span>-
                                    <span id="askBill_billEndTime"></span>
                                </p>
                            </div>
                        </div>
                    </div>
                </form>
                <div class="row" style="padding-bottom: 20px;text-align: center;">
                    <button type="button" class="btn btn-primary" style="padding: 8px 40px;" id="modifyInvoiceForm_btn">确定</button>
                    <button type="button" class="btn btn-cancel" style="padding: 8px 40px;margin-left: 40px;" onclick="javascript:void($('#askBillModal').modal('hide'));">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 索取发票/E -->

<!-- 充值成功/S -->
<div class="modal fade" id="rechargeSuccessModal" tabindex="-1" role="dialog" aria-labelledby="rechargeSuccessModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 540px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="<editPhoneModalLabel></editPhoneModalLabel>">充值完成前请不要关闭此窗口</h4>
            </div>
            <div class="modal-body">
                <div class="row text-center fapiao-tankuang-info" style="padding-bottom: 40px;">
                    <p>请在新开充值页面上完成付款后，再继续支付。</p>
                </div>
                <div class="row" style="padding-bottom: 54px;text-align: left;">
                    <button type="button" class="btn btn-primary" style="padding: 6px 20px;margin-left: 120px;">充值完成</button>
                    <button type="button" class="btn btn-default" style="padding: 6px 20px;margin-left: 60px;">充值遇到问题</button>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<!-- 充值成功/E -->
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<jsp:include page="rechargeFrame.jsp"></jsp:include>
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/usercenterApp.js?t=20150421"></script>
<script type="text/javascript">
    function showSuccessDialog(message, title) {
        title = title == undefined ? "状态提示":title;
        message = message == undefined ? "操作成功！":message;
        $("#successDialogTitleId").text(title);
        $("#successDialogMessageId").text(message);
        $("#deleteModal01").modal("show");
    }

    function showFailDialog(message, title) {
        title = title == undefined ? "状态提示":title;
        message = message == undefined ? "您操作有误，请重新选择！":message;
        $("#failDialogTitleId").text(title);
        $("#failDialogMessageId").text(message);
        $("#deleteModal02").modal("show");
    }
</script>

<!-- 验证失败文件/S -->
<div class="modal fade" id="deleteModal02" tabindex="-1" role="dialog" aria-labelledby="deleteModal02" aria-hidden="true">
    <div class="modal-dialog" style="width: 480px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="<editPhoneModalLabel></editPhoneModalLabel>"><span id="failDialogTitleId"></span></h4>
            </div>
            <div class="modal-body">
                <div class="del-tankuang clearfix">
                    <i class="del-tankuang-jinggao "></i><p class="del-tankuang-tips ml-20">
                    <span id="failDialogMessageId"></span>
                </p>
                </div>

            </div>
            <div class="row" style="padding-bottom: 54px;">
                <button type="button" class="btn btn-primary" data-dismiss="modal" style="padding: 6px 40px;margin-left: 200px;">确定</button>
            </div>
        </div>
    </div>
</div>
<!-- 验证失败文件/E -->

<!-- 验证成功文件/S -->
<div class="modal fade" id="deleteModal01" tabindex="-1" role="dialog" aria-labelledby="deleteModal01" aria-hidden="true">
    <div class="modal-dialog" style="width: 480px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="<editPhoneModalLabel></editPhoneModalLabel>"><span id="successDialogTitleId"></span></h4>
            </div>
            <div class="modal-body">
                <div class="del-tankuang clearfix">
                    <i class="icon-modal-ok del-tankuang-jinggao"></i><p class="del-tankuang-tips ml-20">
                    <span id="successDialogMessageId"></span>
                </p>
                </div>
            </div>
            <div class="row" style="padding-bottom: 54px;">
                <button type="button" class="btn btn-primary" data-dismiss="modal" style="padding: 6px 40px;margin-left: 200px;">确定</button>
            </div>
        </div>
    </div>
</div>
<!-- 验证成功文件/E -->

<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/tx.js"></script>
<script type="text/javascript">
    document.domain="letvcloud.com";
    $ = require("lib/jquery.min");
    $(function() {
        addValidateForm("#modifyInvoice_formId");
        addValidateForm("#billConfirm_formId");

        // 资质认证按钮
        $("#qualifyAuthenId").click(function() {
            window.location.href = "${ctx}/qualificationsAuthenView/fillMsgView.do";
        });
        // 修改发票信息设置
        $("#modifyInvoiceBtn").bind("click", function() {
            $("#showAddressDivId").addClass("hidden");
            $("#modifyAddressDivId").removeClass("hidden");
        });

        // 通过修改发票信息，进行索取发票
        $("#modifyInvoiceForm_btn").bind("click", function() {
            $("#modifyInvoice_formId").submit();
        });
        // 通过确认发票信息，进行索取发票
        $("#billConfirmForm_btn").bind("click", function() {
            $("#billConfirm_formId").submit();
        });

        // 发票索取成功后，刷新页面
        $("#deleteModal01").on("hide.bs.modal", function() {
            window.location.reload();
        });
    });

    function addValidateForm(formId) {
        var judge=$(formId).Validform({
            tiptype:2,
            showAllError:true,
            beforeSubmit:function(curform) {
                $("#billConfirmModal").modal("hide");
                $("#askBillModal").modal("hide");
                // 提交数据，运用 ajax 提交
                var invoiceData = getSubmitData(formId);
                $.ajax({
                    url: "${ctx}/uc/invoice/askBillInvoice.do",
                    type: 'post',
                    dataType: 'JSON',
                    data: invoiceData,
                    success: function (data) {
                        showSuccessDialog("发票索取成功！");
                    },
                    error: function () {
                        showFailDialog("发票索取失败！");
                    }
                });
                return false;
            }
        });
        judge.addRule([{
            ele:".form-input-required",//输入框必填
            datatype:"*"
        }, {
            ele:".form-input-required-s1-25",//8-16位字符串 不包含特殊符号
            datatype:"s1-25"
        }, {
            ele:".form-select-required",//下拉列表select
            datatype:"*"
        }, {
            ele:".form-input-required-phone",//手机
            datatype:"m"
        }, {
            ele:".form-input-required-zcode",//邮政编码
            datatype:"p"
        }]);
    }


    /**
     * 导出明細
     */
    function exportExcel(orderId, billingId, billingMonth, serviceCode) {
        var url = "${ctx}/uc/bill/exportBillExcel.do?orderId=" + orderId + "&billingId=" + billingId +
                "&billingMonth=" + billingMonth + "&=serviceCode=" + serviceCode;
        window.open(url)
    }

    /**
     * 索要发票按钮，不是真正的进行索取发票
     * orderId : 订单号
     * activeMonth ：所属年月份
     */
    function getInvoiceConfirm(billMonthMoney, activeMonth, serviceCode, orderId, billingId, billingMoney) {
        $.ajax({
            url : '${ctx}/uc/invoice/getInvoiceConfirm.do',
            type : 'post',
            dataType:'json',
            data : {
                "billMonthMoney": billMonthMoney,
                "activeMonth":activeMonth,
                "serviceCode":serviceCode
            },
            success : function(data) {
                if(data) {
                    // 如果为公司用户，如果没有进行资政认证，则要进行资质认证
                    if(data.isCompany == true) {
                        //0 未通过 ，1 通过 ，2 等待审核， NULL 用户未上传资质信息
                        if (data.passState == 0 || data.passState == "" || data.passState == "null") {
                            $("#askBillUnautherizeModal").modal('show');
                            return;
                        } else if (data.passState == 2) {
                            $("#askBillingModal").modal("show");
                            return;
                        }
                    }
                    // 已经进行了发票设置
                    if(data.isSettingInvoice) {
                        $("#modifyAddressDivId").addClass("hidden");
                        $("#showAddressDivId").removeClass("hidden");
                        // 设置发票确认框信息
                        setBillConfirmInvoiceData(data);
                        $("#billConfirm_orderId").val(orderId);
                        $("#billConfirm_activeMonth").val(activeMonth);
                        $("#billConfirm_billingMoney").val(billingMoney);
                        $("#billConfirm_billingId").val(billingId);
                        $("#billConfirmModal").modal('show');
                    } else {// 没有进行发票设置
                        // 设置发票修改框信息
                        setAskBillInvoiceData(data);
                        $("#askBill_orderId").val(orderId);
                        $("#askBill_activeMonth").val(activeMonth);
                        $("#askBill_billingMoney").val(billingMoney);
                        $("#askBill_billingId").val(billingId);
                        $("#askBillModal").modal('show');
                    }
                }
            },
            error:function() {
                showFailDialog("发票索取失败！");
            }
        });
    }

    /**
     * 设置发票确认框信息
     * @param invoiceVo
     */
    function setBillConfirmInvoiceData(data) {
        var invoiceVo = data.invoiceVo;
        console.dir(invoiceVo);
        // 主键
        $("#billConfirm_id").val(invoiceVo.id);
        // 发票抬头
        $("#billConfirm_invoiceTitle").text(invoiceVo.invoiceTitle);
        $("#billConfirm_invoiceTitle_input").val(invoiceVo.invoiceTitle);
        // 发票内容
        $("#billConfirm_invoiceContent").text(invoiceVo.invoiceContent);
        $("#billConfirm_invoiceContent_input").val(invoiceVo.invoiceContent);
        // 发票类型
        $("#billConfirm_issueTypeName").text(invoiceVo.issueTypeName);
        $("#billConfirm_issueTypeName_input").val(invoiceVo.issueTypeName);
        // 发票金额
        $("#billConfirm_invoiceMoney").text(invoiceVo.invoiceMoney);
        $("#billConfirm_invoiceMoney_input").val(invoiceVo.invoiceMoney);
        // 收件人姓名
        $("#billConfirm_receiveName").text(invoiceVo.receiveName);
        $("#billConfirm_receiveName_mfy").val(invoiceVo.receiveName);
        // 联系电话
        $("#billConfirm_mobile").text(invoiceVo.mobile);
        $("#billConfirm_mobile_mfy").val(invoiceVo.mobile);
        var areaLevel1Name = invoiceVo.areaLevel1Name == undefined?"" : invoiceVo.areaLevel1Name;
        var areaLevel2Name = invoiceVo.areaLevel2Name == undefined?"" : invoiceVo.areaLevel2Name;
        var areaLevel3Name = invoiceVo.areaLevel3Name == undefined?"" : invoiceVo.areaLevel3Name;
        var address = areaLevel1Name + " " + areaLevel2Name + " " + areaLevel3Name + " "
                + invoiceVo.address + "  " + invoiceVo.zipCode;
        // 地址
        $("#billConfirm_address").text(address);
        // 街道地址
        $("#billConfirm_address_mfy").val(invoiceVo.address);
        // 邮政编码
        $("#billConfirm_zipCode_mfy").val(invoiceVo.zipCode);
        // 产品类型
        $("#billConfirm_serviceCodeName").text(invoiceVo.serviceCodeName);
        $("#billConfirm_serviceCodeName_input").val(invoiceVo.serviceCodeName);
        // 计费类型
        $("#billConfirm_billTypeName").text(invoiceVo.billTypeName);
        $("#billConfirm_billTypeName_input").val(invoiceVo.billTypeName);
        // 账单周期 开始
        $("#billConfirm_billStartTime").text(invoiceVo.billStartTime);
        // 账单周期 结束
        $("#billConfirm_billEndTime").text(invoiceVo.billEndTime);
        // 设置地址  三级地区
        if(data.areaLevel1List) {
            appendOptions("#areaLevel1", data.areaLevel1List, invoiceVo.areaLevel1, true);
        }
        if(data.areaLevel2List) {
            appendOptions("#areaLevel2", data.areaLevel2List, invoiceVo.areaLevel2, false);
        } else {
            $("#areaLevel2").html("<option value=''>请选择</option>");
        }
        if(data.areaLevel3List) {
            appendOptions("#areaLevel3", data.areaLevel3List, invoiceVo.areaLevel3, false);
        } else {
            $("#areaLevel3").html("<option value=''>请选择</option>");
        }
    }

    /**
     * 设置发票修改框信息
     */
    function setAskBillInvoiceData(data) {
        var invoiceVo = data.invoiceVo;
        // 主键
        $("#askBill_id").val(invoiceVo.id);
        // 发票抬头
        $("#askBill_invoiceTitle").text(invoiceVo.invoiceTitle);
        $("#askBill_invoiceTitle_input").val(invoiceVo.invoiceTitle);
        // 发票内容
        $("#askBill_invoiceContent").text(invoiceVo.invoiceContent);
        $("#askBill_invoiceContent_input").val(invoiceVo.invoiceContent);
        // 发票类型
        $("#askBill_issueTypeName").text(invoiceVo.issueTypeName);
        $("#askBill_issueTypeName_input").val(invoiceVo.issueTypeName);
        // 发票金额
        $("#askBill_invoiceMoney").text(invoiceVo.invoiceMoney);
        $("#askBill_invoiceMoney_input").val(invoiceVo.invoiceMoney);
        // 收件人姓名
        $("#askBill_receiveName").val(invoiceVo.receiveName);
        // 联系电话
        $("#askBill_mobile").val(invoiceVo.mobile);
        // 地址
        $("#askBill_address").val(invoiceVo.address);
        // 邮政编码
        $("#askBill_zipCode").val(invoiceVo.zipCode);

        // 计费类型
        $("#askBill_billTypeName").text(invoiceVo.billTypeName);
        // 账单周期 开始
        $("#askBill_billStartTime").text(invoiceVo.billStartTime);
        // 账单周期 结束
        $("#askBill_billEndTime").text(invoiceVo.billEndTime);
        // 设置地址  三级地区
        if(data.areaLevel1List) {
            appendOptions("#areaLevel1_up", data.areaLevel1List, invoiceVo.areaLevel1, true);
        }
        if(data.areaLevel2List) {
            appendOptions("#areaLevel2_up", data.areaLevel2List, invoiceVo.areaLevel2, false);
        } else {
            $("#areaLevel2_up").html("<option value=''>请选择</option>");
        }
        if(data.areaLevel3List) {
            appendOptions("#areaLevel3_up", data.areaLevel3List, invoiceVo.areaLevel3, false);
        } else {
            $("#areaLevel3_up").html("<option value=''>请选择</option>");
        }
    }

    function getSubmitData(formId) {
        var str = $(formId).serialize();
        var data = str.split("&");
        var result = new Object();

        $.each(data, function (index, row) {
            var item = row.split("=");
            result[item[0]] = decodeURIComponent(item[1]);
        });
        return result;
    }

    function findArea12(areaLevel, areaCode) {
        if(areaLevel == "") {
            if(areaCode == "#areaLevel2") {
                $("#areaLevel2").html("<option value=''>请选择</option>");
                $("#areaLevel3").html("<option value=''>请选择</option>");
            } else if(areaCode == "#areaLevel2_up"){
                $("#areaLevel2_up").html("<option value=''>请选择</option>");
                $("#areaLevel3_up").html("<option value=''>请选择</option>");
            }
        } else {
            $.ajax({
                type: "GET",
                url: "${ctx}/area/getArea.do?upAreaCode=" + areaLevel,
                dataType: "JSON",
                success: function (data) {
                    var areaId = appendOptions(areaCode, data, null, false);
                    // 刷新第三级地区
                    if(areaCode == "#areaLevel2") {
                        findArea(areaId, "#areaLevel3");
                    } else if(areaCode == "#areaLevel2_up"){
                        findArea(areaId, "#areaLevel3_up");
                    }
                }
            });
        }
    }

    /**
     * 查询地区
     * @param areaLevel
     * @param areaCode
     */
    function findArea(areaLevel, areaCode) {
        $.ajax({
            type: "GET",
            url: "${ctx}/area/getArea.do?upAreaCode=" + areaLevel,
            dataType: "JSON",
            success: function (data) {
                appendOptions(areaCode, data, null, false);
            }
        });
    }

    function appendOptions(areaCode, data, selectValue, defOption) {
        var area = "";
        if(defOption == true) {
            area = "<option value=''>请选择</option>";
        }
        var areaId;
        $.each(data, function (index, item) {
            if(index == 0) {
                areaId = item.id;
            }
            if(item.id == selectValue) {
                area += "<option selected='selected' value = '" + item.id + "'>" + item.areaName + "</option>";
            } else {
                area += "<option value = '" + item.id + "'>" + item.areaName + "</option>";
            }
        })
        $(areaCode).html(area);
        return areaId;
    }

    // 充值成功，回调函数
    function rechargeBackFunction(data){
        $("#user-account").text(data);
    }
</script>
</body>
</html>
<!-- file tree:
|...usercenter-zhangdan-2.html
| |...header-usercenter.html
| |...footer.html
- By MOKTEXT. -->