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
    <title>智云组态仿真软件项目</title>
    <link rel="stylesheet" href="${basePath }/resources/css_index/style.css">
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
            <div class="sign-up-panel">
                <div class="sign-up-header">
                    <h1 class="sign-up-title">注册账号</h1>
                    <a href="${basePath }/admin/loginUI" class="sign-up-more">使用账号登陆</a>
                </div>
                <div class="sign-up-body form-inline">
                    <spring:url value="/admin/register" var="userActionUrl" />
					<form:form class="form-horizontal" method="post" modelAttribute="adminForm" action="${userActionUrl}">
                    <div class="form-group">
						<label for="nickname">填写账号:</label>
						<input id="nickname" name="nickname" type="text" placeholder="请输入账号" onchange="textChange()">
						<span class="point">*</span>
						<form:errors path="nickname" cssClass="error" />
						<div id="isExistedDiv"></div>
					</div>
                    <div class="form-group">
                        <label>填写性别：</label>
                        <div class="form-checkbox">
                            <input id="man" type="radio" name="sex" value="1">
                            <label class="checkbox-img" for="man"></label>
                            <label class="checkbox-text" for="man">男</label>
                        </div>
                        <div class="form-checkbox">
                            <input id="woman" type="radio" name="sex" value="0">
                            <label class="checkbox-img" for="woman"></label>
                            <label class="checkbox-text" for="woman">女</label>
                        </div>
                        <span class="point">*</span>
                    </div>
                    <div class="form-group">
                        <label>填写邮箱地址：</label>
						<input id="email" name="email"  type="text" placeholder="请输入邮箱地址" />
                        <span class="point">*</span>
						<form:errors path="email" />
                    </div>
                    <div class="form-group">
                        <label>您的手机号：</label>
                        <input id="phoneNumber" name="phoneNumber"  type="text" placeholder="请输入手机号" />
                        <span class="point">*</span>
						<form:errors path="phoneNumber" />
                    </div>
                    <div class="form-group">
                        <label>设置密码：</label>
                         <input id="password" name="password"  type="text" placeholder="请输入密码" />
                        <span class="point">*</span>
						<form:errors path="password" />
                    </div>
                    <div class="form-group">
                        <label>确认密码：</label>
                         <input id="confirmPassword" name="confirmPassword"  type="text" placeholder="请输入确认密码" />
                        <span class="point">*</span>
						<form:errors path="confirmPassword" />
                    </div>
                    <div class="form-group">
							<label for="logonId" class="form-label">验证码：</label>
							<input type="text" data-verify="input" name="authcode" placeholder="请输入验证码"></input>    
							<div>
								<a href="javascript:changeimg();" >
									<img id="code" data-verify="img" src="<%=basePath %>/authimg.jsp" title="换一张"/>
								</a>
							</div>
							<form:errors path="authcode" cssClass="error" />
					</div>
                    <div class="form-button">
                        <button type="submit">确认提交</button>
                    </div>
                    </form:form>
                </div>
            </div>
        </div>
    	<img class="banner-img" src="${basePath }/resources/images/banner.jpg" alt="">
    </section>
    <footer>中智讯（武汉）科技有限公司版权所有 鄂ICP备13015866号-2</footer>
    <!--****************************脚本引用****************************-->
	<%@ include file="/resources/share/script.jsp"%>
    <script type="text/javascript">
			function changeimg(){
				var myimg = document.getElementById("code"); 
				now = new Date(); 
				myimg.src="${basePath }/authimg.jsp?code="+now.getTime();
			}
			function textChange()
			{
				var name = $("#nickname").val();
				name = encodeURI(name);//解决中文乱码问题
				var url="${basePath}"+"/admin/isExist";
				console.log("url:"+url);
				 $.ajax( {
						url : url,
						type : 'post',
						data : {nickname:name},
						dataType : 'json',
						success : function(data) {//返回的data本身即是一个JSON对象
							console.log("data.status:"+data.status);
							console.log("data.message:"+data.message);
							if(data.status == 1){//存在该用户
								$('#nickname').val("");
								$('#isExistedDiv').html("该用户名已存在，请重新输入");
							}else if(data.status==0){//不存在该用户
								$('#isExistedDiv').html("恭喜您，可使用该用户名注册");
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