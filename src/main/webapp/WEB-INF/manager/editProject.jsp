<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
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
</head>
<body>
	<section class="main">
    	<%@ include file="/WEB-INF/share/notice.jsp" %>
	    <div class="content sw">
	        <div class="panel">
				<spring:url value="/project/edit" var="userActionUrl" />
				<form:form method="post" modelAttribute="editForm" action="${userActionUrl}">
						<form:hidden path="id" />
						<form:hidden path="tid"/>
						<form:hidden path="macList"/>
						<form:hidden path="imageUrl"/>
						<spring:bind path="name">
							<div class="form-group">
								<label for="name">项目名：</label>
								<input id="name" name="name" value="${status.value}" type="text" placeholder="请输入账号" >
								<form:errors path="name" cssClass="error" />
							</div>
						</spring:bind>
						<div class="form-group">
							<label for="imageSrc">项目图片：</label>
							<img class="pic" alt="" id="imageSrc" name="imageSrc" src="${basePath }/photo/${editForm.imageUrl}" >
							<a class="btn" href="javascript:loadImg('${basePath}')">请选择图片</a>
						</div>
						<spring:bind path="titleContent">
						<div class="form-group">
							<label for="titleContent">项目头详细信息：</label>
							<textarea rows="2" cols="1" id="titleContent" name="titleContent" placeholder="请输入项目头详细信息">${status.value}</textarea>
						</div>
						</spring:bind>
						<spring:bind path="footContent">
							<div class="form-group">
								<label for="footContent">项目尾详细信息：</label>
								<input id="footContent" name="footContent"  value="${status.value}" type="text" placeholder="请输入项目尾详细信息" >
							</div>
						</spring:bind>
						<spring:bind path="zcloudID">
							<div class="form-group">
								<label for="zcloudID">智云ID：</label>
		              			<input type="text" id="zcloudID" name="zcloudID" value="${status.value}" placeholder="请输入邮箱地址" />
								<form:errors path="zcloudID" cssClass="error" />
							</div>
						</spring:bind>
					   	<spring:bind path="zcloudKEY">
							<div class="form-group">
								<label for="zcloudKEY">智云KEY：</label>
		              			<input type="text" id="zcloudKEY" name="zcloudKEY" value="${status.value}"  placeholder="请输入邮箱地址" />
								<form:errors path="zcloudKEY" cssClass="error" />
							</div>
						</spring:bind>
						<spring:bind path="serverAddr">
							<div class="form-group">
								<label for="serverAddr">智云Server：</label>
		              			<input type="text" id="serverAddr" name="serverAddr" value="${status.value}"  placeholder="请输入邮箱地址" />
								<form:errors path="serverAddr" cssClass="error" />
							</div>
						</spring:bind>
						<div class="form-group">
							<label for="textMacList">智云Mac：</label>
							<textarea rows="6" cols="20" class="form-control" id="textMacList" name="textMacList"></textarea>
							<form:errors path="macList" />
						</div>
			            
						<div class="form-button">
		                    &nbsp;<a class="btn submit" href="javascript:editAction()">修改</a>
		                </div>
				</form:form>
	            <!-- /修改用户资料 -->
	            <div class="altContent-shell hide">
            		<i class="icon icon-close" onclick="loadImgClose()"></i>
					<div id="altContent">
						<h1>美图秀秀</h1>
					</div>
	        	</div>
	        </div>
	    </div>
	</section>
</body>
<!---------------------------脚本引用------------------------------>
<%@ include file="/resources/share/script.jsp"%>
<script src="${basePath}/resources/js/xiuxiu.js" type="text/javascript"></script>
<script src="${basePath}/resources/js/addProject.js" type="text/javascript"></script>
<script>
	$(function(){
		//服务器返回的JSON数据（包含title）
		var textMacList  = JSON.parse('${editForm.macList}');		
		$("#textMacList").val(JSON.stringify(textMacList, null, "\t"));
	});
	
	function editAction() {
		//填充imageUrl
		var imageUrl = $("#imageSrc").attr('src');
		imageUrl = imageUrl.substring(imageUrl.lastIndexOf("/")+1,imageUrl.length);
		$("#imageUrl").val(imageUrl);
		//填充MacList
		var textMacList = JSON.parse($("#textMacList").val());
		textMacList = JSON.stringify(textMacList);
		$("#macList").val(textMacList);
		//提交表单
		var form = document.forms[0];
		form.submit();
	};

</script>
</html>