<%@ page language="java" contentType="text/html; charset=utf-8" import="com.zonesion.layout.model.AdminEntity" isELIgnored="false"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="zh-CN">
<head>
	<title>模板列表</title>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="${basePath }/resources/css/style.css">
    <script src="${basePath }/resources/js/jquery2.2.1.min.js"></script>
    <script src="${basePath }/resources/js/list.js"></script>
</head>
<body>
<section class="main content">
	<%
    	HttpSession sessions = request.getSession();
    	AdminEntity admin = (AdminEntity)sessions.getAttribute("admin");
   	%>
	<spring:url value="/template/list" var="userActionUrl" />
	<form:form class="h100" method="post" modelAttribute="templateForm" action="${userActionUrl}">
		<form:hidden path="page" />
		<form:hidden path="id" />
		<form:hidden path="deleted" />
		<form:hidden path="type" />
		<header class="table-header clearfix">
			<div class="header-right">
          			 <a class="font-green" href="${basePath }/template/addUI?type=${templateForm.type}" target="_blank">新建</a>
    			</div>
			<div class="header-left">
				<label>用户：</label> 
				<form:input path="nickname"/>
	            <label>模板名：</label>
	            <form:input path="name"/>
				<label>启/停用：</label>
				<form:select path="visible" items="${enableList}" class="form-control" />
				<a href="javascript:queryAction()" class="font-green" >搜索</a>
				<a href="javascript:deleteAction()" class="font-green" href="#">批量删除</a>
				<input type="file" name="templateFile" size="50" /><a href="javascript:importAction()" class="font-green" >导入</a>
			</div>
		</header>
	    <div class="table-body">
	        <table class="table table-striped">
				<thead>
					<tr>
						<th class="text-left"><input name="chkAll" id="chkAll" title="全选" onClick="ChkAllClick('keyIds','chkAll')" type="checkbox" /><tt>ID</tt></th>
						<th>模板名</th>
						<th>用户名</th>
						<th>模板类型</th>
						<th>创建时间</th>
						<th>修改时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageView.records}" var="entry">
						<tr>
							<td class="text-left"><input name="keyIds" type="checkbox"  value='${entry.id}' onclick="ChkSonClick('keyIds','chkAll')" /><tt>${entry.id }</tt></td>
							<td>${entry.name }</td>
							<td>${entry.nickname }</td>
							<td>
								<c:if test="${entry.type==0}">系统模板</c:if>
								<c:if test="${entry.type==1}">用户模板</c:if>
							</td>
							<td>${entry.createTime }</td> 
							<td>${entry.modifyTime }</td> 
							<td>
								<a href="${basePath}/template/editUI?id=${entry.id}" target="_blank" class="font-green">修改</a>
								<a href="javascript:enableAction(${entry.id},${entry.type})" id="enable_${entry.id }" class="font-red" visible="${entry.visible==0?1:0}">
									<c:if test="${entry.visible==0}">启用</c:if>
									<c:if test="${entry.visible==1}">停用</c:if>
								</a>
								<a href="${basePath}/template/export?id=${entry.id}" class="font-green">导出</a>
							</td>   
		      			</tr>
		      		</c:forEach>
				<tbody>
				<tfoot>
					<tr>
						<td colspan="7">
      						<%@ include file="/WEB-INF/share/page.jsp" %>
				    	</td>
					</tr>
				</tfoot>
	        </table>
	    </div>
	</form:form>
</section>

<!---------------------------脚本引用------------------------------>
		<%@ include file="/resources/share/script.jsp"%>
		<script src="<%=basePath %>/resources/js/checkbox.js" type="text/javascript"></script>
		<script language="JavaScript">
			function importAction(){
				var form = document.forms[0];
				form.action="${basePath}/template/import?type=${type}";
				form.enctype="multipart/form-data";
				form.submit();
			}
			function queryAction(){
				var form = document.forms[0];
				document.getElementById("page").value = 1;
				form.submit();
			}
			function modifyAction(id){
				var form = document.forms[0];
				form.action="${basePath}/template/editUI";
				form.method = "get";
				document.getElementById("id").value = id;
				form.submit();
			}
			//使能用户
			function enableAction(id,type){
				var url = "${basePath}/template/enable";
				var status = $("#enable_"+id).attr("visible");
				if(status == 1){
					alert("亲，确定要执行启用操作么？");
				}else if(status == 0){
					alert("亲，确认要执行停用操作么？");
				}
				$.ajax({//提交给后台
						url : url,
						type : 'post',
						data : {'id':id,'type':type,'deleted':status},
						dataType : 'json',
						success : function(data) {//返回的data本身即是一个JSON对象
							if(data.status == 1){//push成功
								if(status == 1){
									$("#enable_"+id).attr("visible",0);
									$('#enable_'+id).text("停用");
								}else if(status == 0){
									$("#enable_"+id).attr("visible",1);
									$('#enable_'+id).text("启用");
								}
							}else if(data.status==0){//push失败，恢复UI部分
								console.log("failed");
							}
						},
						error : function() {
							alert("您请求的页面有异常 ");
						}
				});
			}
			function deleteAction(){
				var value=0;
				$("input[name='keyIds']").each(function () {
					if(this.checked){
						var form = document.forms[0];
						form.action="${basePath}/template/delete";
						form.submit();
						value=1;
					}
				});
				if(!value){alert("请选择删除项");};
			}
		</script>
</body>
</html>