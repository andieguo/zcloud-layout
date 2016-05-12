<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<title>管理员信息详情</title>
		<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!---------------------------样式引用------------------------------>
		<%@ include file="/resources/share/style_backstage.jsp"%>
	</head>
	<body>
		<div class="top_Height"></div>
		<div class="edit_user" >
			<p class="edit_title" id="newH"><i class="glyphicon glyphicon-edit"></i> 管理员信息详情</p>
		    <div class="edit_user_cont" style="height:230px;">
		    	<span class="jt_new"></span>
							<div class="form-group">
								<label for="nickname">账 号:</label>${admin.nickname}
							</div>
							<div class="form-group">
								<label for="email">邮箱地址:</label>${admin.email}
							</div>
							<div class="form-group">
								<label for="phoneNumber">手机号:</label>${admin.phoneNumber}
							</div>
							<div class="form-group">
								<label for="role">角色:</label>
								<c:if test="${admin.role==0}">管理员</c:if>
								<c:if test="${admin.role==1}">用户</c:if>
							</div>
							<div class="form-group">
								<label for="sex">性别：</label>
								<c:if test="${admin.sex==0}">女</c:if>
								<c:if test="${admin.sex==1}">男</c:if>
							</div>
					<div>
				   	</div>
				   	<hr/>
				   	<p ><a target="_self" href="${basePath }/admin/editUI?id=${admin.id}">编辑信息</a></p>
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