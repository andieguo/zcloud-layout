<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>智云组态软件</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
	<!-- 页头 -->
    <header class="header">
        <div class="logo">
            <h1 class="name">智云组态仿真软件</h1>
        </div>
        <div class="user">
            <span class="name">${admin.nickname }</span>
            <a class="out" href="${basePath }/admin/outlogin">退出</a>
        </div>
    </header>
    <!-- /页头 -->
<div class="error-content" id="altContent">
	<h1 class="error-title">500</h1>
	<h2 class="error-text">内部服务器错误</h2>
</div>
	<!-- 页尾 -->
    <footer class="footer">中智讯（武汉）科技有限公司版权所有&nbsp;&nbsp;&nbsp;&nbsp;鄂ICP备13015866号-2</footer>
    <!-- /页尾 -->
</body>
</html>