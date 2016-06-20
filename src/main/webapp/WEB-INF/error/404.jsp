<%@ page language="java" pageEncoding="utf-8" import="com.zonesion.layout.model.AdminEntity,com.zonesion.layout.util.Constants" isELIgnored="false"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
<!doctype html>
<html lang="zh-CN">
<head>
<title>智云组态软件</title>
<%
	HttpSession sessions = request.getSession();
	AdminEntity admin = (AdminEntity)sessions.getAttribute("admin");
%>
<c:set var="basePath" value="<%=basePath %>" scope="application"/> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="${basePath }/resources/css/style.css">
</head>
<body>
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
<div class="error-content" id="err" data-spm="1997480901">
	<h1 class="error-title">4<img src="${basePath }/resources/images/error-bg.png">4</h1>
	<h2 class="error-text">
		抱歉！页面无法访问……
		<p>
			可能因为：<br>
			&nbsp;&nbsp;&nbsp;&nbsp;网址有错误<span><i class="gt">&gt;</i>请检查地址是否完整或存在多余字符</span><br>
			&nbsp;&nbsp;&nbsp;&nbsp;网址已失效<span><i class="gt">&gt;</i>可能页面已删除，活动已下线等</span>
		</p>
	</h2>
</div>
	<!-- 页尾 -->
    <footer class="footer">中智讯（武汉）科技有限公司版权所有&nbsp;&nbsp;&nbsp;&nbsp;鄂ICP备13015866号-2</footer>
    <!-- /页尾 -->
</body>
</html>