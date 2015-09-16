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
                <h3 class="title-nemo border-bottom-e3">用户私钥</h3>

                <div class="user-key-info">
                    <p class="txt icon-user-id">用户ID： <span id="userId"></span></p>

                    <p class="txt icom-user-key">私钥： <span id="userKey"></span></p>
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

<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/jquery-1.7.2.min.js"></script>
<script type="text/javascript">




    $(function(){
        $.ajax({
            type: "GET",
            url: "${ctx}/user/searchCurrentUser.do",
            dataType: "JSON",
            success: function (data) {

                $("#userId").html(data.id);
                $("#userKey").html(data.userKey);
            }
        });
    });
</script>
</body>
</html>
<!-- file tree:
|...usercenter-key.html
| |...header-usercenter.html
| |...footer.html
- By MOKTEXT. -->