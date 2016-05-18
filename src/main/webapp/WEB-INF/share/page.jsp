<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script language="JavaScript">
	//到指定的分页页面
	function topage(page) {
		var form = document.forms[0];
		form.page.value = page;
		form.submit();
	}
	function jumppage() {
		var form = document.forms[0];
		form.page.value = form.jumppage.value;
		form.submit();
	}
</script>
<div class="left">
	当前页：第<span class="font-red">${pageView.currentpage}</span>页&nbsp;&nbsp;|&nbsp;&nbsp;
	总记录数：<span class="font-red">${pageView.totalrecord}</span>条&nbsp;&nbsp;|&nbsp;&nbsp;
	每页显示：<span class="font-red">${pageView.maxresult}</span>条&nbsp;&nbsp;|&nbsp;&nbsp;
	总页数：<span class="font-red">${pageView.totalpage}</span>页
</div>
<div class="right">
	<a href="javascript:topage('${1}')">首页</a>
	<c:if test="${pageView.currentpage != 1}">
		<a href="javascript:topage('${pageView.currentpage-1}')">上一页</a>
	</c:if>
	<c:if test="${pageView.currentpage != pageView.totalpage}">
		<a href="javascript:topage('${pageView.currentpage+1}')">下一页</a>
	</c:if>
	<a href="javascript:topage('${pageView.totalpage}')">尾页</a>
	跳转到<input name="jumppage"/>页<a href="javascript:jumppage()">跳转</a>
</div>