<%@ page language="java" contentType="text/html; charset=utf-8" import="com.zonesion.layout.model.AdminEntity,com.zonesion.layout.util.Constants" isELIgnored="false"%>
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
	<spring:url value="/template/list" var="userActionUrl" />
	<form:form class="h100" method="post" modelAttribute="templateForm" action="${userActionUrl}">
		<%@ include file="/WEB-INF/share/msg.jsp"%>
		<form:hidden path="page" />
		<form:hidden path="id" />
		<form:hidden path="deleted" />
		<form:hidden path="type" />
		<header class="table-header clearfix">
			<c:set var="SYSTEMTEMPLATE" value="<%=Constants.SYSTEMTEMPLATE %>"></c:set>
			<c:set var="USERTEMPLATE" value="<%=Constants.USERTEMPLATE %>"></c:set>
			<c:set var="USER" value="<%=Constants.USER %>"></c:set>
			<c:set var="ADMIN" value="<%=Constants.ADMIN %>"></c:set>
			<c:set var="SUPERADMIN" value="<%=Constants.SUPERADMIN %>"></c:set>
			<!-- 1、用户模板，所有角色都可以创建 -->
			<c:if test="${templateForm.type == USERTEMPLATE}">
				<div class="header-right">
	          		<a class="font-green" href="${basePath }/template/addUI?type=${templateForm.type}" target="_blank">新建</a>
	    		</div>
    		</c:if>
    		<!-- 2、系统模板，管理员和超级管理员可以创建 -->
    		<c:if test="${templateForm.type == SYSTEMTEMPLATE}">
				<c:if test="${admin.role == ADMIN || admin.role == SUPERADMIN}">
					<div class="header-right">
		          		<a class="font-green" href="${basePath }/template/addUI?type=${templateForm.type}" target="_blank">新建</a>
		    		</div>
				</c:if>
    		</c:if>
			<div class="header-left">
				<!-- 1、用户模块，管理员和用户只能查看自己的模板，系统管理员可以查看所有用户模板-->
				<c:if test="${templateForm.type == USERTEMPLATE}">
					<c:if test="${admin.role == SUPERADMIN}">
						<label>用户：</label> 
						<form:input path="nickname"/>
					</c:if>
				</c:if>
				<!-- 2、系统模板，所有用户都能查看系统模板 -->
				<c:if test="${templateForm.type == SYSTEMTEMPLATE}">
					<label>用户：</label> 
					<form:input path="nickname"/>
				</c:if>
	            <label>模板名：</label>
	            <form:input path="name"/>
				<label>启/停用：</label>
				<form:select path="visible" items="${enableList}" class="form-control" />
				<a href="javascript:queryAction()" class="font-green" >搜索</a>
				<!-- 1、用户模板，所有角色都可以删除自己的模板 -->
				<c:if test="${templateForm.type == USERTEMPLATE}">
					<a href="javascript:deleteAction()" class="font-green" href="#">批量删除</a>
					<input type="file" id="templateFile" name="templateFile" size="50" /><a href="javascript:importAction()" class="font-green" >导入</a>
				</c:if>
				<!-- 2、系统模板，管理员和超级管理员可以批量删除-->
    			<c:if test="${templateForm.type == SYSTEMTEMPLATE}">
    				<c:if test="${admin.role == ADMIN || admin.role == SUPERADMIN}">
						<a href="javascript:deleteAction()" class="font-green" href="#">批量删除</a>
						<input type="file" id="templateFile" name="templateFile" size="50" /><a href="javascript:importAction()" class="font-green" >导入</a>
					</c:if>
				</c:if>
			</div>
		</header>
	    <div class="table-body">
	        <table class="table table-striped">
				<thead>
					<tr>
						<th>
							<c:if test="${admin.role == USER}">
				    			<input  title="全选" type="checkbox" disabled="true"/>
			    			</c:if>
			    			<c:if test="${admin.role != USER}">
			    				<input name="chkAll" id="chkAll" title="全选" onClick="ChkAllClick('keyIds','chkAll')" type="checkbox" />
			    			</c:if>
							ID
						</th>
						<th>模板名</th>
						<th>用户名</th>
						<th>模板类型</th>
						<th>创建时间</th>
						<th>修改时间</th>
						<th>操作</th>
						<th>状态</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageView.records}" var="entry">
						<tr visible="${entry.visible==0?1:0}">
							<td>
								<!-- 1、用户模板，所有角色都可以删除自己的模板 -->
								<c:if test="${templateForm.type == USERTEMPLATE}">
									<input name="keyIds" type="checkbox"  value='${entry.id}' onclick="ChkSonClick('keyIds','chkAll')" />
								</c:if>
								<!-- 2、系统模板，管理员可以批量删除自己的系统模板-->
				    			<c:if test="${templateForm.type == SYSTEMTEMPLATE}">
					    			<c:if test="${admin.role == USER}">
										<input type="checkbox" disabled="true"/>
					    			</c:if>
				    				<c:if test="${admin.role == ADMIN}">
				    					<c:if test="${admin.nickname != entry.nickname }">
											<input  type="checkbox" disabled="true"/>
										</c:if>
										<c:if test="${admin.nickname == entry.nickname }">
											<input name="keyIds" type="checkbox"  value='${entry.id}' onclick="ChkSonClick('keyIds','chkAll')"/>
										</c:if>
									</c:if>
									<!-- 3、系统模板，超级管理员可以批量删除所有系统模板-->
									<c:if test="${admin.role == SUPERADMIN}">
										<input name="keyIds" type="checkbox"  value='${entry.id}' onclick="ChkSonClick('keyIds','chkAll')"/>
									</c:if>
								</c:if>
								<tt>${entry.id }</tt>
							</td>
							<td>${entry.name }</td>
							<td>${entry.nickname }</td>
							<td>
								<c:if test="${entry.type == SYSTEMTEMPLATE}">系统模板</c:if>
								<c:if test="${entry.type == USERTEMPLATE}">用户模板</c:if>
							</td>
							<td>${entry.createTime }</td> 
							<td>${entry.modifyTime }</td> 
							<td>
								<a href="${basePath}/template/viewUI?id=${entry.id}" target="_blank" class="font-green">查看</a>
								<!-- 1、管理员和用户只能修改自己的系统模板 -->
								<c:if test="${admin.role == ADMIN || admin.role == USER}">
									<c:if test="${admin.nickname == entry.nickname }">
										<a href="${basePath}/template/editUI?id=${entry.id}" target="_blank" class="font-green">修改</a>
										<a href="javascript:enableAction(${entry.id},${entry.type})" id="enable_${entry.id }" class="state-text font-red" visible="${entry.visible==0?1:0}">
											<c:if test="${entry.visible==0}">启用</c:if>
											<c:if test="${entry.visible==1}">停用</c:if>
										</a>
									</c:if>
								</c:if>
								<!-- 2、超级管理员能修改所有模板 -->
								<c:if test="${admin.role == SUPERADMIN}">
									<a href="${basePath}/template/editUI?id=${entry.id}" target="_blank" class="font-green">修改</a>
									<a class="state-text font-red">
										<c:if test="${entry.visible==0}">启用</c:if>
										<c:if test="${entry.visible==1}">停用</c:if>
									</a>
								</c:if>
								<a href="${basePath}/template/export?id=${entry.id}" class="font-green">导出</a>
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
<script src="<%=basePath %>/resources/js/checkbox.js" type="text/javascript"></script>
<script language="JavaScript">
	$(function(){
		stateColor();
		stateImage();
		enableAction("${basePath}/template/enable");//使能project
	});
	function importAction(){
		var templateFile = $("#templateFile").val();
		if(templateFile != ""){
			var form = document.forms[0];
			form.action="${basePath}/template/import?type=${templateForm.type}";
			form.enctype="multipart/form-data";
			form.submit();
		}else{
			alert("导入文件不能为空!");
			return;
		}
	}
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
	function deleteAction(){
		var value=0;
		$("input[name='keyIds']").each(function () {
			if(this.checked){
				var form = document.forms[0];
				form.action="${basePath}/template/delete";
				form.submit();
				value=1;
			}
		});
		if(!value){alert("请选择删除项");};
	}
</script>
</body>
</html>