<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<title>物联网管理系统</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="keywords" content="智云物联,物联网云计算公共应用开放平台"/>
		<meta name="description" content="公共物联网应用接入,实现远程数据的采集与分析,实现设备的实时控制与自动控制."/>
		<!--****************************样式引用****************************-->
		<%@ include file="/resources/share/style_front.jsp"%>
		<link type="text/css" rel="stylesheet" href="${basePath }/resources/style/css/log_reg.css"/>
	</head>
	<body>
		<!--****************************头部引用****************************-->
		<%@ include file="/resources/share/top.jsp"%>
		<div id="body" class="container" style="width:1024px;">
			<div class="reg">
				<spring:url value="/admin/register" var="userActionUrl" />
				<form:form class="form-horizontal" method="post" modelAttribute="adminForm" action="${userActionUrl}">
						<spring:bind path="nickname">
							<div class="form-group ${status.error ? 'has-error' : ''}">
								<label for="nickname">账 号:</label>
								<input id="nickname" name="${status.expression }"  value="${status.value}" type="text"  class="form-control" placeholder="请输入账号" >
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
						<spring:bind path="password">
							<div class="form-group">
								<label for="password">密 码:</label>
								<input type="text" class="form-control " name="password" value="${status.value}"  placeholder="请输入密码" />
								<form:errors path="password" />
							</div>
						</spring:bind>
						<spring:bind path="confirmPassword">
							<div class="form-group">
								<label for="confirmPassword">密 码:</label>
								<input type="text" class="form-control " name="confirmPassword"  value="${status.value}"  placeholder="确认密码..." />
								<form:errors path="confirmPassword" />
							</div>
						</spring:bind>
					<div class="form-group authCode">
						<label for="validatecode">验证码:</label>
						<input type="text" class="form-control " name="authCode" placeholder="请输入验证码" />
						<form:errors path="authCode" />
					</div>
					<div class="form-group code_box">
						<a href="javascript:changeimg();" >
							<img id="code" src="${basePath }/authimg.jsp" title="换一张"/>
						</a>
				   	</div>
				   	<spring:bind path="sex">
							<div class="form-group sex">
								<label for="sex">性别：</label>
								<div>男性：<input  class="form-control"  type="radio" name="sex" value="1" checked="checked"/> 女性：<input  class="form-control"  type="radio" name="sex" value="0"/>  </div>
								<form:errors path="sex" />
							</div>
						</spring:bind>
					<div>
						<button value="注 册" cssClass="btn btn-success"  type="submit"></button>
				   	</div>
				   	<hr/>
				   	<p ><a target="_self" href="${basePath }/login.jsp">用户登录</a></p>
				</form:form>
			</div>
		</div>
		<!--****************************尾部引用****************************-->
		<%@ include file="/resources/share/foot.jsp"%>
		<!--****************************脚本引用****************************-->
		<%@ include file="/resources/share/script.jsp"%>
		<script language="JavaScript" type="text/javascript">
			function changeimg(){
				var myimg = document.getElementById("code"); 
				now = new Date(); 
				myimg.src="${basePath }/authimg.jsp?code="+now.getTime();
			}
			$(function(){
				setModule();			
			})
			
			 var xmlHttp;
		     function createXMLHttpRequest()
		     {
		         if (window.ActiveXObject)
		         {
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		         }
		         else if(window.XMLHttpRequest)
		         {
		            xmlHttp = new XMLHttpRequest();
		         }
		     }
			function textChange()
			{
				createXMLHttpRequest();
				var name = document.getElementById("reg_admin_name").value;
				var url="${basePath}"+"/control/admin/isExist.action";
				xmlHttp.open("POST",url,true);
				xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded","charset=UTF-8");
				xmlHttp.onreadystatechange = showDIV;
				xmlHttp.send("name="+encodeURI(encodeURI(name)));
			}
			function showDIV()
			{
				if (xmlHttp.readyState == 4)
				{
					if (xmlHttp.status == 200)
					{
						var result = xmlHttp.responseText;
						if(result != ""){
							document.getElementById("myDiv").innerHTML = result;
							document.getElementById("reg_admin_name").value = "";
						}else{
							document.getElementById("myDiv").innerHTML = "恭喜您，可使用该用户名注册";
						}
						xmlHttp.close();
					}
					else
					{ //页面不正常
						alert("您请求的页面有异常 ");
					}
				}
				else
				{
					//  信息还没有返回，等待
				}
			}
		</script>
	</body>
</html>