<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../common/include.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>首页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript">
    </script>
</head>
<body style="width: 98%">
<%--  <div class="easyui-panel" style="width:800px;padding:5px;">
     <div id="p_alarm" class="easyui-panel" title="最近一天的系统预报警" style="width:790px;height:370px;padding:0px;"
             data-options="iconCls:'icon-validatebox_warning',collapsible:true,
             tools:[
                {
                    iconCls:'icon-reload',
                    handler:function(){
                         $('#alarm').attr('src', '<%=basePath%>alert/alertLogWidget');
                    }
                 },
                 {
                    iconCls:'icon-search',
                    handler:function(){
                         parent.addTab('预报警日志查询','<%=basePath%>alert/open','10351000',true);
                    }
                 }
             ],
             onOpen:function() {
                 $('#alarm').attr('src', '<%=basePath%>alert/alertLogWidget');
             }
             ">
          <iframe id="alarm" scrolling="auto"  frameborder="0" style="width:99%;height:99.4%;margin: 0;border: 0 none #FFFFFF; background-color:#FFFFFF;"></iframe>
     </div>
     </br> --%>
<%@ include file="/WEB-INF/views/framework/todoList.jsp" %>
<!--
<div class="easyui-panel" title="使用帮助" style="width:790px;height:370px;padding:0px;"
        data-options="iconCls:'icon-validatebox_warning',collapsible:true">
    <span style="font-size:14px;font-weight:bold;">打点录制</span></br>
    &nbsp;&nbsp;&nbsp;1、录制问题,请与甘霖(手机:15923973820,邮箱:ganlin@letv.com)联系</br>
    &nbsp;&nbsp;&nbsp;2、转码问题,请与云转码王孝庆(手机:18539343636,邮箱:wangxiaoqing@letv.com)联系</br>
</div>
-->
<!--
        <div id="p_todo" class="easyui-panel" title="待办事项" style="width:790px;height:200px;padding:5px;"
                data-options="iconCls:'icon-edit',collapsible:true,
                tools:[{
                    iconCls:'icon-reload',
                    handler:function(){
                        $('#todo').attr('src', '<%=basePath%>framework/todos');
                    }
                }],
                onOpen:function() {
                    $('#todo').attr('src', '<%=basePath%>framework/todos');
                }
                ">
            <iframe id="todo" scrolling="auto"  frameborder="0" style="width:99%;height:99.4%;margin: 0;border: 0 none #FFFFFF; background-color:#FFFFFF;"></iframe>
        </div>
        <div id="p_notice" class="easyui-panel" title="系统通知" style="width:790px;height:200px;padding:5px;"
                data-options="iconCls:'icon-tip',collapsible:true,
                tools:[{
                    iconCls:'icon-reload',
                    handler:function(){
                        $('#notice').attr('src', '<%=basePath%>framework/notices');
                    }
                }],
                onOpen:function() {
                    $('#notice').attr('src', '<%=basePath%>framework/notices');
                }
                ">
             <iframe id="notice" scrolling="auto"  frameborder="0" style="width:99%;height:99.4%;margin: 0;border: 0 none #FFFFFF; background-color:#FFFFFF;"></iframe>
        </div>
     </div> -->
</body>
</html>
