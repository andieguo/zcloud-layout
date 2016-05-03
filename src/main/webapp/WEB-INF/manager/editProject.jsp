<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<title>项目修改</title>
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
		    		<spring:url value="/project/edit" var="userActionUrl" />
				<form:form class="form-horizontal" method="post" modelAttribute="editForm" action="${userActionUrl}">
<%-- 						<form:hidden path="page" /> --%>
						<form:hidden path="id" />
<%-- 						<form:hidden path="visible"/> --%>
						<spring:bind path="name">
							<div class="form-group ${status.error ? 'has-error' : ''}">
								<label for="name">项目名:</label>
								<input id="name" name="${status.expression }"  value="${status.value}" type="text"  class="form-control" placeholder="请输入账号" >
								<form:errors path="name" cssClass="error" />
							</div>
						</spring:bind>
						<spring:bind path="imageUrl">
							<div class="form-group">
								<label for="imageUrl">项目图片</label>
								<input type="text" class="form-control " name="imageUrl" value="${status.value}"  placeholder="请输入邮箱地址" />
								<form:errors path="imageUrl" />
							</div>
						</spring:bind>
						<spring:bind path="tid">
							<div class="form-group">
								<label for="tid">项目模板:</label>
			              	 	<form:select path="tid" items="${templateList}" class="form-control" />
							</div>
						</spring:bind>
						<spring:bind path="zcloudID">
							<div class="form-group">
								<label for="zcloudID">智云ID:</label>
		              			<input type="text" class="form-control " name="zcloudID" value="${status.value}"  placeholder="请输入邮箱地址" />
								<form:errors path="zcloudID" />
							</div>
						</spring:bind>
					   	<spring:bind path="zcloudKEY">
							<div class="form-group">
								<label for="zcloudKEY">智云KEY:</label>
		              			<input type="text" class="form-control " name="zcloudKEY" value="${status.value}"  placeholder="请输入邮箱地址" />
								<form:errors path="zcloudKEY" />
							</div>
						</spring:bind>
						<spring:bind path="serverAddr">
							<div class="form-group">
								<label for="serverAddr">智云Server:</label>
		              			<input type="text" class="form-control " name="serverAddr" value="${status.value}"  placeholder="请输入邮箱地址" />
								<form:errors path="serverAddr" />
							</div>
						</spring:bind>
						<spring:bind path="macList">
							<div class="form-group">
								<label for="macList">智云Mac:</label>
		              			<input type="text" class="form-control " name="macList" value="${status.value}"  placeholder="请输入邮箱地址" />
								<form:errors path="macList" />
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