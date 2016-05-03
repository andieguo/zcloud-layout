<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<title>管理员列表</title>
		<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!---------------------------样式引用------------------------------>
		<%@ include file="/resources/share/style_backstage.jsp"%>
	</head>

	<body>
		<div class="content_box">
				<spring:url value="/admin/list" var="userActionUrl" />
				<form:form class="form-horizontal" method="post" modelAttribute="listForm" action="${userActionUrl}">
				<form:hidden path="page" />
				<form:hidden path="id" />
				<form:hidden path="deleted"/>
			  	<div class="new_btn">
					<!---------------------------查询------------------------------>
					<div class="seach_box">
						<c:if test="${entry.role==0}">
							<label>角色：</label> 
		              		<form:select path="role" items="${roleList}" class="form-control" />
		              	</c:if>
						<label>启/停用：</label>
						<form:select path="visible" items="${enableList}"  class="form-control" />
						<a href="javascript:queryAction()" style="float:left;"><i class="glyphicon glyphicon-search"></i>查询</a>
					</div>
				</div>
			    <table class="table table-striped">
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
								<td>
									<a href="javascript:modifyAction(${entry.id})"><i class="glyphicon glyphicon-edit">[修改]</i></a>
									<a href="javascript:deleteAction(${entry.id},${entry.visible==0?1:0})">
										<c:if test="${entry.visible==1}"><i class="glyphicon glyphicon-expand">[启用]</i></c:if>
										<c:if test="${entry.visible==0}"><i class="glyphicon glyphicon-unchecked">[停用]</i></c:if>
									</a>
								</td>   
			      			</tr>
			      		</c:forEach>
					<tbody>
			    </table>
				<%@ include file="/WEB-INF/share/page.jsp" %>
			    </form:form>
		</div>
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
				form.action="${basePath}/admin/editUI";
				document.getElementById("id").value = id;
				form.submit();
			}
			function deleteAction(id,status){
				var form = document.forms[0];
				form.action="${basePath}/admin/delete";
				document.getElementById("id").value = id;
				document.getElementById("deleted").value= status;
				form.submit();
			}
		</script>
	</body>
</html>