<%@ page language="java" contentType="text/html; charset=utf-8" import="com.zonesion.layout.model.AdminEntity" isELIgnored="false"%>
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
<script src="${basePath }/resources/js/jquery2.2.1.min.js"></script>
<script src="${basePath }/resources/js/script.js"></script>
</head>
<body>
	<section class="main content">
	    <%
	    	HttpSession sessions = request.getSession();
	    	AdminEntity admin = (AdminEntity)sessions.getAttribute("admin");
    	%>
		<spring:url value="/admin/list" var="userActionUrl" />
		<form:form class="form-horizontal" method="post" modelAttribute="listForm" action="${userActionUrl}">
			<form:hidden path="page" />
			<form:hidden path="id" />
			<form:hidden path="deleted" />
			<header class="table-header clearfix">
				<div class="header-left">
					<c:if test="${admin.role==0}">
						<label>角色：</label>
						<form:select path="role" items="${roleList}" class="form-control" />
					</c:if>
					<label>启/停用：</label>
					<form:select path="visible" items="${enableList}" class="form-control" />
					<a href="javascript:queryAction()" class="font-green" href="#">搜索</a>

				</div>
				<div class="header-right">
					<from class="search"> <input type="text">
					<button class="icon" type="submit"></button>
					</from>
				</div>
			</header>
			<div class="table-body">
				<table>
					<thead>
						<tr>
							<th>用户名</th>
							<th>姓名</th>
							<th>手机</th>
							<th>角色</th>
							<th>创建时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pageView.records}" var="entry">
							<tr>
								<td>${entry.nickname }</td>
								<td>${entry.email }</td>
								<td>${entry.phoneNumber }</td>
								<td>
									<c:if test="${entry.role==0}">管理员</c:if> 
									<c:if test="${entry.role==1}">用户</c:if>
								</td>
								<td>${entry.createTime }</td>
								<td><a class="font-green" href="javascript:modifyAction(${entry.id})">修改</a> 
									<a class="font-red" href="javascript:deleteAction(${entry.id},${entry.visible==0?1:0})">
										<c:if test="${entry.visible==1}">
											启用
										</c:if> <c:if test="${entry.visible==0}">
											停用
										</c:if>
									</a>
								</td>
							</tr>
						</c:forEach>
					<tbody>
					<%@ include file="/WEB-INF/share/page.jsp"%>
				</table>
			</div>
		</form:form>
		<!---------------------------脚本引用------------------------------>
		<%@ include file="/resources/share/script.jsp"%>
	</section>
	<script language="JavaScript">
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