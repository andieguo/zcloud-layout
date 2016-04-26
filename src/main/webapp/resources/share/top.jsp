<%@ page language="java" contentType="text/html; charset=utf-8"%>
		<header>
			<div id="header_outer" class="nav-box">
				<img src="${basePath }/resources/pic/logo.png" />
		        <ul id="header_menu" class="nav_left">
					<li><a target="_self" href="${basePath }/login.jsp" >首页</a></li>
					<li><a target="_self" href="<s:url action="index" namespace="/"/>">项目案例</a></li>
					<li><a target="_self" href="<s:url action="post" namespace="/"/>">开发指南</a></li>
					<li><a target="_self" href="${basePath }/about.jsp">关于我们</a></li>
					<%if(session.getAttribute("admin")!=null){ %>
					<li><a target="_self"  href="<s:url action="display" namespace="/control/notice"/> ">进入后台</a></li>
					<%}%>
		        </ul>
			</div>
		</header>
