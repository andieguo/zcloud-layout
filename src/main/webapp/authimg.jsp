<%@ page language="java" import="com.zonesion.layout.controller.AuthImgProduct"
 contentType="image/jpeg" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>验证码</title>
<jsp:useBean id="image" scope="page" class="com.zonesion.layout.controller.AuthImgProduct"/>
<%

	String str = image.getImg(80,20,response.getOutputStream());
	//将验证码存入session中
	session.setAttribute("authcode",str);
	out.clear();
	out = pageContext.pushBody();
%>

</head>
</html>