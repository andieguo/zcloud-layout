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
        <div class="panel" style="min-height:916px;">
            <spring:url value="/project/add" var="userActionUrl" />
			<form:form method="post" modelAttribute="editForm" action="${userActionUrl}">
					<form:hidden path="macList"/>
					<form:hidden path="imageUrl"/>
					<form:hidden path="tid"/>
					<spring:bind path="name">
						<div class="form-group">
							<label for="name">项目名：</label>
							<input id="name" name="name"  value="${status.value}" type="text" placeholder="请输入项目名称" >
						</div>
					</spring:bind>
					<div class="form-group">
						<label for="imageSrc">项目图片：</label>
						<img class="pic" alt="" id="imageSrc" name="imageSrc" src="${basePath}/resources/images/meituxiuxiu.jpg" >
						<a class="btn" href="javascript:loadImg('${basePath}')">上传图片</a>
					</div>
					<spring:bind path="titleContent">
						<div class="form-group">
							<label for="titleContent">项目头详细信息：</label>
							<textarea rows="2" cols="1" id="titleContent" name="titleContent"  value="${status.value}"  placeholder="请输入项目头详细信息"></textarea>
						</div>
					</spring:bind>
					<spring:bind path="footContent">
						<div class="form-group">
							<label for="footContent">项目尾详细信息：</label>
							<input id="footContent" name="footContent"  value="${status.value}" type="text" placeholder="请输入项目尾详细信息" >
						</div>
					</spring:bind>
					<div class="form-group">
						<label>模板类型：</label>
						<select id="templateType" onchange="templateTypeChange('${basePath}/project/templateList')">
						  <option value="-1">请选择</option>
	                      <option value="1">用户模板</option>
	                      <option value="0">系统模板</option>
	                    </select>
					</div>
					<div class="form-group">
						<label for="templateList">模板列表：</label>
	              	 	<select id="templateList" onchange="templateIdChange('${basePath}/project/template/id')"></select>
					</div>
					<spring:bind path="zcloudID">
						<div class="form-group">
							<label for="zcloudID">智云ID：</label>
	              			<input type="text" id="zcloudID" name="zcloudID" value="${status.value}"  placeholder="请输入邮箱地址" />
						</div>
					</spring:bind>
				   	<spring:bind path="zcloudKEY">
						<div class="form-group">
							<label for="zcloudKEY">智云KEY：</label>
	              			<input type="text" id="zcloudKEY" name="zcloudKEY" value="${status.value}"  placeholder="请输入邮箱地址" />
						</div>
					</spring:bind>
					<spring:bind path="serverAddr">
						<div class="form-group">
							<label for="serverAddr">智云Server：</label>
	              			<input type="text" id="serverAddr" name="serverAddr" value="${status.value}"  placeholder="请输入邮箱地址" />
						</div>
					</spring:bind>

					<div class="form-group">
		                <label>硬件数据配置：</label>
		                <div id="config" class="config">
		                	<div class="head">
		                		<a>温度</a>
		                	</div>
		                	<div class="sensor body" id="fs_dial_978771">
		                	<label>地址：</label><input type="text" value="" class="address"><hr>
		                	<label>通道：</label><input type="text" value="" class="channel"><hr>
		                	<label>命令：</label><input type="text" value="" class="command">
		                	</div>
		                </div>
		            </div>
		            
					 <div class="form-button">
	                    &nbsp;<a class="btn submit" href="javascript:saveAction()">保存</a>
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
<script src="${basePath}/resources/js/xiuxiu.js" type="text/javascript"></script>
<script src="${basePath}/resources/js/addProject.js" type="text/javascript"></script>
<script type="text/javascript">

var dataJson;

function saveAction() {
	//客户端校验通过才能执行提交
	if(saveValidate()){
		var imageUrl = $("#imageSrc").attr('src');
		imageUrl = imageUrl.substring(imageUrl.lastIndexOf("/")+1,imageUrl.length);
		$("#imageUrl").val(imageUrl);
		$("#tid").val($("#templateList").val());
		var macList = macListBuild(dataJson);
		$("#macList").val(JSON.stringify(macList));
		var form = document.forms[0];
		form.submit();
	}
}

//构造后台保存的JSON数据
function macListBuild(dataJson){
	//提交，生成JSON数据保存
	var sensorAarry = new Array();
	$(".sensor").each(function(){
		var sensorObj = new Object();
		var tid = $(this).attr("id");
		sensorObj.tid = tid;
		//sensorObj.title =  dataJson[tid].title;
		sensorObj.channel = $(this).find(".channel").val();
		sensorObj.command = JSON.parse($(this).find(".command").val());
		sensorObj.address = $(this).find(".address").val();
		sensorObj.dataType = dataJson[tid].dataType;
		sensorAarry.push(sensorObj);
	});
	$(".video").each(function(){
		var tid = $(this).attr("id");
		var sensorObj = new Object();
		sensorObj.tid = tid;
		//sensorObj.title =  dataJson[tid].title;
		sensorObj.user = $(this).find(".user").val();
		sensorObj.pwd = $(this).find(".pwd").val();
		sensorObj.camtype = $(this).find(".camtype").val();
		sensorObj.address = $(this).find(".address").val();
		sensorObj.dataType = dataJson[tid].dataType;
		sensorAarry.push(sensorObj);
	});
	console.log(sensorAarry);
	return sensorAarry;
}
</script>
</body>
</html>