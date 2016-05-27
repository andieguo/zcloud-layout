<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ page import="com.zonesion.layout.model.AdminEntity"%>
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
    <script src="${basePath }/resources/js/form.js"></script>
</head>
<body><section class="main">
   	<%@ include file="/WEB-INF/share/notice.jsp" %>
   	<%
    	HttpSession sessions = request.getSession();
    	AdminEntity admin = (AdminEntity)sessions.getAttribute("admin");
    %>
    <div class="content sw">
        <div class="panel">
           <!-- 修改用户资料 -->
           	<spring:url value="/admin/edit" var="userActionUrl" />
			<form:form class="wc600" method="post" modelAttribute="editForm" action="${userActionUrl}">
			<form:hidden path="id" />
					<spring:bind path="nickname">
						<div class="form-group">
							<label>账号：</label>
							<input id="nickname" name="nickname"  value="${status.value}" type="text" placeholder="请输入账号"  onchange="textChange()">
							<form:errors path="nickname" cssClass="error" />
							<div id="isExistedDiv"></div>
						</div>
					</spring:bind>
	                <div class="form-group">
	                    <span class="label">角色：</span>
	                    <c:if test="${admin.role == 2}">
	                     	<div class="form-checkbox">
		                        <input id="admin" type="radio"  value="0" name="role" checked="checked">
		                        <label class="checkbox-img" for="admin"></label>
		                        <label class="checkbox-text" for="admin">管理员</label>
		                    </div>
		                    <div class="form-checkbox">
		                        <input id="user" type="radio"  value="1" name="role">
		                        <label class="checkbox-img" for="user"></label>
		                        <label class="checkbox-text" for="user">普通用户</label>
		                    </div>
		                    <div class="form-checkbox">
		                        <input id="superadmin" type="radio"  value="2" name="role">
		                        <label class="checkbox-img" for="superadmin"></label>
		                        <label class="checkbox-text" for="superadmin">超级管理员</label>
		                    </div>
						</c:if>
						<c:if test="${admin.role != 2}">
							<span class="input">
			           			<c:if test="${admin.role==0}">管理员</c:if>
								<c:if test="${admin.role==1}">用户</c:if>
								<c:if test="${admin.role==2}">超级管理员</c:if>
							</span>
						</c:if>
	                </div>
					<spring:bind path="email">
						<div class="form-group">
							<label for="email">E-mail：</label>
							<input type="text" name="email" value="${status.value}"  placeholder="请输入邮箱地址" />
							<form:errors path="email" cssClass="error" />
						</div>
					</spring:bind>
					<spring:bind path="phoneNumber">
						<div class="form-group">
							<label for="phoneNumber">手机号：</label>
							<input  type="text" name="phoneNumber" value="${status.value}" placeholder="请输入手机号" />
							<form:errors path="phoneNumber" cssClass="error" />
						</div>
					</spring:bind>
					<c:if test="${entry.role==0}">
						<spring:bind path="role">
							<div class="form-group">
								<label for="role">角色：</label>
		              			<form:select path="role" items="${roleList}" />
								<form:errors path="role" cssClass="error" />
							</div>
						</spring:bind>
					</c:if>
					<spring:bind path="sex">
						<div class="form-group">
		                    <label>性别：</label>
		                    <div class="form-checkbox">
		                        <input id="man" type="radio"  value="1" name="sex" checked="checked">
		                        <label class="checkbox-img" for="man"></label>
		                        <label class="checkbox-text" for="man">男</label>
		                    </div>
		                    <div class="form-checkbox">
		                        <input id="woman" type="radio"  value="0" name="sex">
		                        <label class="checkbox-img" for="woman"></label>
		                        <label class="checkbox-text" for="woman">女</label>
		                    </div>
		                    <form:errors path="sex" cssClass="error" />
		                </div>
					</spring:bind>
	                <div class="form-button">
	                    &nbsp;<button class="btn" type="submit">保存</button>
	                </div>
            </form:form>
            <!-- /修改用户资料 -->
        </div>
    </div>
</section>
<script>
function textChange()
{
	var oldname = '${editForm.nickname}';
	var name = $("#nickname").val();
	if(oldname != name){
		name = encodeURI(name);//解决中文乱码问题
		var url="${basePath}"+"/admin/isExist";
		console.log("url:"+url);
		 $.ajax( {
				url : url,
				type : 'post',
				data : {nickname:name},
				dataType : 'json',
				success : function(data) {//返回的data本身即是一个JSON对象
					console.log("data.status:"+data.status);
					console.log("data.message:"+data.message);
					if(data.status == 1){//存在该用户
						$('#nickname').val("");
						$('#isExistedDiv').html("该用户名已存在，请重新输入");
					}else if(data.status==0){//不存在该用户
						$('#isExistedDiv').html("恭喜您，可使用该用户名注册");
					}
				},
				error : function() {
					alert("您请求的页面有异常 ");
				}
		});
	}else{
		$('#isExistedDiv').html("");
	}
}
</script>
</body>
</html>