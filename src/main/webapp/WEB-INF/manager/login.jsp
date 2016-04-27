<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/share/taglib.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<title>物联网管理系统</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="keywords" content="智云物联,物联网云计算公共应用开放平台"/>
		<meta name="description" content="公共物联网应用接入,实现远程数据的采集与分析,实现设备的实时控制与自动控制."/>
		<!--************************样式引用************************-->
		<%@ include file="/resources/share/style_front.jsp"%>
		<link type="text/css" rel="stylesheet" href="${basePath }/resources/style/css/login.css"/>
	</head>
	<body>
		<!--************************头部引用************************-->
		<%@ include file="/resources/share/top.jsp"%>
		<div id="body" class="banner">
			<div class="login-aside">
		 		<div id="o-box-up"></div>
		  		<div id="o-box-down"  style="">
		   			<div class="error-box"></div>
		   			<spring:url value="/admin/login" var="userActionUrl" />
 					<form:form class="form-horizontal" method="post" modelAttribute="loginForm" action="${userActionUrl}">
						<div class="form-group ">
							<label for="nickname">账 号:</label>
							<input id="nickname" name="nickname"  type="text"  class="form-control" placeholder="请输入账号" >
							<form:errors path="nickname" cssClass="error" />
						</div>
						<div class="form-group ">
							<label for="password">密 码:</label>
							<input id="password" name="password"  type="password"  class="form-control" placeholder="请输入密码" >
							<form:errors path="password" cssClass="error" />
						</div>
						<div class="fm-item pos-r">
							<label for="logonId" class="form-label">验证码：</label>
							<input type="text" name="authcode" placeholder="请输入验证码" maxlength="100" id="yzm" ></input>    
							<div class="ui-form-explain">
								<a href="javascript:changeimg();" >
									<img id="code" class="yzm-img" src="<%=basePath %>/authimg.jsp" title="换一张"/>
								</a>
							</div>
							<form:errors path="authcode" cssClass="error" />
						</div>
					    <div class="fm-item">
							<label for="logonId" class="form-label"></label>
						   	<input type="submit" value="" tabindex="4" id="send-btn" class="btn-login"> 
					       	<div class="ui-form-explain"></div>
					  	</div>
					  	<div class="fm-item">
						   	<p class="reg"><a target="_self" href="<%=basePath %>/reg.jsp">用户注册</a></p>
					  	</div>
					</form:form>
				</div>
			</div>
			<div class="bd">
				<ul>
					<li style="background:url(<%=basePath %>/resources/pic/theme-pic1.jpg) #CCE1F3 center 0 no-repeat;"></li>
				</ul>
			</div>
		</div>
		<!--************************尾部引用************************-->
		<%@ include file="/resources/share/foot.jsp"%>
		<!--************************脚本引用************************-->
		<%@ include file="/resources/share/script.jsp"%>
		<script language="JavaScript"> 	
			$(function(){
				setModule();			
			})
			function changeimg(){
				var myimg = document.getElementById("code"); 
				now = new Date(); 
				myimg.src="<%=basePath %>/authimg.jsp?code="+now.getTime();
			}
			if(window!=top) {top.location.href=window.location.href;}
		</script>
	</body>
</html>