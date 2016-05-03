<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<title>密码修改</title>
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
		    		<spring:url value="/admin/editPasswd" var="userActionUrl" />
					<form:form class="form-horizontal" method="post" modelAttribute="passwdForm" action="${userActionUrl}">
						<form:hidden path="id"/>
						<div class="form-group">
							<label for="password">当前密码:</label>
							<input id="password" name="password"  type="password" placeholder="请输入当前密码" onchange="textChange()">
							<form:errors path="password" cssClass="error" />
							<div id="conformFailDiv"></div>
						</div>
						<div>
						<div class="form-group">
	                        <label>新密码：</label>
	                        <input id="newPassword" name="newPassword"  type="password" placeholder="请输入密码" />
	                        <span class="point">*</span>
							<form:errors path="newPassword" cssClass="error"/>
	                    </div>
	                    <div class="form-group">
	                        <label>确认密码：</label>
	                         <input id="confirmPassword" name="confirmPassword"  type="password" placeholder="请输入确认密码" />
	                        <span class="point">*</span>
							<form:errors path="confirmPassword" cssClass="error"/>
	                    </div>
						<input value="修改"  type="submit"></input>
					   	</div>
					</form:form>
		    </div>
		</div>
		<!---------------------------脚本引用------------------------------>
		<%@ include file="/resources/share/script.jsp"%>
		<script>
		function textChange()
		{
			var password = $("#password").val();
			password = encodeURI(password);//解决中文乱码问题
			var url="${basePath}"+"/admin/conformPasswd";
			var id =$("#id").val();
			console.log("url:"+url);
			 $.ajax( {
					url : url,
					type : 'get',
					data : {'password':password,'id':id},
					dataType : 'json',
					success : function(data) {//返回的data本身即是一个JSON对象
						console.log("data.status:"+data.status);
						console.log("data.message:"+data.message);
						if(data.status == 1){//当前密码输入正确
							$('#conformFailDiv').html("恭喜您，当前密码输入正确");
						}else if(data.status==0){//当前密码输入错误
							$('#password').val("");
							$('#conformFailDiv').html("当前密码输入错误");
						}
					},
					error : function() {
						alert("您请求的页面有异常 ");
					}
			});
		}
		</script>
	</body>
</html>