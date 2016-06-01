<%@page import="com.zonesion.layout.model.AdminEntity"%>
<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>智云组态仿真软件</title>
    <link rel="stylesheet" href="${basePath }/resources/css/style.css">
    <script src="${basePath }/resources/js/jquery2.2.1.min.js"></script>
    <script src="${basePath }/resources/js/script.js"></script>
</head>
<body>
    <%
    	HttpSession sessions = request.getSession();
    	AdminEntity admin = (AdminEntity)sessions.getAttribute("admin");
    %>
    <!-- 页头 -->
    <header class="header">
        <div class="logo">
            <h1 class="name">智云组态仿真软件</h1>
        </div>
        <div class="user">
            <span class="name">${admin.nickname }</span>
            <a class="out" href="${basePath }/admin/outlogin">退出</a>
        </div>
    </header>
    <!-- /页头 -->
    <!-- banner -->
    <div class="banner">
        <div class="title">
            <img class="user-icon" src="${basePath }/resources/images/user-icon.png">
            <span>个人中心</span>
            <span>Personal Center</span>
        </div>
        <div class="color-box1"></div>
        <div class="color-box2"></div>
    </div>
    <!-- /banner -->
    <!-- 导航栏 -->
    <ul class="topNav">
        <li>
            <a>用户管理</a>
            <i class="icon icon-off"></i>
            <ul class="hide">
            	<!-- 普通管理员和超级管理员能够访问 -->
            	<c:if test="${admin.role != 1}">
            		<li><a href="${basePath }/admin/list" target="iframe">用户列表</a></li>
            	</c:if>
                <li><a href="${basePath }/admin/detail?id=${admin.id}" target="iframe">用户资料</a></li>
                <!-- <li><a class="active" href="#">用户资料</a></li> -->
                <li><a href="${basePath }/admin/editPasswdUI?id=${admin.id}" target="iframe">密码修改</a></li>
            </ul>
        </li>
        <li>
            <a>模板管理</a>
            <i class="icon icon-off"></i>
            <ul class="hide">
            	<li><a href="${basePath }/template/list?type=0" target="iframe">系统模板</a></li>
                <li><a href="${basePath }/template/list?type=1" target="iframe">用户模板</a></li>
            </ul>
        </li>
        <li>
            <a>项目管理</a>
            <i class="icon icon-off"></i>
            <ul class="hide">
                <li><a href="${basePath }/project/list" target="iframe">项目列表</a></li>
                <li><a href="${basePath }/project/addUI" target="iframe">添加项目</a></li>
            </ul>
        </li>
    </ul>
    <!-- /导航栏 -->
    <!-- 内容 -->
    <%
    	String to = (String)request.getAttribute("to");
    	if(to!=null && to.equals("templateList")){
    		Integer type = (Integer)request.getAttribute("type");
    %>
    		<iframe id="iframe" src="${basePath }/template/list?type=${type}" name="iframe"></iframe>
    <%
    	}else if(to!=null && to.equals("adminList")){
    %>
   			<iframe id="iframe" src="${basePath }/admin/list" name="iframe"></iframe>
    <%
    	}else if(to!=null && to.equals("adminDetail")){
    %>
    		<iframe id="iframe" src="${basePath }/admin/detail?id=${admin.id}" name="iframe"></iframe>
    <%
    	}else{
    %>
    		<iframe id="iframe" src="${basePath }/admin/notice" name="iframe"></iframe>
	<%
    	}
	%>	
    <!-- /内容 -->
    <!-- 页尾 -->
    <footer class="footer">中智讯（武汉）科技有限公司版权所有&nbsp;&nbsp;&nbsp;&nbsp;鄂ICP备13015866号-2</footer>
    <!-- /页尾 -->
</body>
</html>