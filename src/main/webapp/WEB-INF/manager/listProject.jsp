<%@ page language="java" contentType="text/html; charset=utf-8" import="com.zonesion.layout.model.AdminEntity" isELIgnored="false"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="zh-CN">
<head>
	<title>项目列表</title>
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
	<spring:url value="/project/list" var="userActionUrl" />
	<form:form class="h100"  method="post" modelAttribute="projectForm" action="${userActionUrl}">
		<form:hidden path="page" />
		<form:hidden path="id" />
		<form:hidden path="deleted" />
		<header class="table-header clearfix">
			<div class="header-right">
	         	<a class="font-green" href="${basePath }/project/addUI?type=${templateForm.type}" target="_blank">新建</a>
	   		</div>
			<div class="header-left">
				<label>用户：</label> 
				<form:input path="nickname"/>
	            <label>模板名</label>
	            <form:input path="templatename"/>
	            <label>项目名</label>
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
							<th>项目ID</th>
							<th>项目名</th>
							<th>项目管理员</th>
							<th>模板</th>
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
									${entry.templatename }
								</td>
								<td>${entry.createTime }</td> 
								<td>${entry.modifyTime }</td> 
								<td>
								    <a href="${basePath }/project/publish?id=${entry.id}" class="font-green" target="_blank">发布</a>
									<a href="javascript:modifyAction(${entry.id})" class="font-green">修改</a>
									<a href="javascript:deleteAction(${entry.id},${entry.visible==0?1:0})" class="font-red">
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
				form.action="${basePath}/project/editUI";
				form.method = "get";
				document.getElementById("id").value = id;
				form.submit();
			}
			function deleteAction(id,status){
				var form = document.forms[0];
				form.action="${basePath}/project/delete";
				document.getElementById("id").value = id;
				document.getElementById("deleted").value= status;
				form.submit();
			}
		</script>
</body>
</html>