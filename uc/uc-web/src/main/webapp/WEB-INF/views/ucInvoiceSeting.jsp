<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="/assets/css/main/usercenterApp.css"/>
<style>
    .input-color{
        color:#666 !important;
    }

    .form-con li .info .input-long{ width: 350px;}
    .form-con li{height:32px;line-height:32px;overflow:hidden}
    .Validform_checktip{position:relative; left:10px;top:-4px;}
    .redColor{
        color:#fb040d;
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
        <input id="isCompany" type="hidden" value="${isCompany}"/>
        <input id="passState" type="hidden" value="${passState}"/>
        <form class="vform" id="invoiceForm" method="post">
            <div class="le-user-box clearfix" id="userbox">
                <div class="le-user-con clearfix">
                    <h3 class="title-nemo border-bottom-e3">发票设置</h3>
                    <div class="form-con">
                        <ul class="clearfix">
                            <li>
                                <div class="type">开具类型：</div>
                                <div class="info">
                                    <c:if test="${currentUser.userType == 2}">
                                        <div class="label-txt">
                                            <input name="issueType" type="hidden" value="${currentUser.userType}"/>
                                            <span>个人</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${currentUser.userType == 3 || currentUser.userType == 6}">
                                        <div class="label-txt">
                                            <input name="issueType" type="hidden" value="${currentUser.userType}"/>
                                            <span>企业</span>
                                        </div>
                                    </c:if>
                                </div>
                            </li>
                            <li>
                                <div class="type">发票抬头：</div>
                                <div class="info">
                                    <span>${invoice.invoiceTitle}</span>
                                    <input type="hidden" name="invoiceTitle" value="${invoice.invoiceTitle}">
                                </div>
                            </li>
                            <li>
                                <div class="type">发票类型：</div>
                                <input type="hidden" name="invoiceType" value="1">
                                <span>增值税普通发票</span>
                            </li>
                        </ul>
                    </div>
                    <h3 class="title-nemo border-bottom-e3">地址信息</h3>
                    <div class="form-con" id="invoiceDiv_input">
                        <ul class="clearfix">
                            <li>
                                <div class="type"><span class="redColor">*&nbsp;&nbsp;</span>收件人姓名：</div>
                                <div class="info">
                                    <input type="text" name="receiveName" placeholder="收件人姓名"
                                           value="${invoice.receiveName}" class="input-long input-color form-input-required-s1-25 pull-left">
                                </div>
                            </li>
                            <li>
                                <div class="type"><span class="redColor">*&nbsp;&nbsp;</span>所在地区：</div>
                                <div class="info">
                                    <select class="select form-select-required pull-left" name="areaLevel1"
                                            onchange="findArea12(this.value,'#areaLevel2')">
                                        <option value="">请选择</option>
                                        <c:forEach var="areaLevel1" items="${areaLevel1List}">
                                            <c:if test="${invoice.areaLevel1 == areaLevel1.id}">
                                                <option selected="selected" value="${areaLevel1.id}">${areaLevel1.areaName}</option>
                                            </c:if>
                                            <c:if test="${invoice.areaLevel1 != areaLevel1.id}">
                                                <option value="${areaLevel1.id}">${areaLevel1.areaName}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                    <select class="select pull-left ml-10" name="areaLevel2" id="areaLevel2"
                                            onchange="findArea(this.value,'#areaLevel3')">
                                        <option value="">请选择</option>
                                        <c:forEach var="areaLevel2" items="${areaLevel2List}">
                                            <c:if test="${invoice.areaLevel2 == areaLevel2.id}">
                                                <option selected="selected" value="${areaLevel2.id}">${areaLevel2.areaName}</option>
                                            </c:if>
                                            <c:if test="${invoice.areaLevel2 != areaLevel2.id}">
                                                <option value="${areaLevel2.id}">${areaLevel2.areaName}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                    <select class="select pull-left ml-10" name="areaLevel3" id="areaLevel3">
                                        <option value="">请选择</option>
                                        <c:forEach var="areaLevel3" items="${areaLevel3List}">
                                            <c:if test="${invoice.areaLevel3 == areaLevel3.id}">
                                                <option selected="selected" value="${areaLevel3.id}">${areaLevel3.areaName}</option>
                                            </c:if>
                                            <c:if test="${invoice.areaLevel3 != areaLevel3.id}">
                                                <option value="${areaLevel3.id}">${areaLevel3.areaName}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </li>
                            <li>
                                <div class="type"><span class="redColor">*&nbsp;&nbsp;</span>街道地址：</div>
                                <div class="info">
                                    <input type="text" name="address" placeholder="街道地址" value="${invoice.address}"
                                           class="input-long input-color form-input-required  pull-left ">
                                </div>
                            </li>
                            <li>
                                <div class="type"><span class="redColor">*&nbsp;&nbsp;</span>邮政编码：</div>
                                <div class="info">
                                    <input type="text" name="zipCode" placeholder="邮政编码" value="${invoice.zipCode}"
                                           class="input-long input-color form-input-required-zcode  pull-left">
                                </div>
                            </li>
                            <li>
                                <div class="type"><span class="redColor">*&nbsp;&nbsp;</span>手机号码：</div>
                                 <div class="info">
                                    <input type="text" name="mobile" placeholder="手机号码" value="${invoice.mobile}"
                                           class="input-long input-color form-input-required-phone  pull-left" nullmsg="请填写手机号码！" errormsg="请填写正确的手机号码！" />
                                </div>
                            </li>
                        </ul>
                        <div class="btn-con">
                            <a href="javascript:;" id="submitInvoiceBtn" class="btn-submit link-white">保存</a>
                            <a href="javascript:;" id="cancelModifyBtn" class="btn-cancel link-white ml-20">取消</a>
                        </div>
                    </div>
                    <div class="form-con" id="invoiceDiv_show">
                        <ul class="clearfix">
                            <li>
                                <div class="type">收件人姓名：</div>
                                <div class="info">
                                    <span>${invoice.receiveName}</span>
                                </div>
                            </li>
                            <li>
                                <div class="type">所在地区：</div>
                                <div class="info">
                                    <c:forEach var="areaLevel1" items="${areaLevel1List}">
                                        <c:if test="${invoice.areaLevel1 == areaLevel1.id}">
                                            <span>${areaLevel1.areaName}</span>
                                        </c:if>
                                    </c:forEach>
                                    <c:forEach var="areaLevel2" items="${areaLevel2List}">
                                        <c:if test="${invoice.areaLevel2 == areaLevel2.id}">
                                            <span>${areaLevel2.areaName}</span>
                                        </c:if>
                                    </c:forEach>
                                    <c:forEach var="areaLevel3" items="${areaLevel3List}">
                                        <c:if test="${invoice.areaLevel3 == areaLevel3.id}">
                                            <span>${areaLevel3.areaName}</span>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </li>
                            <li>
                                <div class="type">街道地址：</div>
                                <div class="info">
                                    <span>${invoice.address}</span>
                                </div>
                            </li>
                            <li>
                                <div class="type">邮政编码：</div>
                                <div class="info">
                                    <span>${invoice.zipCode}</span>
                                </div>
                            </li>
                            <li>
                                <div class="type">手机号码：</div>
                                <div class="info">
                                    <span>${invoice.mobile}</span>
                                </div>
                            </li>
                        </ul>
                        <div class="btn-con">
                            <a href="javascript:;" id="modifyInvoiceBtn" class="btn-submit link-white">修改</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 左侧/E-->
        </form>
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
                <div class="row text-center fapiao-tankuang-info" style="padding:5px 75px 10px">
                    <div class="del-tankuang clearfix">
                        <i class="del-tankuang-jinggao pull-left"></i>
                        <p class="del-tankuang-tips pull-left ml-10">请先到<a href="${ctx}/qualificationsAuthenView/fillMsgDiretView.do"> 用户中心-账号管理 </a>页面进行资质认证</p>
                    </div>
                </div>
                <div class="row" style="padding-bottom: 30px;text-align: center;">
                    <button id="qualifyAuthenId" type="button" class="btn btn-primary btn-xl" style="padding: 10px 20px;">现在进行资质认证</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 索取发票未认证/E -->
<!-- 资质认证正在审核中 S-->
<div class="modal fade" id="askBillingModal" tabindex="-1" role="dialog" aria-labelledby="askBillUnautherizeModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 538px;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">索取发票未认证</h4>
            </div>
            <div class="modal-body">
                <div class="row text-center fapiao-tankuang-info" style="padding:5px 75px 10px">
                    <div class="del-tankuang clearfix">
                        <i class="del-tankuang-jinggao pull-left"></i>
                        <p class="del-tankuang-tips pull-left ml-10">您的资质认证正在审核中，请耐心等待</p>
                    </div>
                </div>
                <div class="row" style="padding-bottom: 30px;text-align: center;">
                    <button type="button" class="btn btn-primary btn-xl" style="padding: 7px 25px;" onclick="javascript:void($('#askBillingModal').modal('hide'))">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 资质认证正在审核中 E-->

<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/usercenterApp.js?t=20150421"></script>
<script type="text/javascript">
    $ = require("lib/jquery.min");
    require('lib/jquery.validform');//validform 学习：http://validform.rjboy.cn/document.html
    $(function () {
        var judge=$(".vform").Validform({
            tiptype:3,
            showAllError:true
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


        $('#askBillUnautherizeModal').on('hide.bs.modal', function () {
            window.location.href = "${ctx}/qualificationsAuthenView/fillMsgDiretView.do";
        });

        $('#askBillingModal').on('hide.bs.modal', function () {
            window.location.href = "${ctx}/userView/ucOverview.do";
        });
        // 资质认证按钮
        $("#qualifyAuthenId").click(function() {
            window.location.href = "${ctx}/qualificationsAuthenView/fillMsgDiretView.do";
        });

        var isCompany = $("#isCompany").val();
        if(isCompany == "true") {
            // 资质认证未通过  passState  0 未通过 ，1 通过 ，2 等待审核， NULL 用户未上传资质信息
            if($("#passState").val() == "0" || $("#passState").val() == "" || $("#passState").val() == "null") {
                $("#askBillUnautherizeModal").modal('show');
                return;
            } else if($("#passState").val() == "2") {// 等待审核中
                $("#askBillingModal").modal('show');
            }
        }

        $("#cancelModifyBtn").click(function() {
            showInvoiceDiv();
        });

        // 发票设置表单提交
        $("#submitInvoiceBtn").click(function () {
            $("#invoiceForm").attr("action", "${ctx}/uc/invoice/saveOrUpdateInvoice.do");
            $("#invoiceForm").submit();
        });

        $("#modifyInvoiceBtn").click(function() {
            $("#invoiceDiv_input").show();
            $("#invoiceDiv_show").hide();
        });
        showInvoiceDiv();
    });

    function showInvoiceDiv() {
        $("#invoiceDiv_input").hide();
        $("#invoiceDiv_show").show();
    }

    /**
     * 二级查询
     */
    function findArea12(areaLevel, areaCode) {
        if(areaLevel == "") {
            $("#areaLevel2").html("<option value=''>请选择</option>");
            $("#areaLevel3").html("<option value=''>请选择</option>");
        } else {
            $.ajax({
                type: "GET",
                url: "${ctx}/area/getArea.do?upAreaCode=" + areaLevel,
                dataType: "JSON",
                success: function (data) {
                    var area = "";
                    var areaLevel12;
                    $.each(data, function (index, item) {
                        if(index == 0) {
                            areaLevel12 = item.id;
                        }
                        area += "<option value = '" + item.id + "'>" + item.areaName + "</option>";
                    })
                    $(areaCode).html(area);
                    findArea(areaLevel12, "#areaLevel3");
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
                var area = "";
                $.each(data, function (index, item) {
                    area += "<option value = '" + item.id + "'>" + item.areaName + "</option>";
                })
                $(areaCode).html(area);
            }
        });
    }

</script>
</body>
</html>
<!-- file tree:
|...usercenter-bill.html
| |...header-usercenter.html
| |...usercenter-header.html
| |...footer.html
- By MOKTEXT. -->