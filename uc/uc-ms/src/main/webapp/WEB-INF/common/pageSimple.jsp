<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table width="100%">
    <tr>
        <td class="out">
            <div class="paging" style="float:right">
                <c:choose>
                    <c:when test="${currentPage > 0}">
                        <a href="#" class="sbmt_btn" action="${baseurl}?${pageId}=0">首页</a>
                        <a href="#" class="sbmt_btn" action="${baseurl}?${pageId}=${currentPage-1}">上一页</a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:void(0)" disabled="true">首页</a>
                        <a href="javascript:void(0)" disabled="true">上一页</a>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${currentPage<5}">
                        <c:set var="pageloopstart" value="1"/>
                        <c:set var="pageloopend" value="10"/>
                    </c:when>
                    <c:when test="${currentPage>5}">
                        <c:set var="pageloopstart" value="${currentPage-5}"/>
                        <c:set var="pageloopend" value="${currentPage+4}"/>
                    </c:when>
                </c:choose>
                <c:if test="${currentPage>5}">
                    <a href="#" class="sbmt_btn" action="${baseurl}?${pageId}=${currentPage-6}">...</a>
                </c:if>
                <c:forEach begin="${pageloopstart}" end="${pageloopend}" step="1" varStatus="vs">
                    <c:choose>
                        <c:when test="${vs.index == currentPage+1}"> ${vs.index}</c:when>
                        <c:otherwise>
                            <a href="#" class="sbmt_btn" action="${baseurl}?${pageId}=${vs.index-1}">${vs.index}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <a href="#" class="sbmt_btn" action="${baseurl}?${pageId}=${currentPage+1}">下一页</a>
                &nbsp;&nbsp;
                跳转到第
                <input type="text" id="${pageId}" name="${pageId}" class="text" value="${currentPage+1}" style="width:20px" size="3"/>
                页
                <input type="button" id="goButton" value="GO" action="${baseurl}" />
                &nbsp;每页显示
                <select name="fetchSize" class="select" style="width:60px" id="pageSizeSelect">
                    <option value="10">10条</option>
                    <option value="20">20条</option>
                    <option value="50">50条</option>
                    <option value="100">100条</option>
                </select>
            </div>
        </td>
    </tr>
</table>
<script type="text/javascript" language="javascript">
    //每页显示多少行变化     
    $("#pageSizeSelect").change(function(){
        pageSize = $(this).val();
        $("#pageSize").val(pageSize);
        $("#formId").attr("action", "${baseurl}?rePageSize=1&${pageId}=0");
        $("#formId").submit();
    });
    
    $("#goButton").click(function(){
        var pageNoStr = $("#${pageId}").val();
        pageNo1 = parseInt(pageNoStr);
        if (isNaN(pageNo1)) {
            alert('页码必须为数字');
            return;
        }
        
        var pageNo = pageNo1 - 1;
        if (pageNo < 0) {
            alert("页码不能小于0");
            return;
        }
        
        $("#formId").attr("action", "${baseurl}?${pageId}=" + pageNo);
        $("#formId").submit();
    });
</script>
