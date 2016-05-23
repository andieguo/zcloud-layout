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
    <script src="${basePath }/resources/js/jquery2.2.1.min.js"></script>
</head>
<body>
	<section class="main">
	    <aside class="text">
	    <h1>中智讯（武汉）科技有限公司</h1>
	    <p>版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯</p>
	    <p>（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有</p>
	    </aside>
	    <div class="content sw">
	        <div class="panel">
				<spring:url value="/project/edit" var="userActionUrl" />
				<form:form class="wc600" method="post" modelAttribute="editForm" action="${userActionUrl}">
						<form:hidden path="id" />
						<form:hidden path="tid"/>
						<form:hidden path="macList"/>
						<form:hidden path="imageUrl"/>
						<spring:bind path="name">
							<div class="form-group">
								<label for="name">项目名：</label>
								<input id="name" name="name"  value="${status.value}" type="text"  class="form-control" placeholder="请输入账号" >
								<form:errors path="name" cssClass="error" />
							</div>
						</spring:bind>
						<div class="form-group">
							<label for="imageSrc">项目图片：</label>
							<img alt="" id="imageSrc" name="imageSrc" src="${basePath }/photo/MT_1463132423427.jpg" >
							<a href="javascript:loadImg()" target="_blank">请选择图片</a>
						</div>
						<spring:bind path="zcloudID">
							<div class="form-group">
								<label for="zcloudID">智云ID：</label>
		              			<input type="text" class="form-control " id="zcloudID" name="zcloudID" value="${status.value}"  placeholder="请输入邮箱地址" />
								<form:errors path="zcloudID" cssClass="error" />
							</div>
						</spring:bind>
					   	<spring:bind path="zcloudKEY">
							<div class="form-group">
								<label for="zcloudKEY">智云KEY：</label>
		              			<input type="text" class="form-control " id="zcloudKEY" name="zcloudKEY" value="${status.value}"  placeholder="请输入邮箱地址" />
								<form:errors path="zcloudKEY" cssClass="error" />
							</div>
						</spring:bind>
						<spring:bind path="serverAddr">
							<div class="form-group">
								<label for="serverAddr">智云Server：</label>
		              			<input type="text" class="form-control " id="serverAddr" name="serverAddr" value="${status.value}"  placeholder="请输入邮箱地址" />
								<form:errors path="serverAddr" cssClass="error" />
							</div>
						</spring:bind>
	
						<div class="form-group">
							<label for="textMacList">智云Mac：</label>
							<textarea rows="3" cols="20" class="form-control" id="textMacList" name="textMacList"></textarea>
							<form:errors path="macList" />
						</div>
			            
						<div class="form-button">
		                    &nbsp;<a class="btn submit" href="javascript:editAction()">修改</a>
		                </div>
				</form:form>
	            <!-- /修改用户资料 -->
	            <!-- <div class="altContent-shell hide"> -->
					<div id="altContent">
						<h1>美图秀秀</h1>
					</div>
	        	<!-- </div> -->
	        </div>
	    </div>
	</section>
</body>
<!---------------------------脚本引用------------------------------>
<%@ include file="/resources/share/script.jsp"%>

<script>
	$(function(){
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
	}
</script>
</html>