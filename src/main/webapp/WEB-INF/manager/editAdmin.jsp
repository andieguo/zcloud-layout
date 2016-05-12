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
    <script src="${basePath }/resources/js/script.js"></script>
</head>
<body><section class="main">
    <aside class="text">
    <h1>中智讯（武汉）科技有限公司</h1>
    <p>版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯</p>
    <p>（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有</p>
    </aside>
    <div class="content sw">
        <div class="panel">
           <!-- 修改用户资料 -->
           	<spring:url value="/admin/edit" var="userActionUrl" />
			<form:form class="form-horizontal" method="post" modelAttribute="editForm" action="${userActionUrl}">
			<form:hidden path="id" />
					<spring:bind path="nickname">
						<div class="form-group">
							<label>账&nbsp;&nbsp;&nbsp;&nbsp;号：</label>
							<input id="nickname" name="nickname"  value="${status.value}" type="text"  class="form-control" placeholder="请输入账号" >
							<form:errors path="nickname" cssClass="error" />
						</div>
					</spring:bind>
					<spring:bind path="email">
						<div class="form-group">
							<label for="email">邮箱地址:</label>
							<input type="text" class="form-control " name="email" value="${status.value}"  placeholder="请输入邮箱地址" />
							<form:errors path="email" />
						</div>
					</spring:bind>
					<spring:bind path="phoneNumber">
						<div class="form-group">
							<label for="phoneNumber">手机号:</label>
							<input  type="text" class="form-control " name="phoneNumber" value="${status.value}" placeholder="请输入手机号" />
							<form:errors path="phoneNumber" />
						</div>
					</spring:bind>
					<c:if test="${entry.role==0}">
						<spring:bind path="role">
							<div class="form-group">
								<label for="role">角色:</label>
		              			<form:select path="role" items="${roleList}" class="form-control" />
								<form:errors path="role" />
							</div>
						</spring:bind>
					</c:if>
					<spring:bind path="sex">
						<div class="form-group">
		                    <label>性&nbsp;&nbsp;&nbsp;&nbsp;别：</label>
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
		                    <form:errors path="sex" />
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
<!-- 修改用户资料按钮 -->
<script type="text/javascript">
</script>
<!-- /修改用户资料按钮 -->
</body>
</html>