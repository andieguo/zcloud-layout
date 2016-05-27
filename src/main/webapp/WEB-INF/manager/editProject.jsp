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
    <script src="${basePath }/resources/js/form.js"></script>
</head>
<body>
	<section class="main">
    	<%@ include file="/WEB-INF/share/notice.jsp" %>
	    <div class="content sw">
	        <div class="panel">
				<spring:url value="/project/edit" var="userActionUrl" />
				<form:form method="post" modelAttribute="editForm" action="${userActionUrl}">
						<form:hidden path="id" />
						<form:hidden path="tid"/>
						<form:hidden path="macList"/>
						<form:hidden path="imageUrl"/>
						<spring:bind path="name">
							<div class="form-group">
								<label for="name">项目名：</label>
								<input id="name" name="name" value="${status.value}" type="text" placeholder="请输入账号" >
								<form:errors path="name" cssClass="error" />
							</div>
						</spring:bind>
						<div class="form-group">
							<label for="imageSrc">项目图片：</label>
							<img class="pic" alt="" id="imageSrc" name="imageSrc" src="${basePath }/photo/${editForm.imageUrl}" >
							<a class="btn" href="javascript:loadImg()">请选择图片</a>
						</div>
						<spring:bind path="zcloudID">
							<div class="form-group">
								<label for="zcloudID">智云ID：</label>
		              			<input type="text" id="zcloudID" name="zcloudID" value="${status.value}" placeholder="请输入邮箱地址" />
								<form:errors path="zcloudID" cssClass="error" />
							</div>
						</spring:bind>
					   	<spring:bind path="zcloudKEY">
							<div class="form-group">
								<label for="zcloudKEY">智云KEY：</label>
		              			<input type="text" id="zcloudKEY" name="zcloudKEY" value="${status.value}"  placeholder="请输入邮箱地址" />
								<form:errors path="zcloudKEY" cssClass="error" />
							</div>
						</spring:bind>
						<spring:bind path="serverAddr">
							<div class="form-group">
								<label for="serverAddr">智云Server：</label>
		              			<input type="text" id="serverAddr" name="serverAddr" value="${status.value}"  placeholder="请输入邮箱地址" />
								<form:errors path="serverAddr" cssClass="error" />
							</div>
						</spring:bind>
						<div class="form-group">
							<label for="textMacList">智云Mac：</label>
							<textarea rows="6" cols="20" class="form-control" id="textMacList" name="textMacList"></textarea>
							<form:errors path="macList" />
						</div>
			            
						<div class="form-button">
		                    &nbsp;<a class="btn submit" href="javascript:editAction()">修改</a>
		                </div>
				</form:form>
	            <!-- /修改用户资料 -->
	            <div class="altContent-shell hide">
            		<i class="icon icon-close" onclick="loadImgClose()"></i>
					<div id="altContent">
						<h1>美图秀秀</h1>
					</div>
	        	</div>
	        </div>
	    </div>
	</section>
</body>
<!---------------------------脚本引用------------------------------>
<%@ include file="/resources/share/script.jsp"%>
<script src="${basePath}/resources/js/xiuxiu.js" type="text/javascript"></script>
<script>
	$(function(){
		var textMacList  = JSON.parse('${editForm.macList}');
		$("#textMacList").val(JSON.stringify(textMacList, null, "\t"));
	});
	
	function editAction() {
		//填充imageUrl
		var imageUrl = $("#imageSrc").attr('src');
		imageUrl = imageUrl.substring(imageUrl.lastIndexOf("/")+1,imageUrl.length);
		$("#imageUrl").val(imageUrl);
		//填充MacList
		var textMacList = JSON.parse($("#textMacList").val());
		textMacList = JSON.stringify(textMacList);
		$("#macList").val(textMacList);
		//提交表单
		var form = document.forms[0];
		form.submit();
	};

	//美图秀秀
	function loadImg(){
		var altContentTop = $("body").height()/2 - 240;
		var altContentLeft = $(".panel").eq(0).width()/2 - 300;
		$(".altContent-shell").eq(0).css({
			"display":"block",
			"top":altContentTop + "px",
			"left":altContentLeft + "px"
		});
		$("#editForm").addClass("filter");
		/*第1个参数是加载编辑器div容器，第2个参数是编辑器类型，第3个参数是div容器宽，第4个参数是div容器高*/
		xiuxiu.embedSWF("altContent",5,"100%","100%");
	    //修改为您自己的图片上传接口
		xiuxiu.setUploadURL("${basePath}/uploadImage");
	    xiuxiu.setUploadType(2);
	    xiuxiu.setUploadDataFieldName("upload_file");
		xiuxiu.onInit = function ()
		{
			xiuxiu.loadPhoto("${basePath}/resources/images/meituxiuxiu.jpg");
		};
		xiuxiu.onUploadResponse = function (data)
		{
//	 		console.log("data:"+JSON);
			if(data != ''){
				var dat = JSON.parse(data);
				console.log("status:"+dat.status);
				console.log("data:"+dat.data);
				console.log("boolean:"+(dat.status == 1));
				if(dat.status == 1){//push成功
					var path = "${basePath}/photo/"+dat.data;
					$("#imageSrc").attr('src',path);
					$(".altContent-shell").eq(0).css("display","none");
					$("#editForm").removeClass("filter");
				}else{
					console.log("提交图片失败!");
				}
			}
		};
	};
</script>
</html>