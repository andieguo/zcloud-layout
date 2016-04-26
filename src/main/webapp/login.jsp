<%@ page language="java" contentType="text/html; charset=gb2312"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:url value="/resources/share/taglib.jsp" var="taglib_jsp" />
<script src="${jqueryJs}"></script>

<%@ include file="/WEB-INF/share/taglib.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<title>物联网管理系统</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="keywords" content="智云物联,物联网云计算公共应用开放平台"/>
		<meta name="description" content="公共物联网应用接入,实现远程数据的采集与分析,实现设备的实时控制与自动控制."/>
		<!--************************样式引用************************-->
		<%@ include file="/resources/share/style_front.jsp"%>
		<link type="text/css" rel="stylesheet" href="<%=basePath %>/style/css/login.css"/>
	</head>
	<body>
		<!--************************头部引用************************-->
		<%@ include file="/resources/share/top.jsp"%>
		<div id="body" class="banner">
			<%
				String adminName = "";
				String adminPassword = "";
				Cookie cookies[] = request.getCookies();
			 	if(cookies != null){
					for(int i=0;i<cookies.length;i++){
						Cookie sCookie = cookies[i];
						if("adminName".equals(sCookie.getName())){
							adminName = sCookie.getValue();
						}else if("adminPassword".equals(sCookie.getName())){
							adminPassword = sCookie.getValue();
						}
					}
				}
			%>
			<div class="login-aside">
		 		<div id="o-box-up"></div>
		  		<div id="o-box-down"  style="">
		   			<div class="error-box"></div>
		   			<s:form action="login" namespace="/control/admin" id="userLoginActionForm" name="login" method="post" target="_parent" cssClass="registerform" role="form" >
						<div class="fm-item">
					  		<label for="logonId" class="form-label">账号:</label>
					   		<s:textfield type="text" name="admin.name" placeholder="请输入账号" maxlength="100" id="username" cssClass="i-text"  datatype="s6-18" ></s:textfield>   
				       		<div class="ui-form-explain"></div>
				  		</div>
					  	<div class="fm-item">
						   	<label for="logonId" class="form-label">密码：</label>
						   	<s:textfield type="password" name="admin.password" placeholder="请输入密码"  value="" maxlength="100" id="password" cssClass="i-text" datatype="*6-16" ></s:textfield>    
					       	<div class="ui-form-explain"></div>
					  	</div>
						<div class="fm-item pos-r">
							<label for="logonId" class="form-label">验证码：</label>
							<s:textfield type="text" name="authCode" placeholder="请输入验证码" maxlength="100" id="yzm" cssClass="i-text yzm" ></s:textfield>    
							<div class="ui-form-explain">
								<a href="javascript:changeimg();" >
									<img id="code" class="yzm-img" src="<%=basePath %>/authimg.jsp" title="换一张"/>
								</a>
							</div>
						</div>
					    <div class="fm-item">
							<label for="logonId" class="form-label"></label>
						   	<input type="submit" value="" tabindex="4" id="send-btn" class="btn-login"> 
					       	<div class="ui-form-explain"></div>
					  	</div>
					  	<div class="fm-item">
						   	<s:fielderror/>
						   	<p class="reg"><a target="_self" href="<%=basePath %>/reg.jsp">用户注册</a></p>
					  	</div>
					</s:form>
				</div>
			</div>
			<div class="bd">
				<ul>
					<li style="background:url(<%=basePath %>/pic/theme-pic1.jpg) #CCE1F3 center 0 no-repeat;"></li>
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