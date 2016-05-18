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
            <spring:url value="/project/add" var="userActionUrl" />
			<form:form method="post" modelAttribute="editForm" action="${userActionUrl}">
					<form:hidden path="macList"/>
					<form:hidden path="imageUrl"/>
					<form:hidden path="tid"/>
					<spring:bind path="name">
						<div class="form-group">
							<label for="name">项目名：</label>
							<input id="name" name="name"  value="${status.value}" type="text"  class="form-control" placeholder="请输入账号" >
							<form:errors path="name" cssClass="error" />
						</div>
					</spring:bind>
					<div class="form-group">
						<label for="imageSrc">项目图片：</label>
						<img class="pic" alt="" id="imageSrc" name="imageSrc" src="${basePath }/photo/MT_1463132423427.jpg" >
						<a class="btn" href="javascript:loadImg()" target="_blank">上产图片</a>
					</div>
					<div class="form-group">
						<label>模板类型：</label>
						<select id="templateType" onchange="templateTypeChange()">
						  <option value="-1">请选择</option>
	                      <option value="1">用户模板</option>
	                      <option value="0">系统模板</option>
	                    </select>
					</div>
					<div class="form-group">
						<label for="templateList">模板列表：</label>
	              	 	<select id="templateList" onchange="templateIdChange()"></select>
	              	 	 <form:errors path="tid" cssClass="error" />
					</div>
					<spring:bind path="zcloudID">
						<div class="form-group">
							<label for="zcloudID">智云ID：</label>
	              			<input type="text" class="form-control " id="zcloudID" name="zcloudID" value="${status.value}"  placeholder="请输入邮箱地址" />
							<form:errors path="zcloudID" cssClass="error" />
						</div>
					</spring:bind>
				   	<spring:bind path="zcloudKEY">
						<div class="form-group">
							<label for="zcloudKEY">智云KEY：</label>
	              			<input type="text" class="form-control " id="zcloudKEY" name="zcloudKEY" value="${status.value}"  placeholder="请输入邮箱地址" />
							<form:errors path="zcloudKEY" cssClass="error" />
						</div>
					</spring:bind>
					<spring:bind path="serverAddr">
						<div class="form-group">
							<label for="serverAddr">智云Server：</label>
	              			<input type="text" class="form-control " id="serverAddr" name="serverAddr" value="${status.value}"  placeholder="请输入邮箱地址" />
							<form:errors path="serverAddr" cssClass="error" />
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
	                    &nbsp;<a class="btn" href="javascript:saveAction()">保存</a>
	                </div>
			</form:form>
            <!-- /修改用户资料 -->
			<div id="altContent">
				<h1>美图秀秀</h1>
			</div>
        </div>
    </div>
</section>
<script src="${basePath}/resources/js/xiuxiu.js" type="text/javascript"></script>
<script type="text/javascript">

var dataJson;

function saveValidate(){
	var namepass=true,idpass=true,keypass=true,addrpass=true,typepass=true,tidpass=true;
	var name = $("#name").val();
	var zcloudID = $("#zcloudID").val();
	var zcloudKEY = $("#zcloudKEY").val();
	var serverAddr = $("#serverAddr").val();
	var templateType = $("#templateType").val();
	var tid = $("#templateList").val();
	if(name == ""){
		namepass = false;
		console.log("项目名不能为空");
	}
	if(zcloudID == ""){
		idpass = false;
		console.log("智云ID不能为空");
	}
	if(zcloudKEY == ""){
		keypass = false;
		console.log("智云KEY不能为空");
	}
	if(serverAddr == ""){
		addrpass = false;
		console.log("智云服务器地址不能为空");
	}
	if(templateType == -1){
		typepass = false;
		console.log("请选择模板类型");
	}
	if(tid == null || tid == -1){
		tidpass = false;
		console.log("模板ID不能为空");
	}
	return namepass && idpass && keypass && addrpass && typepass && tidpass;
}

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

