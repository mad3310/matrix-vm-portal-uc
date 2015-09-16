<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>邮件-重置密码</title>
    <style type="text/css">
        *{
            margin:0;
            padding:0;
        }
        img {
            margin:0;
            padding:0;
            border:0px;
        }
        body {
            font-size:12px;
            font-family:"微软雅黑";
        }
        .clear {
            width:0;
            clear:both;
            height: 0;
            margin: 0;
            padding: 0;
            border: 0;
        }
        a {
            text-decoration:none;
            font-family: Arial;
        }
        .emailBody{
            width: 900px;
            margin: 0 auto;
            padding: 0;
            box-sizing:border-box;
            border: 1px solid #bfbfbf;
            box-shadow: 0 5px 8px #999;
        }
        .email-header{
            height: 60px;
            width: auto;
            background: #053061;
        }
        .logo{
            float: left;
            margin-top: 12px;
            margin-left: 27px;
        }
        .logo h2,
        .logo a{
            width: auto;
            height: auto;
        }
        .logo img{
            width: 151px;
            height: 35px;
        }
        .phone{
            float: right;
            margin-top: 20px;
            margin-right: 30px;
            width: auto;
            height: auto;
        }
        .phone img{
            width: 16px;
            height: 17px;
            vertical-align: middle;
        }
        .phone span{
            font-size: 14px;
            color: #fff;
        }
        .email-content{
            padding: 30px;
            height: auto;
            width: 830px;
        }
        .email-content h2{
            padding-bottom: 10px;
            width: 100%;
        }
        .email-content h3{
            width: 100%;
        }
        .email-content h3 p,
        .email-content h2 span{
            color: #333;
            font-size: 12px;
            line-height: 25px;
        }
        .email-content h3 strong{
            font-size: 14px;
            color: #000;
            line-height: 25px;
        }
        .email-content h3 a{
            display: block;
            width: 830px;
            word-break:break-all;
            font-size: 12px;
        }
        .email-content a{
            font-size: 14px;
            color: #1073c2;
            line-height: 25px;
        }
        .email-content input{
            width: 150px;
            height: 40px;
            background: #1073c2;
            color: #fff;
            font-size: 14px;
            border: 0;
            outline: none;
            cursor: pointer;
            margin-top: 30px;
            margin-bottom: 40px;
            border-radius: 4%;
            -webkit-border-radius: 4%;
            -ms-border-radius: 4%;
            -o-border-radius: 4%;
            -moz-border-radius: 4%;
        }
        .email-footer{
            width: auto;
            height: 20px;
            margin: 80px auto;
            position: relative;
        }
        .email-footer h4{
            width: 144px;
            background: #fff;
            text-align: center;
            font-size: 14px;
            color: #333;
            position: absolute;
            left: 50%;
            top: -10px;
            margin-left: -72px;
        }
        .email-xian{
            width: 888px;
            height: 1px;
            margin: 0 auto;
            border: 1px dashed #aeaeae;
        }
    </style>
</head>
<body>
<div class="emailBody">
    <!-- 头部/S -->
    <div class="email-header clear">
        <div class="logo">
            <h1><a href=""><img src="http://static.letvcloud.com/uc/images/logo.png" alt="" /></a></h1>
        </div>
        <div class="phone">
            <img src="http://static.letvcloud.com/uc/images/iconfont-dianhua.png" alt="" />
            <span>400-055-6060</span>
        </div>
    </div>
    <!-- 头部/E -->
    <!-- 身体/S -->
    <div class="email-content clear">
        <h2>
            <span>亲爱的</span>
            <a href="">${currentUserEmail}</a>
            <span>，您好！</span>
        </h2>
        <h3>
            <strong style="display: inline;">您正在进行密码重置操作，</strong>
            <p style="display: inline;">若不是您本人的操作，请忽略此邮件。</p>
            <p>请点击下方按钮对密码进行重置：</p>
        </h3>
        <a href="${href}"><input type="button" nume="password" value="重置密码"/></a>
        <h3>
            <p>或点击以下链接重置密码：</p>
            <a href="${href}">${href}</a>
        </h3>
    </div>
    <!-- 身体/E -->
    <!-- 底部/S -->
    <div class="email-footer clear">
        <div class="email-xian"></div>
        <h4>系统邮件，请勿回复</h4>
    </div>
    <!-- 底部/E -->
</div>
</body>
</html>
