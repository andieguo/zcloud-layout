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
    <style>
    	body {
    		margin: 0;
    		padding: 0;
    		min-height: 500px;
    		width: 100%;
    	}
		#progress-bar {
			position: absolute;
			width: 0;
			height: 2px;
			box-shadow: 0 0 10px #000;
			background-color: blue;
		}
    </style>
</head>
<body>
<div id="progress-bar"></div>
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
						<select id="templateType" onchange="templateTypeChange()">
						  <option value="-1">请选择</option>
	                      <option value="1">用户模板</option>
	                      <option value="0">系统模板</option>
	                    </select>
					</div>
					<div class="form-group">
						<label for="templateList">模板列表：</label>
	              	 	<select id="templateList" onchange="templateIdChange()"></select>
					</div>
					<spring:bind path="zcloudID">
						<div class="form-group">
							<label for="zcloudID">智云ID：</label>
	              			<input type="text" id="zcloudID" name="zcloudID" value="${status.value}"  placeholder="请输入智云ID" />
						</div>
					</spring:bind>
				   	<spring:bind path="zcloudKEY">
						<div class="form-group">
							<label for="zcloudKEY">智云KEY：</label>
	              			<input type="text" id="zcloudKEY" name="zcloudKEY" value="${status.value}"  placeholder="请输入智云KEY" />
						</div>
					</spring:bind>
					<spring:bind path="serverAddr">
						<div class="form-group">
							<label for="serverAddr">智云Server：</label>
	              			<input type="text" id="serverAddr" name="serverAddr" value="${status.value}"  placeholder="请输入智云服务器地址" />
						</div>
					</spring:bind>

					<div class="form-group">
						<label>硬件数据配置：</label>
						<textarea id="json_input" name="json_input" class="json_input"
							style="font-size: 11px !important;" rows="10" spellcheck="false"
							placeholder="请输入正确JSON格式的硬件配置数据"></textarea>
					</div></div>
		            
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

function saveAction() {
	//客户端校验通过才能执行提交
	if(saveValidate()){
		var imageUrl = $("#imageSrc").attr('src');
		imageUrl = imageUrl.substring(imageUrl.lastIndexOf("/")+1,imageUrl.length);
		$("#imageUrl").val(imageUrl);
		$("#tid").val($("#templateList").val());
		//模式二
		var macList = JSON.parse($("#json_input").val());
		//获取到macList后，删除title属性后，构造保存到数据库的JSON数据。
		for(var i=0;i<macList.length;i++){
			delete macList[i]["title"];
		}
		console.log(JSON.stringify(macList));
		$("#macList").val(JSON.stringify(macList));
		var form = document.forms[0];
		form.submit();
	}
}

//模板类型改变事件
function templateTypeChange(){
	var type = $("#templateType").val();
	var url = "${basePath}/project/templateList";
	if(type != -1){
		 $.ajax({//提交给后台
				url : url,
				type : 'post',
				data : {'type':type},
				dataType : 'json',
				beforeSend:function(){
					//这里是开始执行方法，显示效果，效果自己写
					$("#progress-bar").animate({width:'20%'},"slow");
				},
				complete:function(){
					//方法执行完毕，效果自己可以关闭，或者隐藏效果
				},
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
						$("#progress-bar").animate({width:'100%'},"slow");
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

//模板ID改变事件
function templateIdChange(){
	var tid = $("#templateList").val();
	var url = "${basePath}/project/template/id";
	if(tid != -1){
		$.ajax({//提交给后台
				url : url,
				type : 'post',
				data : {'id':tid},
				dataType : 'json',
				beforeSend:function(){
					//这里是开始执行方法，显示效果，效果自己写
					$("#progress-bar").animate({width:'20%'},"slow");
				},
				complete:function(){
					//方法执行完毕，效果自己可以关闭，或者隐藏效果
				},
				success : function(data) {//返回的data本身即是一个JSON对象
					if(data.status == 1){
						//console.log("data:"+data.data);
						var dataJson = JSON.parse(data.data);
						buildJSONTextArea(dataJson);
						$("#progress-bar").animate({width:'100%'},"slow");
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

//JSON数据编辑模式：构造JSON文本域
function buildJSONTextArea(data){
	var sensorArray = new Array();
	$.each(data,function(name,value) {
		if(typeof(value.dataType) != 'undefined'){
			var sensorObj = new Object();
			if(value.dataType == 'video'){
				sensorObj.tid = value.tid;
				sensorObj.title = value.title;
				sensorObj.user = "";
				sensorObj.pwd = "";
				sensorObj.camtype = "";
				sensorObj.address = "";
				sensorObj.dataType = value.dataType;
				sensorArray.push(sensorObj);
			}else{
				sensorObj.tid = value.tid;
				sensorObj.title = value.title;
				sensorObj.address = "";
				sensorObj.channel = "";
				sensorObj.command = {};
				sensorObj.dataType = value.dataType;
				sensorArray.push(sensorObj);
			}
			//console.log("name:"+name+",value:"+value);
			//console.log(sensorArray);
			//去除格式后输出
			//console.log(JSON.stringify(sensorArray));
			//格式化输出
			$("#json_input").val(JSON.stringify(sensorArray,null,"\t"));
		}
	});
}

</script>
</body>
</html>