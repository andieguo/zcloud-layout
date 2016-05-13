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
			<form:form class="wc600" method="post" modelAttribute="projectForm" action="${userActionUrl}">
					<spring:bind path="name">
						<div class="form-group">
							<label for="name">项目名:</label>
							<input id="name" name="name"  value="${status.value}" type="text"  class="form-control" placeholder="请输入账号" >
							<form:errors path="name" cssClass="error" />
						</div>
					</spring:bind>
					<spring:bind path="imageUrl">
						<div class="form-group">
							<label for="imageUrl">项目图片</label>
							<img alt="" id="imageUrl" name="imageUrl" src="${basePath }/photo/MT_1463132423427.jpg" >
							<a href="javascript:loadImg()" target="_blank">请选择图片</a>
						</div>
					</spring:bind>
					<div class="form-group">
						<label>模板类型:</label>
						<select id="templateType" onchange="templateTypeChange()">
						  <option value="-1">请选择</option>
	                      <option value="1">用户模板</option>
	                      <option value="0">系统模板</option>
	                    </select>
					</div>
					<spring:bind path="tid">
						<div class="form-group">
							<label for="tid">模板列表:</label>
		              	 	<select id="templateList"></select>
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
					 <div class="form-button">
	                    &nbsp;<button class="btn" type="submit">保存</button>
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
						console.log("success");
						var array = data.data[0];
						$('#templateList').empty();
						for(var i=0;i<array.length;i++){
							var tid = array[i].tid;
							var name = array[i].name;
							console.log("tid:"+tid);
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
		console.log("data:"+JSON);
		if(data != ''){
			var dat = JSON.parse(data);
			console.log("status:"+dat.status);
			console.log("data:"+dat.data);
			console.log("boolean:"+(dat.status == 1));
			if(dat.status == 1){//push成功
				var path = "${basePath}/photo/"+dat.data;
				$("#imageUrl").attr('src',path); 
			}else{
				console.log("--");
			}
		}
	};
	
}
</script>
</body>
</html>