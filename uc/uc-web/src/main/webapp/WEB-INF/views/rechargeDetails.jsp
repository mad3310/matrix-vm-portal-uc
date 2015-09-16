<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/usercenterRechargeApp.css"/>

<jsp:include page="header-e.jsp"></jsp:include>
<!-- 顶部head/E-->
<!-- 中部内容/S-->
<section class="le-user-main comwidth clearfix">
    <div class="le-user-warp clearfix" id="usercenter">
        <!-- 左侧/S-->
        <%@include file="ucLeft.jsp" %>
        <!-- 左侧/E-->
        <!-- 主体内容/S-->
        <div class="user-recharge-right">
            <div class="user-recharge-intro">
                <div class="user-rechargeRt-top">
                    <h3><a href="${ctx}/userView/ucOverview.do" style="color:black;">用户中心概览</a> &nbsp;><span>明细</span></h3>
                    <p><span>账户余额</span><span>￥${totalMoney}</span></p>
                </div>
                <div class="leyun-warp-body">
                    <div class="leyun-warp-container">
                        <div class="table-luzhi-wraper">
                            <table id="rechargeDetail_tab" class="table table-responsive table-luzhi"
                                   style="margin-bottom:10px;">
                                <thead>
                                <tr>
                                    <th class="col-sm-3">创建时间</th>
                                    <th class="col-sm-3">名称</th>
                                    <th class="col-sm-3">充值金额</th>
                                    <th class="col-sm-3">状态</th>
                                </tr>
                                </thead>
                                <tbody id="itemContainer">
                                </tbody>
                            </table>
                        </div>
                        <%--                 <div class="paging clearfix" style="padding:10px 0">
                                             <div class="pull-right">
                                                 <div class="pull-left mt-5">
                                                     共&nbsp;
                                                     <span class="text-primary">${totalSize}</span>&nbsp;条，每页显示&nbsp;
                                                     <span class="text-primary">5</span>&nbsp;条
                                                 </div>
                                                 <div class="page-ljl ml-20 pull-left"></div>
                                             </div>
                                         </div>--%>
                        <!--page/s-->
                        <div id="rechargePageTool" class="pull-left ml-20"></div>
                        <!--page/e-->
                    </div>
                </div>
            </div>
        </div>
        <!-- 主体内容/E-->

    </div>
</section>
<!-- 中部内容/E-->
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/usercenterApp.js?t=20150421"></script>
<script type="text/javascript">
    $ = jQuery = require("lib/jquery.min");
</script>
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/page/pageTool.js"></script>
<!-- <script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/jquery-1.7.2.min.js"></script> -->
<%--<script type="text/javascript" src="http://luis-almeida.github.io/jPages/js/jPages.js"></script>
<script type="text/javascript">
    function addTr(index){ //动态生成tr
        // for(var i=0;i<=index;i++){
        // 	$("#itemContainer").append("<tr><td><div class='pull-left ckbox-wraper'><input type='checkbox' name='checkVideo' class='ckbox' /></div><div class='img-wraper pull-left ml1-20'><a href='#' data-toggle='modal' data-target='#editPhoneModal'><img src='images/zb/luzhi001.jpg' alt='图片'/><div class='mask-img'></div></a></div><div class='col-sm-6 pt-20 ml-20'><div class='text-left'><a href='#' data-toggle='modal' data-target='#editPhoneModal'>去哪儿2015年会活动</a></div><p class='text-hui text-left'>活动ID:201501063090006</p></div></td><td>2015-06-12  12:49</td><td><a href='#'>点播管理</a></td></tr>");
        // }//
        for(var i=0;i<=index;i++){
            $("#itemContainer").append("<p></p>");
        }
    }
    $(function(){
        //动态添加示例
//        addTr(10);
        //翻页控件
        $(".page-ljl").jPages({
            containerID: "itemContainer",//内容ID
            previous: " « ",
            next: " »",
            perPage: 5, //每页展示条数
            midRange: 3, //默认展示页数
        });
    });
</script>--%>
<script type="text/javascript">

    var fetchSize = 10;// 每页显示几条记录
    var start = 1;//显示第几页，默认显示第1页
    $(function () {
        // 加载列表数据
        loadRechargeDetailData(start, fetchSize);
        function activedetail(){
            $("#userside ul li:first").addClass("active");
        };
        activedetail();
    });
    /**
     * 加载充值记录数据
     */
    function loadRechargeDetailData(start, fetchSize) {
        // 直播活动名称或者ID 的模糊匹配条件
        $.ajax({
            url: "${ctx}/recharge/loadRechargeDetails.do",
            type: 'POST',
            dataType: 'json',
            data: {
                "fetchSize": fetchSize,
                "start": start
            },
            success: function (data) {
                $("#rechargeDetail_tab thead tr:gt(0)").remove();
                $("#rechargeDetail_tab tbody").empty();
                var totalCount = 0;
                if (data) {
                    $.each(data.rows, function (index, row) {
                        totalCount = data.total;
                        var chargeType = "";
                        var chargeState = "";
                        if (row.rechargeType == 1) {
                            chargeType = "充值：支付宝";
                        } else if (row.rechargeType == 2) {
                            chargeType = "充值：微信";
                        }
                        if (row.success == 1) {
                            chargeState = '<th class="col-sm-3">充值成功</th>';
                        } else if (row.success == 0) {
                            chargeState = '<th class="col-sm-3 table-price-failure">充值失败</th>';
                        }
                        var trStr = '<tr>\
                                <th class="col-sm-3">' + row.createdTime + '</th>\
                                <th class="col-sm-3">' + chargeType + '</th>\
                                <th class="col-sm-3 table-price-color">' + row.amount + '</th>\
                                ' + chargeState + '\
                            </tr>';
                        $("#rechargeDetail_tab thead").append(trStr);
                    });
                }else {
                    $("#rechargeDetail_tab tbody").append('<tr><td colspan="4">暂无充值记录</td></tr>');
                }
                // 分页信息
                $("#rechargePageTool").pageTool({
                    "total": totalCount,
                    "fetchSize": fetchSize,
                    "getPage": function (activePage, fetchSize) {// activePage 当前页,从 1 开始。fetchSize为每页的数量
                        loadRechargeDetailData(activePage, fetchSize);
                    }
                });
            }
        });
    }

</script>
</body>
</html>
<!-- file tree:
|...usercenter-recharge-intro.html
| |...header-recharge-intro.html
| |...usercenter-header.html
| |...footer.html
- By MOKTEXT. -->