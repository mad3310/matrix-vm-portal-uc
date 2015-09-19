<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/loginApp.css"/>
<jsp:include page="header-e1.jsp"></jsp:include>
<style type="text/css">
    @media (max-width: 1650px) and (min-width: 1260px) {
        .login-ljl {
            margin-top: 110px;
        }
    }
    @media (max-width: 1260px) {
        .login-ljl {
            margin-top: 100px;
        }
    }
    @media (min-width: 1650px)  {
        .login-ljl {
            margin-top: 200px;
        }
    }


</style>
<!--nav/E-->
<!--main /S-->
<div class="login-bg-ljl" style="background-size:cover; ">
    <div class="comwidth clearfix">
        <div class="login-ljl pull-right">
            <h1>用户登录</h1>
            <p id="login-error-tip" class="clearfix login-error-tip"><c:if test="${not empty error }">${error}</c:if></p>
            <form id="vform" action="${ctx}/login.do"  method="post">
                <input id="backUrl" type="hidden" name="backUrl" value="${param.backUrl}">
                <ul class="form clearfix">
                    <li>
                        <span class="type">邮<span class="pl-20"></span>箱：</span>
                        <span class="info"><input type="text" id="username" class="input required" value="${username}" name="username" tabindex="1"/></span>
                    </li>
                    <li>
                        <span class="type">密<span class="pl-20"></span>码：</span>
                        <span class="info"><input type="password" id="password" class="input input-pwd required" value="${password}" name="password" tabindex="2"/><a href="javascript:;" class="icon-view" id="btn-view-password"></a></span>
                    </li>
                    <li>
                        <span class="type">验证码：</span>
                 <span class="info"><input type="text" id="code" class="input-short required" name="captchaCode" tabindex="3" />
                 <span class="yzm"><a href="#"><img id="captcha" src="${ctx}/captcha/createCaptcha.do" /></a></span><span class="icon-refresh" id="captchaRefresh"></span></span>
                    </li>
                    <li class="txt">
                        <span class="type"></span>
                  <span class="info">
                      <%--<label for="remember"><input type="checkbox" name="remember" class="check" id="remember">记住密码</label>--%>
                      <a id="yzmError" class="link-red" style="display: none;text-decoration: none;">验证码错误</a>
                          <a href="${ctx}/restPassword/backPasswordView.do" class="link-red">忘记密码</a>
                  </span>
                    </li>
                </ul>
                <div class="clearfix mt-20">
                    <input type="submit" class="btn btn-login link-white" id="loginSubmit" value="登录" />
                    <a href="${ctx}/registerView/registerUserView.do" class="link-quick-reg link-red">快速注册</a>
                </div>
            </form>
        </div>

    </div>
</div>
<!--main /E-->
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
</body>

<script src="http://static.uc.letvcloud.com/js/min/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
    document.domain = "letvcloud.com";
    $(function(){
        if(window != top){
            top.location.href='${ctx}/userView/ucOverview.do';
        }
    	var type <c:if test="${not empty type }">=${type};</c:if>
    	if(type!=undefined){
    		alert("注册成功，请登录");
    	}

        //pwd
        var pwd_change_flag=false,pwd_input=$(".input-pwd");
        $("#btn-view-password").bind("click",function(){
            if(!pwd_change_flag){
                pwd_input.attr("type","text");
                pwd_change_flag=true;
            }else{
                pwd_input.attr("type","password");
                pwd_change_flag=false;
            }
        });

        //form input blur
        var inputs_required = $("#vform :input.required"),
                errorTip = $("#login-error-tip"),
                formInputJudge = function(obj){
                    var judgeVal = obj.val();
                    if(judgeVal=="" || judgeVal==null){
                        obj.addClass("Validform_error");
                        errorTip.html("请填写完整信息");
                    }else{
                        obj.removeClass("Validform_error");
                        errorTip.html("");
                    }
                };
        inputs_required.blur(function(){
            formInputJudge($(this));
        });
        //from submit
        $('#loginSubmit').click(function(){
            inputs_required.trigger('blur');//form 必填项 失去焦点
            var numError = $('#vform .Validform_error').length;//判断form中 input的错误个数 决定是否提交
            if(numError){
                return false;
            }
        });
        $('#captchaRefresh').click(function () {

            $("#captcha").attr("src", '${ctx}/captcha/createCaptcha.do?date=' + new Date());
        });
        var obj=$("#username").val();
        $("#username").change(function(){
            if(obj!=null && obj!=""){
                $("#backUrl").val("");
            }
        });
        //调整登陆页高度，.login-bg-ljl最低高度控制在550px以上
        function heightlogin(){
            var height = $(window.parent.window).height();
            if(height>740){
                var bdht2=height;
                $(".login-bg-ljl").css(
                        "height",bdht2+'px');
            }else{
                $(".login-bg-ljl").css(
                        "height","680px");
            };
        };
        heightlogin();

        var yzmFlag = false;
        $("#code").blur(function(){
            var code = $("#code").val();
            if(code.length == 4){
            $.ajax({
                type : "GET",
                url : "${ctx}/captcha/yzmCheck.do?captchaCode=" + $("#code").val(),
                dataType : "text",
                success : function(data){
                    console.info(data)
                    if(data == "ok"){
                        console.info("ok")
                        $("#yzmError").hide();
                        yzmFlag = true;
                    }else{
                        console.info("wrong")
                        $("#yzmError").show();
                        yzmFlag = false;
                    }
                }
            });
            }
        })

    });
</script>

</html>
<!-- file tree:
|...login.html
| |...header-login.html
| |...footer.html
- By MOKTEXT. -->