function templateIdChange(){
	var tid = $("#templateList").val();
	var url = "${basePath}/project/template/id";
	if(tid != -1){
		$.ajax({//提交给后台
				url : url,
				type : 'post',
				data : {'id':tid},
				dataType : 'json',
				success : function(data) {//返回的data本身即是一个JSON对象
					if(data.status == 1){
						console.log("data:"+data.data);
						dataJson = JSON.parse(data.data);
						contentBuild(dataJson);
						configNavActive();
					}else if(data.status==0){
						console.log("failed");
					}
				},
				error : function() {
					alert("您请求的页面有异常 ");
				}
		});
	}
}

function macListBuild(dataJson){
	//提交，生成JSON数据保存
	var sensorAarry = new Array();
	$(".sensor").each(function(){
		var sensorObj = new Object();
		var tid = $(this).attr("id");
		sensorObj.tid = tid;
		sensorObj.title =  dataJson[tid].title;
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
		sensorObj.title =  dataJson[tid].title;
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

function contentBuild(dataJson){
	//加载title
	var content = "<div class='head'>";
	$.each(dataJson,function(name,value) {
		if(typeof(value.dataType) != 'undefined'){
			content = content + "<a>"+ value.title+"</a>";
		}
	});
	content = content + "</div>";
	//加载content	
	$.each(dataJson,function(name,value) {
		if(typeof(value.dataType) != 'undefined'){
			if(value.dataType == 'video'){
				content = content + "<div class='video body hide' id="+value.tid+">"
				 + "<label>摄像头地址：</label><input type='text' value='Camera:192.168.1.91:81' class='address'><hr>"
				 + "<label>用户名：</label><input type='text' value='admin' class='user'><hr>"
				 + "<label>密码：</label><input type='text' value='admin' class='pwd'><hr>"
				 + "<label>摄像头类型：</label><input type='text' value='H3-Series' class='camtype'>"
				 + "</div>";
			}else{
				content = content + "<div class='sensor body hide' id="+value.tid+">"
				 + "<label>地址：</label><input type='text' value='' class='address'><hr>"
				 + "<label>通道：</label><input type='text' value='' class='channel'><hr>"
				 + "<label>命令：</label><input type='text' value='' class='command'>"
				 + "</div>";		
			}
		}
	});
	$("#config").html(content);
}

function templateTypeChange(){
	var type = $("#templateType").val();
	var url = "${basePath}/project/templateList";
	if(type != -1){
		 $.ajax({//提交给后台
				url : url,
				type : 'post',
				data : {'type':type},
				dataType : 'json',
				success : function(data) {//返回的data本身即是一个JSON对象
					if(data.status == 1){//push成功
						var array = data.data[0];
						$('#templateList').empty();
						$('#templateList').append("<option value='-1'>请选择</option>");
						for(var i=0;i<array.length;i++){
							var tid = array[i].tid;
							var name = array[i].name;
// 							console.log("tid:"+tid);
							$('#templateList').append("<option value='"+tid+"'>"+name+"</option>");
						}
					}else if(data.status==0){//push失败，恢复UI部分
						console.log("failed");
					}
				},
				error : function() {
					alert("您请求的页面有异常 ");
				}
		});
	}else{
		$('#templateList').empty();
	}
}

function loadImg(){
	/*第1个参数是加载编辑器div容器，第2个参数是编辑器类型，第3个参数是div容器宽，第4个参数是div容器高*/
	xiuxiu.embedSWF("altContent",5,"100%","500");
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
// 		console.log("data:"+JSON);
		if(data != ''){
			var dat = JSON.parse(data);
			console.log("status:"+dat.status);
			console.log("data:"+dat.data);
			console.log("boolean:"+(dat.status == 1));
			if(dat.status == 1){//push成功
				var path = "${basePath}/photo/"+dat.data;
				$("#imageSrc").attr('src',path); 
			}else{
				console.log("提交图片失败!");
			}
		}
	};
	
}
</script>
</body>
</html>