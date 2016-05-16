<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<section class="main">
    <aside class="text">
    <h1>中智讯（武汉）科技有限公司</h1>
    <p>版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯</p>
    <p>（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有中智讯（武汉）科技有限公司版权所有</p>
    </aside>
    <div class="content sw">
        <div class="panel">
            <spring:url value="/admin/editPasswd" var="userActionUrl" />
			<form:form class="wc600" method="post" modelAttribute="passwdForm" action="${userActionUrl}">
				<form:hidden path="id"/>
				<div class="form-group">
					<label for="password">当前密码：</label>
					<input id="password" name="password"  type="password" placeholder="请输入当前密码" onchange="textChange()">
					<form:errors path="password" cssClass="error" />
					<div id="conformFailDiv"></div>
				</div>
				<div class="form-group">
                       <label>新密码：</label>
                       <input id="newPassword" name="newPassword"  type="password" placeholder="请输入密码" />
                       <span class="error">*</span>
                       <form:errors path="newPassword" cssClass="error"/>
                   </div>
                   <div class="form-group">
                       <label>确认密码：</label>
                        <input id="confirmPassword" name="confirmPassword"  type="password" placeholder="请输入确认密码" />
                       <span class="error">*</span>
					<form:errors path="confirmPassword" cssClass="error"/>
                   </div>
				<div class="form-button">
                    &nbsp;<button class="btn" type="submit">修改</button>
                </div>
			</form:form>
        </div>
    </div>
</section>
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