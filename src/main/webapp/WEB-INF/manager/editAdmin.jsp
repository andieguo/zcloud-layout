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
    <script src="${basePath }/resources/js/form.js"></script>
</head>
<body><section class="main">
   	<%@ include file="/WEB-INF/share/notice.jsp" %>
    <div class="content sw">
        <div class="panel">
           <!-- 修改用户资料 -->
           	<spring:url value="/admin/edit" var="userActionUrl" />
			<form:form class="wc600" method="post" modelAttribute="editForm" action="${userActionUrl}">
			<form:hidden path="id" />
					<spring:bind path="nickname">
						<div class="form-group">
							<label>账号：</label>
							<input id="nickname" name="nickname"  value="${status.value}" type="text" placeholder="请输入账号" >
							<form:errors path="nickname" cssClass="error" />
						</div>
					</spring:bind>
	                <div class="form-group">
	                    <span class="label">角色：</span>
	                    <span class="input">
		           			<c:if test="${admin.role==0}">管理员</c:if>
							<c:if test="${admin.role==1}">用户</c:if>
						</span>
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
</body>
</html>