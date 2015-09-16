<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="head-b.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="http://static.uc.letvcloud.com/css/min/zhiboApp.css"/>

<jsp:include page="header-e.jsp"></jsp:include>
<!--head/E-->
<!--title/S-->
<h1 class="title-zhuce"><p>云直播服务开通</p><p><span class="line"></span></p></h1>
<!--title/E-->
<!--main /S-->
<div class="comwidth clearfix">
	<div class="zhibo-con border-bottom  clearfix">
		<p class="title">基础服务<i class="icon-arrow"></i></p>
		<ul class="con01 clearfix">
			<li><span class="icon-tag-arrow tags">存储</span><span class="info">空间：不限</span><span class="info">费用：推广期免费</span></li>
			<li><span class="icon-tag-arrow tags">转码</span><span class="info">时间：不限</span><span class="info">费用：推广期免费</span></li>
			<li><span class="icon-tag-arrow tags">播放器</span><span class="info">数量：不限</span><span class="info">费用：推广期免费</span></li>
			<li><span class="icon-tag-arrow tags">平台服务费</span><span class="info">费用：推广期免费</span><span class="info">费用：推广期免费</span></li>
		</ul>
	</div>
	<div class="zhibo-con border-bottom  clearfix">
		<p class="title">CDN计费<i class="icon-arrow"></i></p>
		<dl class="cdn-info pull-left clearfix">
			<dt class="clearfix">
			<ul id="cdnTab" class="cdntags clearfix">
				<li class="active" value="001"><a href="#liuliangInfo">按流量<i class="arrow"></i></a></li>
				<li value="002"><a class="" href="#daikuanInfo">按宽带<i class="arrow"></i></a></li>
			</ul>
			</dt>
			<dd class="tab-content clearfix">
				<p class="tab-pane active" id="liuliangInfo">资费：月使用流量？G以下免费，？G以上0.1元/G起</p>
				<p class="tab-pane" id="daikuanInfo">资费：月使用流量？G以下免费，100G以上0.1元/G起</p>
			</dd>
		</dl>
		<div class="cdn-more pull-left">
			<p class="link-red"><a href="#">详细计费规则 ></a></p>
			<p class="link-red"><a href="#">联系商务了解更多计费方式 ></a></p>
		</div>
	</div>
	<div class="zhibo-con border-bottom  clearfix">
		<p class="title">增值服务<i class="icon-arrow"></i></p>
		<ul class="zengzhi-con clearfix">
			<li class="title">
				<span class="wid230">增值服务项 </span><span class="wid370">资费</span>
			</li>
			<li>
				<span class="wid230">去广告</span><span class="wid370">推广期免费</span>
			</li>
			<li>
				<span class="wid230">logo去水印</span><span class="wid370">推广期免费</span>
			</li>
			<li>
				<span class="wid230">视频门户推广</span><span class="wid370">推广期免费</span>
			</li>
		</ul>
	</div>
	<div class="btn-zhibo  clearfix"><a id="btnOpenService" href="#" class="btn-primary btn-xxl">开通服务</a></div>
</div>
<!--main /E-->
<!-- 引入底部foot-->
<!-- footer/S-->
<jsp:include page="footerdiv.jsp"></jsp:include>
<!-- footer/E-->
<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/tagApp.js"></script>
<script type="text/javascript">
	$=require("lib/jquery.min");
	$(function(){
		$("#btnOpenService").click(
				function(){
					var url = '/serviceOpen/openLiveConfirm.do';
					var feeCodeNow=$("#cdnTab li.active").attr("value");
					window.location.href=url+'?feeCodeNow='+feeCodeNow;
				}
		);
	})
</script>

</body>
</html><!-- file tree:
|...yunzhibo-liuliang.html
|   |...header-zhibo.html
|   |...footer.html
- By MOKTEXT. -->