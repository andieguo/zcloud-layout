<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<title>信息修改</title>
		<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!---------------------------样式引用------------------------------>
		<%@ include file="/resources/share/style_backstage.jsp"%>
	</head>
	<body>
		<div class="top_Height"></div>
		<div class="edit_user" >
			<p class="edit_title" id="newH"><i class="glyphicon glyphicon-edit"></i> 信息修改</p>
		    <div class="edit_user_cont" style="height:230px;">
		    	<span class="jt_new"></span>
		    		<spring:url value="/admin/edit" var="userActionUrl" />
				<form:form class="form-horizontal" method="post" modelAttribute="editForm" action="${userActionUrl}">
						<form:hidden path="id" />
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
								<div class="form-group sex">
									<label for="sex">性别：</label>
									<div>男性：<input  class="form-control"  type="radio" name="sex" value="1" checked="checked"/> 女性：<input  class="form-control"  type="radio" name="sex" value="0"/>  </div>
									<form:errors path="sex" />
								</div>
						</spring:bind>
					<div>
						<input value="修改"  type="submit"></input>
				   	</div>
				   	<hr/>
				   	<form:errors path="*" />
				   	<p ><a target="_self" href="${basePath }/login.jsp">用户登录</a></p>
				</form:form>
				
		    </div>
		</div>
		<!---------------------------脚本引用------------------------------>
		<%@ include file="/resources/share/script.jsp"%>
		<script>
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
		function textChange(){
			createXMLHttpRequest();
			var name = document.getElementById("admin_name").value;
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
						document.getElementById("admin_name").value = "";
					}else{
						document.getElementById("myDiv").innerHTML = "恭喜您，可使用该用户名";
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