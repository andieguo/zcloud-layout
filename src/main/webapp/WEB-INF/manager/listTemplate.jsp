<%@ page language="java" contentType="text/html; charset=utf-8" import="com.zonesion.layout.model.AdminEntity" isELIgnored="false"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="zh-CN">
<head>
	<title>模板列表</title>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
	<spring:url value="/template/list" var="userActionUrl" />
	<form:form class="h100" method="post" modelAttribute="templateForm" action="${userActionUrl}">
		<form:hidden path="page" />
		<form:hidden path="id" />
		<form:hidden path="deleted" />
		<form:hidden path="type" />
		<header class="table-header clearfix">
			<div class="header-right">
          			 <a class="font-green" href="${basePath }/template/addUI?type=${templateForm.type}" target="_blank">新建</a>
    			</div>
			<div class="header-left">
				<label>用户：</label> 
				<form:input path="nickname"/>
	            <label>模板名</label>
	            <form:input path="name"/>
				<label>启/停用：</label>
				<form:select path="visible" items="${enableList}" class="form-control" />
				<a href="javascript:queryAction()" class="font-green" href="#">搜索</a>
			</div>
		</header>
	    <div class="table-body">
	        <table class="table table-striped">
				<thead>
					<tr>
					    <th>id</th>
						<th>模板名</th>
						<th>用户名</th>
						<th>模板类型</th>
						<th>创建时间</th>
						<th>修改时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageView.records}" var="entry">
						<tr>
						    <td>${entry.id }</td>
							<td>${entry.name }</td>
							<td>${entry.nickname }</td>
							<td>
								<c:if test="${entry.type==0}">系统模板</c:if>
								<c:if test="${entry.type==1}">用户模板</c:if>
							</td>
							<td>${entry.createTime }</td> 
							<td>${entry.modifyTime }</td> 
							<td>
								<a href="${basePath}/template/editUI?id=${entry.id}" target="_blank" class="font-green">查看</a>
								<a href="${basePath}/template/editUI?id=${entry.id}" target="_blank" class="font-green">修改</a>
								<a href="javascript:deleteAction(${entry.id},${entry.visible==0?1:0},${entry.type})" class="font-red">
									<c:if test="${entry.visible==1}">启用</c:if>
									<c:if test="${entry.visible==0}">停用</c:if>
								</a>
							</td>   
		      			</tr>
		      		</c:forEach>
				<tbody>
				 <tfoot>
	       			<%@ include file="/WEB-INF/share/page.jsp" %>
				</tfoot>
	        </table>
	    </div>
	</form:form>
</section>

<!---------------------------脚本引用------------------------------>
		<%@ include file="/resources/share/script.jsp"%>
		<script language="JavaScript">
			function queryAction(){
				var form = document.forms[0];
				document.getElementById("page").value = 1;
				form.submit();
			}
			function modifyAction(id){
				var form = document.forms[0];
				form.action="${basePath}/template/editUI";
				form.method = "get";
				document.getElementById("id").value = id;
				form.submit();
			}
			function deleteAction(id,status,type){
				var form = document.forms[0];
				form.action="${basePath}/template/delete";
				document.getElementById("id").value = id;
				document.getElementById("type").value = type;
				document.getElementById("deleted").value= status;
				form.submit();
			}
		</script>
</body>
</html>