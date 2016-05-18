<%@ page language="java" contentType="text/html; charset=utf-8" import="com.zonesion.layout.model.AdminEntity" isELIgnored="false"%>
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
    <section class="banner">
        <div class="content">
            <h1 class="banner-title">Zonesion ( Wuhan )<br>Technology<br>Co.,Ltd</h1>
            <button class="banner-more">了解更多 >></button>
        </div>
    	<img class="banner-img" src="${basePath }/resources/images/banner.jpg" alt="">
    </section>
    <section class="content index-main">
    	<h1>项目列表</h1>
        <div class="hr">~~~~~~~~~~~~~~ : : ~~~~~~~~~~~~~~</div>
    	<ul class="proList clearfix" id="projectList">
    		<li>
            <a href="#" target="_blank">
                <img src="images/object-img.jpg" alt="项目名称项目名称" title="项目名称项目名称">
                <h2>项目名称项目名称</h2>
            </a>
            </li>
            
    	</ul>
    </section>
    <footer>中智讯（武汉）科技有限公司版权所有 鄂ICP备13015866号-2</footer>
    <script src="${basePath }/resources/js/jquery2.2.1.min.js"></script>
    <script>
    	$(function(){
    		var url = '${basePath}/project/all';
    		 $.ajax({//提交给后台
 				url : url,
 				type : 'post',
 				data : {},
 				dataType : 'json',
 				success : function(data) {//返回的data本身即是一个JSON对象
 					if(data.status == 1){//push成功
 						var array = data.data[0];
 						$('#projectList').empty();
                        var content = "";
 						for(var i=0;i<array.length;i++){
                            var id = array[i].id;
                            var name = array[i].name;
                            var imageUrl = '${basePath}/photo/' + array[i].imageUrl;
                            var publishUrl  = '${basePath}/project/publish?id='+id;
                            content = content + "<li><a href="+publishUrl+" target='_blank'>"
                            + "<img src="+imageUrl+" alt="+name+" title="+name+"></img>"
                            + "<h2>"+name+"</h2></a></li>";  
 						}
                        $('#projectList').append(content);
 					}else if(data.status==0){//push失败，恢复UI部分
 						console.log("failed");
 					}
 				},
 				error : function() {
 					alert("您请求的页面有异常 ");
 				}
 		});
    	});
    </script>
</body>
</html>