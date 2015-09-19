<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
      <div class="le-user-side" id="userside">
            <h4 class="title">用户中心</h4>
            <ul class="items clearfix">
                <li><a href="${ctx}/userView/ucOverview.do"><i
                        class="icon-nav-people"></i><span>用户中心概览</span></a></li>
                <li><a href="${ctx}/userView/accountManagerView.do"><i
                        class="icon-nav-manage"></i><span>账号管理</span></a></li>
               <!-- <li id="myservice">
                    <a href="javascript:;" id="noServer" ><i class="icon-nav-server"></i><span>我的服务</span></a>
                    <dl class="clearfix" id="userServer">
                       <dd><a href="#">云点播</a></dd>
                        <dd><a href="#">云直播</a></dd>
                        <dd><a href="#">CDN</a></dd>
                    </dl>
                    <em class="icon-dropdown-gary"></em>
                </li>-->
                <li><a href="${ctx}/uc/bill/getMonthBillView.do"><i class="icon-nav-bill"></i><span>我的账单</span></a>
                </li>
                <li><a href="${ctx}/userView/userKeyView.do"><i class="icon-nav-key"></i><span>用户私钥</span></a>
                </li>
                <li><a href="${ctx}/uc/invoice/getInvoiceSetingView.do"><i
                        class="icon-nav-invoice"></i><span>发票设置</span></a></li>
                <li><a href="${ctx}/messageView/msgCenterView.do"><i
                        class="icon-nav-message"></i><span>消息中心</span></a></li>
            </ul>
        </div>

<script type="text/javascript" src="http://static.uc.letvcloud.com/js/min/usercenterApp.js?t=20150421"></script>
 <script type="text/javascript">
  $ = jQuery = require("lib/jquery.min");//jquery
  require("lib/bootstrap.min");//modal
</script>

<script type="text/javascript">
 	var activeFlag = false;
    $(function () {
        $.ajax({
            type: "GET",
            url: "${ctx}/businessView/getUserServer.do",
            dataType: "JSON",
            success: function (data) {
                jStr=JSON.stringify(data);
                if(jStr=="{}"){
                    $("#noServer").attr("href","${ctx}/businessView/noServerView.do")
                }else{
                    var content="";
                    $.each(data,function(name,value) {

                        if(value=="100"){
                            content = content+"<dd id='l-1'><a href='"+"${ctx}/serviceOpen/showLive.do'>"+name+"</a></dd>";
                        }else if(value=="101"){
                            content = content+"<dd id='l-2'><a href='"+"${ctx}/serviceOpen/showVod.do'>"+name+"</a></dd>";
                        }else{
                            content = content+"<dd id='l-3'><a href='"+"${ctx}/serviceOpen/showCdn.do'>"+name+"</a></dd>";
                        }
                    });
                    $("#userServer").html(content);
                }
                changeLinkActive();

            },
            error:function(){
                changeLinkActive();
            }
        });
        //初始化左侧导航被点击状态
        var changeLinkActive=function(){
            var location = window.location.toString();
            location = location.substring(location.lastIndexOf("/"));
            //左侧导航a链接 循环匹配
            $("#userside .items a").each(function(){
                var href =$(this).attr("href");
                if(href.indexOf(location)>=0){
                    if($(this).parent().is("dd")){
                        $(this).addClass("active");
                        $(this).parent().parent().parent().addClass("active");
                        return false;
                    }else{
                        $(this).parent().addClass("active");
                        return false;
                    }
                }else{

                    if(location.indexOf("msgCenterDetailView")>=0&&href.indexOf("msgCenterView")>=0){
                        $(this).parent().addClass("active");
                        return false;
                    }
                    if(location.indexOf("fillMsgDiretView")>=0&&href.indexOf("accountManagerView")>=0){
                        $(this).parent().addClass("active");
                        return false;
                    }
                    if(location.indexOf("fillMsgView")>=0&&href.indexOf("accountManagerView")>=0){
                        $(this).parent().addClass("active");
                        return false;
                    }
                    if(location.indexOf("executeAuthen")>=0&&href.indexOf("accountManagerView")>=0){
                        $(this).parent().addClass("active");
                        return false;
                    }
                    if(location.indexOf("fillMsgView")>=0&&href.indexOf("accountManagerView")>=0){
                        $(this).parent().addClass("active");
                        return false;
                    }
                    if(location.indexOf("executeAuthenView")>=0&&href.indexOf("accountManagerView")>=0){
                        $(this).parent().addClass("active");
                        return false;
                    }
                    if(location.indexOf("authenSuccess")>=0&&href.indexOf("accountManagerView")>=0){
                        $(this).parent().addClass("active");
                        return false;
                    }

                }
            });
        };
        //我的服务下a链接点击不关闭 其父类
//        $("#myservice").on("click","#userServer a",function(){
//            $("#myservice").addClass("active");
//        });
    });

    //function activeA(){
	  /* $("ul a").each(function(){
		  $(this).parent().removeClass("active");
	  });
	  $(t).addClass("active"); */

	 /*  $(".icon-dropdown-gary").trigger("click"); */
  //}

</script>


