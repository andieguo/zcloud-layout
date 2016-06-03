<%@ page language="java" contentType="text/html; charset=utf-8" import="com.zonesion.layout.model.AdminEntity" isELIgnored="false"%>
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
<body><section class="main">
	<%@ include file="/WEB-INF/share/notice.jsp" %>
	<%
    	HttpSession sessions = request.getSession();
    	AdminEntity adminEntity = (AdminEntity)sessions.getAttribute("admin");
   	%>
    <div class="content sw">
        <div class="panel">
        	<%@ include file="/WEB-INF/share/msg.jsp"%>
            <!-- 用户资料 -->
            <div class="wc600">
                <div class="change-btn">
                    <i class="icon icon-change"></i>
                    <!-- 超级管理员能修改所有用户的资料，普通管理员和用户只能查看，普通管理员能添加系统模板 -->
               		 <a class="text" href="${basePath }/admin/editUI?id=${admin.id}">修改资料</a>
                </div>
                <div class="form-group">
                    <span class="label">账号：</span>
                    <span class="input">${admin.nickname}</span>
                </div>
                <div class="form-group">
                    <span class="label">角色：</span>
                    <span class="input">
	           			<c:if test="${admin.role==0}">管理员</c:if>
						<c:if test="${admin.role==1}">用户</c:if>
						<c:if test="${admin.role==2}">超级管理员</c:if>
					</span>
                </div>
                <div class="form-group">
                    <span class="label">E-mail：</span>
                    <span class="input">${admin.email}</span>
                </div>
                <div class="form-group">
                    <span class="label">手机号：</span>
                    <span class="input">${admin.phoneNumber}</span>
                </div>	
                <div class="form-group">
                    <span class="label">性别：</span>
                    <span class="input">
	                    <c:if test="${admin.sex==0}">女</c:if>
						<c:if test="${admin.sex==1}">男</c:if>
					</span>
                </div>
            </div>
            <!-- /用户资料 -->
        </div>
    </div>
</section>
<!-- 修改用户资料按钮 -->
<!-- /修改用户资料按钮 -->
</body>
</html>