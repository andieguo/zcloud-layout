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
    <title>智云组态仿真软件项目</title>
    <link rel="stylesheet" href="${basePath }/resources/css_index/style.css">
	<%@ include file="/resources/share/script.jsp"%>
</head>
<body>
    <header class="content">
        <a href="index.html"><img src="${basePath }/resources/images/logo.png"></a>
    	<h1>智云组态仿真软件项目</h1>
    	<div class="header-sign">
            <a href="${basePath }/admin/loginUI">登陆</a>
    		<a href="${basePath }/admin/registerUI">注册</a>
    	</div>
    </header>
    <section class="banner sign-main">
        <div class="content">
            <h1 class="banner-title">Zonesion ( Wuhan )<br>Technology<br>Co.,Ltd</h1>
            <div class="sign-in-panel">
                <div class="sign-in-header">账号登陆</div>
                <div class="sign-in-body">
                	<spring:url value="/admin/login" var="loginUrl" />
 					<form:form class="form-horizontal" method="post" modelAttribute="loginForm" action="${loginUrl}">
        				<%@ include file="/WEB-INF/share/msg.jsp"%>
                  		<div class="form-group ">
							<label for="nickname">账 号:<form:errors path="nickname" cssClass="error" /></label>
							<input id="nickname" name="nickname"  type="text" placeholder="请输入账号" >
						</div>
						<div class="form-group ">
							<label for="password">密 码:<form:errors path="password" cssClass="error" /></label>
							<input id="password" name="password"  type="password" placeholder="请输入密码" >
						</div>
						<div class="form-group ">
							<label for="password">角 色:</label>
							<select id="role" name="role" >
								<option value="2" >超级管理员</option>
								<option value="0" select="selected">管理员</option>
								<option value="1" >普通用户</option>
							</select>
						</div>
						<div class="form-group">
							<label for="logonId" class="form-label">验证码：<form:errors path="authcode" cssClass="error" /></label>
							<input type="text" data-verify="input" name="authcode" placeholder="请输入验证码"></input>    
							<a class="img" href="javascript:changeimg();" >
								<img id="code" src="<%=basePath %>/authimg.jsp" title="换一张"/>
							</a>
						</div>
	                    <div class="form-checkbox">
	                        <input id="rememberPassword" type="checkbox">
	                        <label class="checkbox-img" for="rememberPassword"></label>
	                        <label class="checkbox-text" for="rememberPassword">记住密码</label>
	                        <!-- <a class="forget">忘记密码</a> -->
	                    </div>
	                    <div class="form-button">
	                        <button type="submit">登陆</button>
	                        <button type="button">注册</button>
	                    </div>
                    </form:form>
                    <!-- <a class="third" href="#">使用第三方登陆平台</a> -->
                </div>
            </div>
        </div>
    	<img class="banner-img" src="${basePath }/resources/images/banner.jpg" alt="">
    </section>
    <footer>中智讯（武汉）科技有限公司版权所有 鄂ICP备13015866号-2</footer>
    <!--************************脚本引用************************-->
	<script language="JavaScript"> 	
		function changeimg(){
			var myimg = document.getElementById("code"); 
			now = new Date(); 
			myimg.src="<%=basePath %>/authimg.jsp?code="+now.getTime();
		}
		if(window!=top) {top.location.href=window.location.href;}
	</script>
</body>
</html>