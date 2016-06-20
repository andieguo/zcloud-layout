<%@ page language="java" contentType="text/html; charset=utf-8" import="com.zonesion.layout.model.AdminEntity,com.zonesion.layout.util.Constants" isELIgnored="false"%>
<%@ include file="/WEB-INF/share/taglib.jsp"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>智云组态仿真软件</title>
<link rel="stylesheet" href="${basePath }/resources/css/style.css">
<%@ include file="/resources/share/script.jsp"%>
<script src="${basePath }/resources/js/form.js"></script>
<script src="${basePath }/resources/js/list.js"></script>
</head>
<body>
	<section class="main content">
	    <%
	    	HttpSession sessions = request.getSession();
	    	AdminEntity admin = (AdminEntity)sessions.getAttribute("admin");
    	%>
		<c:set var="USER" value="<%=Constants.USER %>"></c:set>
		<c:set var="ADMIN" value="<%=Constants.ADMIN %>"></c:set>
		<c:set var="SUPERADMIN" value="<%=Constants.SUPERADMIN %>"></c:set>
		<spring:url value="/admin/list" var="userActionUrl" />
		<form:form class="h100" method="post" modelAttribute="listForm" action="${userActionUrl}">
			<%@ include file="/WEB-INF/share/msg.jsp"%>
			<form:hidden path="page" />
			<form:hidden path="id" />
			<form:hidden path="deleted" />
			<header class="table-header clearfix">
				<div class="header-left">
					<label>用户名：</label>
					<form:input path="nickname"/>
					<c:if test="${admin.role==ADMIN || admin.role == SUPERADMIN}">
						<label>角色：</label>
						<form:select path="role" items="${roleList}" class="form-control" />
					</c:if>
					<label>启/停用：</label>
					<form:select path="visible" items="${enableList}" class="form-control" />
					<a href="javascript:queryAction()" class="font-green" href="#">搜索</a>
				</div>
			</header>
			<div class="table-body">
				<table>
					<thead>
						<tr>
						    <th>用户ID</th>
							<th>用户名</th>
							<th>姓名</th>
							<th>手机</th>
							<th>角色</th>
							<th>创建时间</th>
							<c:if test="${admin.role==SUPERADMIN}">
								<th>操作</th>
							</c:if>
							<th>状态</th>
						</tr>
					</thead>
					<tbody>

						<c:forEach items="${pageView.records}" var="entry">
							<tr visible="${entry.visible==1?0:1}">
								<td><tt>${entry.id }</tt></td>
								<td>${entry.nickname }</td>
								<td>${entry.email }</td>
								<td>${entry.phoneNumber }</td>
								<td>
									<c:if test="${entry.role==ADMIN}">管理员</c:if> 
									<c:if test="${entry.role==USER}">用户</c:if>
									<c:if test="${entry.role==SUPERADMIN}">超级管理员</c:if>
								</td>
								<td>${entry.createTime }</td>
								<td>
									
									<c:if test="${admin.role==SUPERADMIN}">
										<a class="font-green" href="javascript:modifyAction(${entry.id})">修改</a>
										<a class="state-text font-red">
											<c:if test="${entry.visible==0}">启用</c:if>
											<c:if test="${entry.visible==1}">停用</c:if>
										</a>
									</c:if>
								</td>
								<td><i class="state-image state-on"></i></td> 
							</tr>
						</c:forEach>
					<tbody>
					<tfoot>
						<tr>
							<td colspan="8">
       						<%@ include file="/WEB-INF/share/page.jsp" %>
					    	</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</form:form>
	</section>
<!---------------------------脚本引用------------------------------>
<script language="JavaScript">
	$(function(){
		stateColor();
		stateImage();
		enableAction("${basePath}/admin/enable");//使能project
	});
	function queryAction() {
		var form = document.forms[0];
		document.getElementById("page").value = 1;
		form.submit();
	}
	function modifyAction(id) {
		var form = document.forms[0];
		form.action = "${basePath}/admin/editUI";
		document.getElementById("id").value = id;
		form.submit();
	}
	//删除用户--目前未使用
	function deleteAction(id, status) {
		var form = document.forms[0];
		form.action = "${basePath}/admin/delete";
		document.getElementById("id").value = id;
		document.getElementById("deleted").value = status;
		form.submit();
	}
</script>
</body>
</html>