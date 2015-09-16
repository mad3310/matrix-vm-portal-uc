<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.letv.com/util/url/encode" prefix="en" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,java.text.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + (request.getServerPort()==80?"":":"+request.getServerPort())
			+ path;
	int wrapThreshold = 100;
%>
<c:set var="basePath" value="<%=basePath%>" />
<c:if test="${isCibn }">
    <c:set var="channelNameField" value="cibnChannelName" />
</c:if>
<c:if test="${!isCibn }">
    <c:set var="channelNameField" value="channelName" />
</c:if>
<base href="${basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link href="<%=basePath%>/resources/script/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" >
<link href="<%=basePath%>/resources/script/easyui/themes/icon.css" rel="stylesheet" type="text/css" >
<link href="<%=basePath%>/resources/style/custom-easyui.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>/resources/style/subform.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>/resources/style/index.css" rel="stylesheet" type="text/css"/>

<script src="<%=basePath%>/resources/script/easyui/jquery.min.js" type="text/javascript"></script>
<script src="<%=basePath%>/resources/script/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<script src="<%=basePath%>/resources/script/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
<script src="<%=basePath%>/resources/script/subform.js" type="text/javascript"></script>

<!-- 修改base.js和base.css文件内容，修改相应的版本号，解决浏览器缓存问题 -->
<script type="text/javascript" src="${basePath}/scripts/common/base.js?ver=1.2"></script>
<script type="text/javascript">var ctx = "${ctx}";</script>