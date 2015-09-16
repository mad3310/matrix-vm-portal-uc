<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/registerApp.css"/>

<jsp:include page="header-e.jsp"></jsp:include>
<style>
    .div-500-content {
        position: relative;
        width: 836px;
        height: 100%;
        overflow: hidden;
        margin: auto;
        background: url(http://static.uc.letvcloud.com/images/prompt500.png) no-repeat center center;
    }
    .div-500-button {
        height: 40px;
        width: 285px;
        top: 73%;
        position: relative;
        left: 60%;
    }
    .a-500-button {
        display: inline-block;
        width: 120px;
        height: 40px;
        text-align: center;
        background-color: #1073c2;
    }
    .a-500-button a {
        display: inline-block;
        color: #ffffff;
        font-size: 16px;
        line-height: 40px;
        width: 100%;
    }
</style>
<script>
    $(function(){
        var t = $(window.parent.window).height();
        var e = t - 220;
        $("#bd500box_2").css({
            height: e + "px"
        })
    });
</script>
<!--head/E-->
<section class="le-user-warp clearfix">
    <div class="div-500-box comwidth" id="bd500box_2">
        <div class="div-500-content">
            <div style="width:1000px;margin:0 auto;top:65%;position:relative">
                <div class="div-500-button"  style="left:585px">
                    <span class="a-500-button">
                        <a href="http://www.letvcloud.com/">回到首页</a>
                    </span>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 内容区域/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
</body>
</html>