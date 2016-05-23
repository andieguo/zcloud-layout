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
    <aside class="text">
    <h1>中智讯（武汉）科技有限公司</h1>
    <p>版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯</p>
    <p>（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有</p>
    </aside>
    <div class="content sw">
        <div class="panel">
            <!-- 用户资料 -->
            <div class="wc600">
                <div class="change-btn">
                    <i class="icon icon-change"></i>
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