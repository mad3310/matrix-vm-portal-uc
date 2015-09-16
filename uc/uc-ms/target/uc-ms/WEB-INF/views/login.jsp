<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/include.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>登录</title>
    <link href="<%=basePath%>resources/style/login.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript">
        <!--
        var isSubmit = true;
        $(function () {
            bindKeyDownEvevt();
        });
        function bindKeyDownEvevt() {
            document.onkeydown = function (e) {
                var theEvent = window.event || e;
                var code = theEvent.keyCode || theEvent.which;
                if (code == 13 && isSubmit) {
                    checkForm();
                }
            }
        }
        function checkForm() {
            if ($.trim($('#username').val()) == 0) {
                isSubmit = false;
                $.messager.alert('提示', '<br>请输入用户名信息!', 'warning', function (msg) {
                    $('#username').focus();
                    isSubmit = true;
                });
                return;

            } else if ($.trim($('#password').val()) == 0) {
                isSubmit = false;
                $.messager.alert('提示', '<br>请输入密码信息!', 'warning', function (msg) {
                    $('#password').focus();
                    isSubmit = true;
                });
                return;
            } else {
                $.messager.progress();
                $.ajax({
                    type: 'POST',
                    url: '<%=basePath%>/login/check',
                    data: {username: $.trim($("#username").val()), password: $.trim($("#password").val())},
                    success: function (msg) {
                        isSubmit = false;
                        if (msg.result == 0) {
                            $.messager.progress('close');
                            if (msg.errorMessage) {
                                $.messager.alert('提示', '<br>用户名或密码错误!', 'warning', function (msg) {
                                    isSubmit = true;
                                });
                            } else {
                                $.messager.alert('提示', '<br>' + msg.errorMessage + '!', 'warning', function (msg) {
                                    isSubmit = true;
                                });
                            }
                        } else {
                            location.assign("<%=basePath%>/index");
                        }
                    },
                    error: function () {
                        $.messager.progress('close');
                        $.messager.alert('提示', '<br>系统异常,请于管理员联系!', 'warning', function (msg) {
                        });
                    }
                });
            }
        }
        $(document).ready(function () {
            //focus username field
            $("input:visible:enabled:first").focus();
        });

        -->
    </script>
</head>
<body id="cas" style="width:100%; overflow: hidden; padding-top:100px;" topmargin="0" leftmargin="0">
<form id="fm1" style="width:100%;" method="post">
    <table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
        <tbody>
        <tr>
            <td valign="middle" height="379" align="center">
                <table class="logo" width="512" cellspacing="0" cellpadding="2" border="0">
                    <tbody>
                    <tr>
                        <td class="zi-head" align="center" colspan="4">工单运营管理系统</td>
                    </tr>
                    <tr>
                        <td class="color" style="padding-left: 60px;"></td>
                    </tr>
                    <tr>
                        <td class="color">
                            <input id="username" type="text" autocomplete="false" size="25"
                                   accesskey="n"
                                   tabindex="1" name="username" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="color">
                            <input id="password" type="password" autocomplete="off" size="25"
                                   accesskey="p"
                                   tabindex="2" name="password" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <td class="color" align="center" colspan="2">
                            <input id="login_0" type="button" onclick="javascript:checkForm();" value="登录"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="bottom" align="center" colspan="2"></td>
                    </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        </tbody>
    </table>
</form>
</body>
</html>
