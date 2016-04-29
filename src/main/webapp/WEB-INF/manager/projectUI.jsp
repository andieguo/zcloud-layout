<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<title>项目发布</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="keywords" content="智云物联,物联网云计算公共应用开放平台"/>
		<meta name="description" content="公共物联网应用接入,实现远程数据的采集与分析,实现设备的实时控制与自动控制."/>
		<!--************************样式引用************************-->
	</head>
	<body>
		<div id="body" class="banner">
		<div>${projectEntity.id }</div>
		<div>${projectEntity.zcloudID }</div>
		<div>${projectEntity.zcloudKEY }</div>
		<div>${projectEntity.serverAddr }</div>
		<div>${projectEntity.macList }</div>
		</div>
		<script language="JavaScript"> 	
		</script>
	</body>
</html>