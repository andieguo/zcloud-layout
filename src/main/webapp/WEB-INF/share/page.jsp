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
<div class="page_btn clearFix">
	<span class="page_show">
		 当前页:第<font color="red">${pageView.currentpage}</font>页 |
			总记录数:<font color="red">${pageView.totalrecord}</font>条 | 每页显示:<font color="red">${pageView.maxresult}</font>条 |
			总页数:<font color="red">${pageView.totalpage}</font>页
	</span>
	<div class="btn-group">
		<a href="javascript:topage('${1}')" class="btn btn-default">首页</a> 
		<c:if test="${pageView.currentpage != 1}">
			<a href="javascript:topage('${pageView.currentpage-1}')" class="btn btn-default">上一页</a>
		</c:if>
		<c:if test="${pageView.currentpage != pageView.totalpage}"><a href="javascript:topage('${pageView.currentpage+1}')" class="btn btn-default">下一页</a></c:if>
		<a href="javascript:topage('${pageView.totalpage}')" class="btn btn-default">尾页</a>
		<span  class="btn btn-default">跳转到<input class="jump" name="jumppage"/>页</span>
		<a href="javascript:jumppage()" class="btn btn-default">跳转</a>
	</div>
</div>