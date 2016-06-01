<%@ page language="java" contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ include file="/WEB-INF/share/taglib.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="title" content="智云组态软件">
<meta name="description" content="智云组态软件">
<meta name="keywords" content="智云组态软件">
<title>智云组态软件</title>

<!-- Le styles -->
<link href="${basePath }/resources/layoutit/css/bootstrap-combined.min.css" rel="stylesheet">
<link href="${basePath }/resources/layoutit/css/layoutit-edit.css" rel="stylesheet">
<link href="${basePath }/resources/layoutit/css/style.css" rel="stylesheet">

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
		<script src="js/html5shiv.js"></script>
	<![endif]-->

<!-- Fav and touch icons -->

<script type="text/javascript" src="${basePath }/resources/layoutit/js/jquery-2.0.0.min.js"></script>
<!--[if lt IE 9]>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<![endif]-->
<script type="text/javascript" src="${basePath }/resources/layoutit/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${basePath }/resources/layoutit/js/jquery-ui.js"></script>
<script type="text/javascript" src="${basePath }/resources/layoutit/js/jquery.ui.touch-punch.min.js"></script>
<script type="text/javascript" src="${basePath }/resources/layoutit/js/jquery.htmlClean.js"></script>
<script type="text/javascript" src="${basePath }/resources/layoutit/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${basePath }/resources/layoutit/js/ckeditor/config.js"></script>

<!--highcharts-->
<script type="text/javascript" src="${basePath }/resources/layoutit/js/highcharts/highcharts.js" ></script>
<script type="text/javascript" src="${basePath }/resources/layoutit/js/highcharts/highcharts-more.js" ></script>
<!--fusioncharts-->
<script type="text/javascript" src="${basePath }/resources/layoutit/js/fusioncharts/fusioncharts.js"></script>
<script type="text/javascript" src="${basePath }/resources/layoutit/js/fusioncharts/themes/fusioncharts.theme.fint.js"></script>
<script type="text/javascript" src="${basePath }/resources/layoutit/js/fusioncharts/fusioncharts-index.js"></script>

<script>
<!--自定义UI模板配置全局变量--> 
var basePath = "${basePath}";
var layoutitPath = basePath + "/resources/layoutit/";

var uiTemplateObj;
var method = "${method}";

function importAction(){
	var templateFile = $("#templateFile").val();
	if(templateFile != ""){
		var form = document.forms[0];
		//multipart/form-data使得后台无法获取header中的参数，故添加type到head头中
		form.action="${basePath}/template/importUI?type=${type}";
		form.enctype="multipart/form-data";
		form.submit();
	}else{
		alert("导入文件不能为空!");
		return;
	}
}

/**将编辑页面内容中的控件UI部分清空**/
function removeWidgetUI(){
	for(var i in uiTemplateObj){
		if(i.indexOf("layout") < 0 ){//若是布局控件则忽略此次操作
			$("#"+i).html("");	
		}		
	}
}

/**获取layoutContent**/
function getLayoutContent(){
	removeWidgetUI();//先清除控件的UI部分
	var layoutContent = $(".demo").html();//layoutContent.replace(/'/g, '"')
	layoutContent = layoutContent.replace(/\'/g,'&#39;');
	layoutContent = htmlCompress(layoutContent);
	return layoutContent;
}

function pushAjax(url,pushdata,locationHref){
	 $.ajax({//提交给后台
			url : url,
			type : 'post',
			data : pushdata,
			dataType : 'json',
			success : function(data) {//返回的data本身即是一个JSON对象
				console.log("data.status:"+data.status);
				console.log("data.message:"+data.message);
				if(data.status == 1){//push成功
					console.log("success");
					window.location.href = locationHref;//页面跳转
				}else if(data.status==0){//push失败，恢复UI部分
					console.log("failed");
					resumeWidgetUI(uiTemplateObj);
				}
			},
			error : function() {
				alert("您请求的页面有异常 ");
			}
	});
}

/*将控件的配置、UI保存到后台*/  
function pushTemplate(){
	var templateName = $("#templateName").val();
	if(templateName != ""){
		var layoutJSON =  JSON.stringify(uiTemplateObj);
		var layoutContent = getLayoutContent();
		if(method == 'save'){
			var url = "${basePath}/template/save";
			var locationHref = "${basePath}/template/tolist?type=${type}";
			var pushdata = {'name':templateName,'layoutJSON':layoutJSON,'layoutContent':layoutContent,'type':'${type}'};
			pushAjax(url,pushdata,locationHref);
		}else if(method == 'edit'){
			var url = "${basePath}/template/edit";
			var templateId = "${templateEntity.id}";
			var locationHref = "${basePath}/template/tolist?type=${type}";
			var pushdata = {'id':templateId,'name':templateName,'layoutJSON':layoutJSON,'layoutContent':layoutContent};
			pushAjax(url,pushdata,locationHref);
		}
	}else{
		alert("模板名不能为空");
	}
}

$(function(){
	var layoutJSON = '${templateEntity.layoutJSON}'; 
	var content = '${templateEntity.layoutContent}';
	//初始化模板UI属性缓存对象
	uiTemplateObj = {};
    initTemplateUI(layoutJSON,content);
})
</script>

</head>

<body style="min-height: 660px; cursor: auto;" class="edit">
<div class="navbar navbar-inverse navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container-fluid">
      <button data-target=".nav-collapse" data-toggle="collapse" class="btn btn-navbar" type="button"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
      <a class="brand"><img src="${basePath }/resources/layoutit/images/favicon.png"> 可视化布局</a>
      <div class="nav-collapse collapse">
      	<ul class="nav" id="menu-layoutit">
          <li class="divider-vertical"></li>
          <li>
            <div class="btn-group" data-toggle="buttons-radio">
              <button type="button" id="edit" class="btn btn-primary active"><i class="icon-edit icon-white"></i>编辑</button>
              <button type="button" class="btn btn-primary" id="devpreview"><i class="icon-eye-close icon-white"></i>布局编辑</button>
              <button type="button" class="btn btn-primary" id="sourcepreview"><i class="icon-eye-open icon-white"></i>预览</button>
            </div>
            <div class="btn-group">
              <button type="button" class="btn btn-primary" data-target="#downloadModal" rel="/build/downloadModal" role="button" data-toggle="modal"><i class="icon-chevron-down icon-white"></i>下载</button>
              <button class="btn btn-primary" href="#" role="button" data-toggle="modal" data-target="#shareModal"><i class="icon-share icon-white"></i>保存</button>
              <button class="btn btn-primary" href="#clear" id="clear"><i class="icon-trash icon-white"></i>清空</button>
            </div>
            <div class="btn-group">
            	<input type="text" id="templateName" name="templateName" value="${templateEntity.name}"></input>
				<form class="h100" method="post" >
					<input type="file" id="templateFile" name="templateFile" size="50" />
					<button class="btn btn-primary" onclick="importAction()" id="clear"><i class="icon-trash icon-white"></i>导入</button>
				</form>
            </div>
          </li>
        </ul>
        <ul class="nav pull-right">
            <li>
             	  <div class="btn-group"> </div>
	      	</li>
          </ul>
      </div>
      <!--/.nav-collapse --> 
    </div>
  </div>
</div>
<div class="container">
  <div class="row-fluid">
    <div class="">
      <div class="sidebar-nav">
        <ul class="nav nav-list accordion-group">
          <li class="nav-header">
            <div class="pull-right popover-info"><i class="icon-question-sign "></i>
              <div class="popover fade right">
                <div class="arrow"></div>
                <h3 class="popover-title">功能</h3>
                <div class="popover-content">在这里设置你的栅格布局, 栅格总数默认为12, 用空格分割每列的栅格值, 如果您需要了解更多信息，请访问<a target="_blank" href="http://twitter.github.io/bootstrap/scaffolding.html#gridSystem">Bootstrap栅格系统.</a></div>
              </div>
            </div>
            <i class="icon-plus icon-white"></i> 布局设置 </li>
          <li style="display: list-item;" class="rows nav-body" id="estRows">
            <div class="lyrow ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
              <div class="preview">
                <input value="12" type="text">
              </div>
              <div class="view">
                <div class="row-fluid clearfix">
                  <div class="span12 column"></div>
                </div>
              </div>
            </div>
            <div class="lyrow ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
              <div class="preview">
                <input value="6 6" type="text">
              </div>
              <div class="view">
                <div class="row-fluid clearfix">
                  <div class="span6 column"></div>
                  <div class="span6 column"></div>
                </div>
              </div>
            </div>
            <div class="lyrow ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
              <div class="preview">
                <input value="8 4" type="text">
              </div>
              <div class="view">
                <div class="row-fluid clearfix">
                  <div class="span8 column"></div>
                  <div class="span4 column"></div>
                </div>
              </div>
            </div>
            <div class="lyrow ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
              <div class="preview">
                <input value="4 4 4" type="text">
              </div>
              <div class="view">
                <div class="row-fluid clearfix">
                  <div class="span4 column"></div>
                  <div class="span4 column"></div>
                  <div class="span4 column"></div>
                </div>
              </div>
            </div>
            <div class="lyrow ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
              <div class="preview">
                <input value="2 6 4" type="text">
              </div>
              <div class="view">
                <div class="row-fluid clearfix">
                  <div class="span2 column"></div>
                  <div class="span6 column"></div>
                  <div class="span4 column"></div>
                </div>
              </div>
            </div>
          </li>
        </ul>
        <!-- <ul class="nav nav-list accordion-group">
          <li class="nav-header"><i class="icon-plus icon-white"></i> 基本CSS
            <div class="pull-right popover-info"><i class="icon-question-sign "></i>
              <div class="popover fade right">
                <div class="arrow"></div>
                <h3 class="popover-title">帮助</h3>
                <div class="popover-content">这里提供了一系列基本元素样式，你可以通过区块右上角的编辑按钮修改样式设置。如需了解更多信息，请访问<a target="_blank" href="http://twitter.github.io/bootstrap/base-css.html">基本CSS.</a></div>
              </div>
            </div>
          </li>
          <li class="boxes nav-body" id="elmBase">
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> 
            	 <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">对齐 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="active"><a href="#" rel="">默认</a></li>
                <li class=""><a href="#" rel="text-left">靠左</a></li>
                <li class=""><a href="#" rel="text-center">居中</a></li>
                <li class=""><a href="#" rel="text-right">靠右</a></li>
              </ul>
              </span> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">标记 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="active"><a href="#" rel="">默认</a></li>
                <li class=""><a href="#" rel="muted">禁用</a></li>
                <li class=""><a href="#" rel="text-warning">警告</a></li>
                <li class=""><a href="#" rel="text-error">错误</a></li>
                <li class=""><a href="#" rel="text-info">提示</a></li>
                <li class=""><a href="#" rel="text-success">成功</a></li>
              </ul>
              </span> </span>
              <div class="preview">标题栏</div>
              <div class="view">
                <h3 contenteditable="true">h3. 这是一套可视化布局系统.</h3>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">对齐 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="active"><a href="#" rel="">默认</a></li>
                <li class=""><a href="#" rel="text-left">靠左</a></li>
                <li class=""><a href="#" rel="text-center">居中</a></li>
                <li class=""><a href="#" rel="text-right">靠右</a></li>
              </ul>
              </span> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">标记 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="active"><a href="#" rel="">默认</a></li>
                <li class=""><a href="#" rel="muted">禁用</a></li>
                <li class=""><a href="#" rel="text-warning">警告</a></li>
                <li class=""><a href="#" rel="text-error">错误</a></li>
                <li class=""><a href="#" rel="text-info">提示</a></li>
                <li class=""><a href="#" rel="text-success">成功</a></li>
              </ul>
              </span> <a class="btn btn-mini" href="#" rel="lead">Lead</a> </span>
              <div class="preview">段落</div>
              <div class="view" contenteditable="true">
                <p><em>Git</em>是一个分布式的版本控制系统，最初由<b>Linus Torvalds</b>编写，用作Linux内核代码的管理。在推出后，Git在其它项目中也取得了很大成功，尤其是在Ruby社区中。 </p>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
              <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button></span>
              <div class="preview">地址</div>
              <div class="view">
                <address contenteditable="true">
                <strong>Twitter, Inc.</strong><br>
                795 Folsom Ave, Suite 600<br>
                San Francisco, CA 94107<br>
                <abbr title="Phone">P:</abbr> (123) 456-7890
                </address>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"> <a class="btn btn-mini" href="#" rel="pull-right">右对齐</a> </span>
              <div class="preview">引用块</div>
              <div class="view clearfix">
                <blockquote contenteditable="true">
                  <p>github是一个全球化的开源社区.</p>
                  <small>关键词 <cite title="Source Title">开源</cite></small> </blockquote>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <a class="btn btn-mini" href="#" rel="unstyled">无样式</a> <a class="btn btn-mini" href="#" rel="inline">嵌入</a> </span>
              <div class="preview">无序列表</div>
              <div class="view">
                <ul contenteditable="true">
                  <li>新闻资讯</li>
                  <li>体育竞技</li>
                  <li>娱乐八卦</li>
                  <li>前沿科技</li>
                  <li>环球财经</li>
                  <li>天气预报</li>
                  <li>房产家居</li>
                  <li>网络游戏</li>
                </ul>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <a class="btn btn-mini" href="#" rel="unstyled">无样式</a> <a class="btn btn-mini" href="#" rel="inline">嵌入</a> </span>
              <div class="preview">有序列表</div>
              <div class="view">
                <ol contenteditable="true">
                  <li>新闻资讯</li>
                  <li>体育竞技</li>
                  <li>娱乐八卦</li>
                  <li>前沿科技</li>
                  <li>环球财经</li>
                  <li>天气预报</li>
                  <li>房产家居</li>
                  <li>网络游戏</li>
                </ol>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <a class="btn btn-mini" href="#" rel="dl-horizontal">竖向对齐</a> </span>
              <div class="preview">详细描述</div>
              <div class="view">
                <dl contenteditable="true">
                  <dt>Rolex</dt>
                  <dd>劳力士创始人为汉斯.威尔斯多夫，1908年他在瑞士将劳力士注册为商标。</dd>
                  <dt>Vacheron Constantin</dt>
                  <dd>始创于1775年的江诗丹顿已有250年历史，</dd>
                  <dd>是世界上历史最悠久、延续时间最长的名表之一。</dd>
                  <dt>IWC</dt>
                  <dd>创立于1868年的万国表有“机械表专家”之称。</dd>
                  <dt>Cartier</dt>
                  <dd>卡地亚拥有150多年历史，是法国珠宝金银首饰的制造名家。</dd>
                </dl>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">样式 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="active"><a href="#" rel="">默认</a></li>
                <li class=""><a href="#" rel="table-striped">条纹</a></li>
                <li class=""><a href="#" rel="table-bordered">边框</a></li>
              </ul>
              </span> <a class="btn btn-mini" href="#" rel="table-hover">鼠标指示</a> <a class="btn btn-mini" href="#" rel="table-condensed">紧凑</a> </span>
              <div class="preview">表格</div>
              <div class="view">
                <table class="table" contenteditable="true">
                  <thead>
                    <tr>
                      <th>编号</th>
                      <th>产品</th>
                      <th>交付时间</th>
                      <th>状态</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1</td>
                      <td>TB - Monthly</td>
                      <td>01/04/2012</td>
                      <td>Default</td>
                    </tr>
                    <tr class="success">
                      <td>1</td>
                      <td>TB - Monthly</td>
                      <td>01/04/2012</td>
                      <td>Approved</td>
                    </tr>
                    <tr class="error">
                      <td>2</td>
                      <td>TB - Monthly</td>
                      <td>02/04/2012</td>
                      <td>Declined</td>
                    </tr>
                    <tr class="warning">
                      <td>3</td>
                      <td>TB - Monthly</td>
                      <td>03/04/2012</td>
                      <td>Pending</td>
                    </tr>
                    <tr class="info">
                      <td>4</td>
                      <td>TB - Monthly</td>
                      <td>04/04/2012</td>
                      <td>Call in to confirm</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <a class="btn btn-mini" href="#" rel="form-inline">嵌入</a> </span>
              <div class="preview">提交表单</div>
              <div class="view">
				<form>
					<fieldset>
					<legend contenteditable="true">表单项</legend>
					<label contenteditable="true">表签名</label>
					<input type="text" placeholder="Type something…">
					<span class="help-block" contenteditable="true">这里填写帮助信息.</span>
					<label class="checkbox" contenteditable="true">
					<input type="checkbox"> 勾选同意
					</label>
					<button type="submit" class="btn" contenteditable="true">提交</button>
					</fieldset>
				</form>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <a class="btn btn-mini" href="#" rel="form-inline">嵌入</a> </span>
              <div class="preview">搜索框</div>
              <div class="view">
                <form class="form-search">
                  <input class="input-medium search-query" type="text">
                  <button type="submit" class="btn" contenteditable="true">查找</button>
                </form>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"> </span>
              <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button></span>
              <div class="preview">纵向表单</div>
              <div class="view">
                <form class="form-horizontal">
                  <div class="control-group">
                    <label class="control-label" for="inputEmail" contenteditable="true">邮箱</label>
                    <div class="controls">
                      <input id="inputEmail" placeholder="Email" type="text">
                    </div>
                  </div>
                  <div class="control-group">
                    <label class="control-label" for="inputPassword" contenteditable="true">密码</label>
                    <div class="controls">
                      <input id="inputPassword" placeholder="Password" type="password">
                    </div>
                  </div>
                  <div class="control-group">
                    <div class="controls">
                      <label class="checkbox" contenteditable="true">
                        <input type="checkbox">
                        Remember me </label>
                      <button type="submit" class="btn" contenteditable="true">登陆</button>
                    </div>
                  </div>
                </form>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">样式 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="active"><a href="#" rel="">默认</a></li>
                <li class=""><a href="#" rel="btn-primary">重点</a></li>
                <li class=""><a href="#" rel="btn-info">信息</a></li>
                <li class=""><a href="#" rel="btn-success">成功</a></li>
                <li class=""><a href="#" rel="btn-warning">提醒</a></li>
                <li class=""><a href="#" rel="btn-danger">危险</a></li>
                <li class=""><a href="#" rel="btn-inverse">反转</a></li>
                <li class=""><a href="#" rel="btn-link">链接</a></li>
              </ul>
              </span> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">尺寸 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class=""><a href="#" rel="btn-large">大</a></li>
                <li class="active"><a href="#" rel="">中</a></li>
                <li class=""><a href="#" rel="btn-small">小</a></li>
                <li class=""><a href="#" rel="btn-mini">微型</a></li>
              </ul>
              </span> <a class="btn btn-mini" href="#" rel="btn-block">通栏</a> <a class="btn btn-mini" href="#" rel="disabled">禁用</a> </span>
              <div class="preview">按钮</div>
              <div class="view">
                <button class="btn" type="button" contenteditable="true">按钮</button>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">样式 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="active"><a href="#" rel="">默认</a></li>
                <li class=""><a href="#" rel="img-rounded">圆角</a></li>
                <li class=""><a href="#" rel="img-circle">圆圈</a></li>
                <li class=""><a href="#" rel="img-polaroid">相框</a></li>
              </ul>
              </span> </span>
              <div class="preview">图片</div>
              <div class="view"> <img alt="140x140" src="${basePath }/resources/layoutit/images/a.jpg"> </div>
            </div>
          </li>
        </ul> -->
        <ul class="nav nav-list accordion-group">
          <li class="nav-header"><i class="icon-plus icon-white"></i> 组件
            <div class="pull-right popover-info"><i class="icon-question-sign "></i>
              <div class="popover fade right">
                <div class="arrow"></div>
                <h3 class="popover-title">帮助</h3>
                <div class="popover-content">拖放组件到布局框内. 拖入后你可以设置组件样式. 查看这里获取更多帮助 <a target="_blank" href="http://twitter.github.io/bootstrap/components.html">Components.</a></div>
              </div>
            </div>
          </li>
          <li class="boxes nav-body" id="elmComponents">
            <!-- <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">方向<span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="active"><a href="#" rel="">横向</a></li>
                <li class=""><a href="#" rel="btn-group-vertical">竖向</a></li>
              </ul>
              </span> </span>
              <div class="preview">按钮组</div>
              <div class="view">
                <div class="btn-group">
                  <button class="btn" type="button"><i class="icon-align-left"></i></button>
                  <button class="btn" type="button"><i class="icon-align-center"></i></button>
                  <button class="btn" type="button"><i class="icon-align-right"></i></button>
                  <button class="btn" type="button"><i class="icon-align-justify"></i></button>
                </div>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <a class="btn btn-mini" href="#" rel="dropup">上拉</a> </span>
              <div class="preview">下拉菜单</div>
              <div class="view">
                <div class="btn-group">
                  <button class="btn" contenteditable="true">Action</button>
                  <button data-toggle="dropdown" class="btn dropdown-toggle"><span class="caret"></span></button>
                  <ul class="dropdown-menu" contenteditable="true">
                    <li><a href="#">操作</a></li>
                    <li><a href="#">设置栏目</a></li>
                    <li><a href="#">更多设置</a></li>
                    <li class="divider"></li>
                    <li class="dropdown-submenu"> <a tabindex="-1" href="#">更多选项</a>
                      <ul class="dropdown-menu">
                        <li><a href="#">操作</a></li>
                        <li><a href="#">设置栏目</a></li>
                        <li><a href="#">更多设置</a></li>
                      </ul>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">样式 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class=""><a href="#" rel="nav-tabs">线框</a></li>
                <li class=""><a href="#" rel="nav-pills">图钉</a></li>
              </ul>
              </span> <a class="btn btn-mini" href="#" rel="nav-stacked">切换格式</a> </span>
              <div class="preview">导航</div>
              <div class="view">
                <ul class="nav nav-tabs" contenteditable="true">
                  <li class="active"><a href="#">首页</a></li>
                  <li><a href="#">资料</a></li>
                  <li class="disabled"><a href="#">信息</a></li>
                  <li class="dropdown pull-right"> <a href="#" data-toggle="dropdown" class="dropdown-toggle">下拉 <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                      <li><a href="#">操作</a></li>
                      <li><a href="#">设置栏目</a></li>
                      <li><a href="#">更多设置</a></li>
                      <li class="divider"></li>
                      <li><a href="#">分割线</a></li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <a class="btn btn-mini" href="#" rel="well">嵌入</a> </span>
              <div class="preview">导航列表</div>
              <div class="view">
                <ul class="nav nav-list" contenteditable="true">
                  <li class="nav-header">列表标题</li>
                  <li class="active"><a href="#">首页</a></li>
                  <li><a href="#">库</a></li>
                  <li><a href="#">应用</a></li>
                  <li class="nav-header">功能列表</li>
                  <li><a href="#">资料</a></li>
                  <li><a href="#">设置</a></li>
                  <li class="divider"></li>
                  <li><a href="#">帮助</a></li>
                </ul>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
              <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button></span>
              <div class="preview">面包导航</div>
              <div class="view">
                <ul class="breadcrumb" contenteditable="true">
                  <li><a href="#">主页</a> <span class="divider">/</span></li>
                  <li><a href="#">类目</a> <span class="divider">/</span></li>
                  <li class="active">主题</li>
                </ul>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">尺寸 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class=""><a href="#" rel="pagination-large">大</a></li>
                <li class="active"><a href="#" rel="">中</a></li>
                <li class=""><a href="#" rel="pagination-small">小</a></li>
                <li class=""><a href="#" rel="pagination-mini">微型</a></li>
              </ul>
              </span> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">位置 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="active"><a href="#" rel="">靠左</a></li>
                <li class=""><a href="#" rel="pagination-centered">居中</a></li>
                <li class=""><a href="#" rel="pagination-right">靠右</a></li>
              </ul>
              </span> </span>
              <div class="preview">翻页</div>
              <div class="view">
                <div class="pagination">
                  <ul contenteditable="true">
                    <li><a href="#">上一页</a></li>
                    <li><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li><a href="#">下一页</a></li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">样式 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="active"><a href="#" rel="">默认</a></li>
                <li class=""><a href="#" rel="badge-success">成功</a></li>
                <li class=""><a href="#" rel="badge-warning">警告</a></li>
                <li class=""><a href="#" rel="badge-important">重要</a></li>
                <li class=""><a href="#" rel="badge-info">提示</a></li>
                <li class=""><a href="#" rel="badge-inverse">倒数</a></li>
              </ul>
              </span> </span>
              <div class="preview">文字标签</div>
              <div class="view"> <span class="label" contenteditable="true">文字标签</span> </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">样式 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="active"><a href="#" rel="">默认</a></li>
                <li class=""><a href="#" rel="badge-success">成功</a></li>
                <li class=""><a href="#" rel="badge-warning">警告</a></li>
                <li class=""><a href="#" rel="badge-important">重要</a></li>
                <li class=""><a href="#" rel="badge-info">提示</a></li>
                <li class=""><a href="#" rel="badge-inverse">倒数</a></li>
              </ul>
              </span> </span>
              <div class="preview">微标</div>
              <div class="view"> <span class="badge" contenteditable="true">1</span> </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <a class="btn btn-mini" href="#" rel="well">嵌入</a> </span>
              <div class="preview">概述</div>
              <div class="view">
                <div class="hero-unit" contenteditable="true">
                  <h1>Hello, world!</h1>
                  <p>这是一个可视化布局模板, 你可以点击模板里的文字进行修改, 也可以通过点击弹出的编辑框进行富文本修改. 拖动区块能实现排序. </p>
                  <p><a class="btn btn-primary btn-large" href="#">参看更多 »</a></p>
                </div>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
              <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button></span>
              <div class="preview">页标题</div>
              <div class="view">
                <div class="page-header" contenteditable="true">
                  <h1>页标题范例 <small>此处编写页标题</small></h1>
                </div>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
              <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button></span>
              <div class="preview">文本</div>
              <div class="view">
                <h2 contenteditable="true">标题</h2>
                <p contenteditable="true">本可视化布局程序在HTML5浏览器上运行更加完美, 能实现自动本地化保存, 即使关闭了网页, 下一次打开仍然能恢复上一次的操作.</p>
                <p><a class="btn" href="#" contenteditable="true">查看更多 »</a></p>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
              <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button></span>
              <div class="preview">预览列表</div>
              <div class="view">
                <ul class="thumbnails">
                  <li class="span4">
                    <div class="thumbnail"> <img alt="300x200" src="${basePath }/resources/layoutit/images/people.jpg">
                      <div class="caption" contenteditable="true">
                        <h3>冯诺尔曼结构</h3>
                        <p>也称普林斯顿结构，是一种将程序指令存储器和数据存储器合并在一起的存储器结构。程序指令存储地址和数据存储地址指向同一个存储器的不同物理位置。</p>
                        <p><a class="btn btn-primary" href="#">浏览</a> <a class="btn" href="#">分享</a></p>
                      </div>
                    </div>
                  </li>
                  <li class="span4">
                    <div class="thumbnail"> <img alt="300x200" src="${basePath }/resources/layoutit/images/city.jpg">
                      <div class="caption" contenteditable="true">
                        <h3>哈佛结构</h3>
                        <p>哈佛结构是一种将程序指令存储和数据存储分开的存储器结构，它的主要特点是将程序和数据存储在不同的存储空间中，进行独立编址。</p>
                        <p><a class="btn btn-primary" href="#">浏览</a> <a class="btn" href="#">分享</a></p>
                      </div>
                    </div>
                  </li>
                  <li class="span4">
                    <div class="thumbnail"> <img alt="300x200" src="${basePath }/resources/layoutit/images/sports.jpg">
                      <div class="caption" contenteditable="true">
                        <h3>改进型哈佛结构</h3>
                        <p>改进型的哈佛结构具有一条独立的地址总线和一条独立的数据总线，两条总线由程序存储器和数据存储器分时复用，使结构更紧凑。</p>
                        <p><a class="btn btn-primary" href="#">浏览</a> <a class="btn" href="#">分享</a></p>
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">样式 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="active"><a href="#" rel="">默认</a></li>
                <li class=""><a href="#" rel="progress-info">提示</a></li>
                <li class=""><a href="#" rel="progress-success">成功</a></li>
                <li class=""><a href="#" rel="progress-warning">警告</a></li>
                <li class=""><a href="#" rel="progress-danger">危险</a></li>
              </ul>
              </span> <a class="btn btn-mini" href="#" rel="progress-striped">条纹</a> <a class="btn btn-mini" href="#" rel="active">动画</a> </span>
              <div class="preview">进度条</div>
              <div class="view">
                <div class="progress">
                  <div class="bar" style="width: 60%;"></div>
                </div>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <a class="btn btn-mini" href="#" rel="well">嵌入</a> </span>
              <div class="preview">嵌入媒体</div>
              <div class="view">
                <div class="media"> <a href="#" class="pull-left"> <img src="${basePath }/resources/layoutit/images/a_002.jpg" class="media-object"> </a>
                  <div class="media-body" contenteditable="true">
                    <h4 class="media-heading">嵌入媒体标题</h4>
                   请尽量使用HTML5兼容的视频格式和视频代码实现视频播放, 以达到更好的体验效果. </div>
                </div>
              </div>
            </div> -->
          </li>
        </ul>
        <!-- <ul class="nav nav-list accordion-group">
          <li class="nav-header"><i class="icon-plus icon-white"></i> 交互组件 <span class="label label-important">NEW!</span>
            <div class="pull-right popover-info"><i class="icon-question-sign "></i>
              <div class="popover fade right">
                <div class="arrow"></div>
                <h3 class="popover-title">帮助</h3>
                <div class="popover-content">拖放组件到布局容器. 拖入后, 你可以配置显示样式. 如果有任何疑问可访问 <a target="_blank" href="http://twitter.github.io/bootstrap/javascript.html">JavaScript.</a></div>
              </div>
            </div>
          </li>
          <li class="boxes mute nav-body" id="elmJS">
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
              <div class="preview">遮罩窗体</div>
              <div class="view">
                <a id="myModalLink" href="#myModalContainer" role="button" class="btn" data-toggle="modal" contenteditable="true">触发遮罩窗体</a> 
                <div id="myModalContainer" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 id="myModalLabel" contenteditable="true">标题栏</h3>
                  </div>
                  <div class="modal-body">
                    <p contenteditable="true">显示信息</p>
                  </div>
                  <div class="modal-footer">
                    <button class="btn" data-dismiss="modal" aria-hidden="true" contenteditable="true">关闭</button>
                    <button class="btn btn-primary" contenteditable="true">保存设置</button>
                  </div>
                </div>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <a class="btn btn-mini" href="#" rel="navbar-inverse">Inverse</a> 
              </span>
              <div class="preview">导航栏</div>
              <div class="view">
                <div class="navbar">
                  <div class="navbar-inner">
                    <div class="container-fluid"> <a data-target=".navbar-responsive-collapse" data-toggle="collapse" class="btn btn-navbar"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a> <a href="#" class="brand" contenteditable="true">网站名</a>
                      <div class="nav-collapse collapse navbar-responsive-collapse">
                        <ul class="nav" contenteditable="true">
                          <li class="active"><a href="#">主页</a></li>
                          <li><a href="#">链接</a></li>
                          <li><a href="#">链接</a></li>
                          <li class="dropdown"> <a data-toggle="dropdown" class="dropdown-toggle" href="#">下拉菜单 <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                              <li><a href="#">下拉导航1</a></li>
                              <li><a href="#">下拉导航2</a></li>
                              <li><a href="#">其他</a></li>
                              <li class="divider"></li>
                              <li class="nav-header">标签</li>
                              <li><a href="#">链接1</a></li>
                              <li><a href="#">链接2</a></li>
                            </ul>
                          </li>
                        </ul>
                        <ul class="nav pull-right" contenteditable="true">
                          <li><a href="#">右边链接</a></li>
                          <li class="divider-vertical"></li>
                          <li class="dropdown"> <a data-toggle="dropdown" class="dropdown-toggle" href="#">下拉菜单 <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                              <li><a href="#">下拉导航1</a></li>
                              <li><a href="#">下拉导航2</a></li>
                              <li><a href="#">其他</a></li>
                              <li class="divider"></li>
                              <li><a href="#">链接3</a></li>
                            </ul>
                          </li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">位置 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="active"><a href="#" rel="">默认</a></li>
                <li class=""><a href="#" rel="tabs-below">底部</a></li>
                <li class=""><a href="#" rel="tabs-left">靠左</a></li>
                <li class=""><a href="#" rel="tabs-right">靠右</a></li>
              </ul>
              </span> </span>
              <div class="preview">切换卡</div>
              <div class="view">
                <div class="tabbable" id="myTabs">
                  <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab1" data-toggle="tab" contenteditable="true">第一部分</a></li>
                    <li><a href="#tab2" data-toggle="tab" contenteditable="true">第二部分</a></li>
                  </ul>
                  <div class="tab-content">
                    <div class="tab-pane active" id="tab1" contenteditable="true">
                      <p>第一部分内容.</p>
                    </div>
                    <div class="tab-pane" id="tab2" contenteditable="true">
                      <p>第二部分内容.</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span> <span class="configuration"> <span class="btn-group"> <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">样式 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li class="active"><a href="#" rel="">默认</a></li>
                <li class=""><a href="#" rel="alert-info">提示</a></li>
                <li class=""><a href="#" rel="alert-error">错误</a></li>
                <li class=""><a href="#" rel="alert-success">成功</a></li>
              </ul>
              </span> </span>
              <div class="preview">提示框</div>
              <div class="view">
                <div class="alert" contenteditable="true">
                  <button type="button" class="close" data-dismiss="alert">×</button>
                  <h4>提示!</h4>
                  <strong>警告!</strong> 请注意你的个人隐私安全. </div>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
              <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button></span>
              <div class="preview">手风琴切换</div>
              <div class="view">
                <div class="accordion" id="myAccordion">
                  <div class="accordion-group">
                    <div class="accordion-heading"> <a class="accordion-toggle" data-toggle="collapse" data-parent="#myAccordion" href="#collapseOne" contenteditable="true"> 选项卡 #1 </a> </div>
                    <div id="collapseOne" class="accordion-body collapse in">
                      <div class="accordion-inner" contenteditable="true"> 功能块... </div>
                    </div>
                  </div>
                  <div class="accordion-group">
                    <div class="accordion-heading"> <a class="accordion-toggle" data-toggle="collapse" data-parent="#myAccordion" href="#collapseTwo" contenteditable="true"> 选项卡 #2 </a> </div>
                    <div id="collapseTwo" class="accordion-body collapse">
                      <div class="accordion-inner" contenteditable="true"> 功能块... </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
              <span class="configuration"><button type="button" class="btn btn-mini" data-target="#editorModal" role="button" data-toggle="modal">编辑</button></span>
              <div class="preview">轮换图</div>
              <div class="view">
                <div class="carousel slide" id="myCarousel">
                  <ol class="carousel-indicators">
                    <li class="active" data-slide-to="0" data-target="#myCarousel"></li>
                    <li data-slide-to="1" data-target="#myCarousel" class=""></li>
                    <li data-slide-to="2" data-target="#myCarousel" class=""></li>
                  </ol>
                  <div class="carousel-inner">
                    <div class="item active"> <img alt="" src="${basePath }/resources/layoutit/images/1.jpg">
                      <div class="carousel-caption" contenteditable="true">
                        <h4>棒球</h4>
                        <p>棒球运动是一种以棒打球为主要特点，集体性、对抗性很强的球类运动项目，在美国、日本尤为盛行。</p>
                      </div>
                    </div>
                    <div class="item"> <img alt="" src="${basePath }/resources/layoutit/images/2.jpg">
                      <div class="carousel-caption" contenteditable="true">
                        <h4>冲浪</h4>
                        <p>冲浪是以海浪为动力，利用自身的高超技巧和平衡能力，搏击海浪的一项运动。运动员站立在冲浪板上，或利用腹板、跪板、充气的橡皮垫、划艇、皮艇等驾驭海浪的一项水上运动。</p>
                      </div>
                    </div>
                    <div class="item"> <img alt="" src="${basePath }/resources/layoutit/images/3.jpg">
                      <div class="carousel-caption" contenteditable="true">
                        <h4>自行车</h4>
                        <p>以自行车为工具比赛骑行速度的体育运动。1896年第一届奥林匹克运动会上被列为正式比赛项目。环法赛为最著名的世界自行车锦标赛。</p>
                      </div>
                    </div>
                  </div>
                  <a data-slide="prev" href="#myCarousel" class="left carousel-control">‹</a> <a data-slide="next" href="#myCarousel" class="right carousel-control">›</a> </div>
              </div>
            </div>
          </li>
        </ul>
        <ul class="nav nav-list accordion-group">
          <li class="nav-header"><i class="icon-plus icon-white"></i> 应用扩展 </li>
          <li class="boxes mute nav-body" id="elmComm">
            <div class="preview">建设中...</div>
          </li>
        </ul>
         -->
      </div>
    </div>

    <!--UI编辑区-->
    <div class="demo ui-sortable" style="min-height: 304px; ">
      

    </div>
    <!-- end demo -->
    <!-- 临时编辑区域 -->
    <div class="attr hide" id="tmpID">
      
    </div>
    <!-- /属性窗口 -->
    <!-- 属性窗口 -->
    <div class="attr " id="attrModal">
     
    </div>
    <!-- /属性窗口 -->
    <!--/span-->
    <div id="download-layout">
      <div class="container-fluid"></div>
    </div>
  </div>
  <!--/row--> 
</div>
<!--/.fluid-container--> 
<div class="modal hide fade" role="dialog" id="editorModal">
  <div class="modal-header"> <a class="close" data-dismiss="modal">×</a>
    <h3>编辑</h3>
  </div>
  <div class="modal-body">
    <p>
      <textarea id="contenteditor"></textarea>
    </p>
  </div>
  <div class="modal-footer"> <a id="savecontent" class="btn btn-primary" data-dismiss="modal">保存</a> <a class="btn" data-dismiss="modal">关闭</a> </div>
</div>
<div class="modal hide fade" role="dialog" id="downloadModal">
  <div class="modal-header"> <a class="close" data-dismiss="modal">×</a>
    <h3>下载</h3>
  </div>
  <div class="modal-body">
    <p>已在下面生成干净的HTML, 可以复制粘贴代码到你的项目.</p>
    <div class="btn-group">
      <button type="button" id="fluidPage" class="active btn btn-info"><i class="icon-fullscreen icon-white"></i> 自适应宽度</button>
      <button type="button" class="btn btn-info" id="fixedPage"><i class="icon-screenshot icon-white"></i> 固定宽度</button>
    </div>
    <br>
    <br>
    <p>
      <textarea></textarea>
    </p>
  </div>
  <div class="modal-footer"> <a class="btn" data-dismiss="modal">关闭</a> </div>
</div>
<div class="modal hide fade" role="dialog" id="shareModal">
  <div class="modal-header"> <a class="close" data-dismiss="modal">×</a>
    <h3>保存</h3>
  </div>
  <div class="modal-body">保存成功</div>
  <div class="modal-footer"> <a class="btn" data-dismiss="modal">Close</a> </div>
</div>
</body>
 <!--导入控件js文件--> 
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/customwidget/fs_temperature.js"></script>
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/customwidget/hc_dial.js"></script>
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/customwidget/hc_curve.js"></script>
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/customwidget/fs_dial.js"></script>
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/customwidget/fs_cup.js"></script>

  <script type="text/javascript" src="${basePath }/resources/layoutit/js/customwidget/layout_subsys.js"></script>
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/customwidget/ctr_switch.js"></script>
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/customwidget/sec_alarm.js"></script> 
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/customwidget/cam_video.js"></script>
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/customwidget/page_header.js"></script> 
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/customwidget/page_footer.js"></script> 
  
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/layout-common.js"></script>
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/template-ui.js"></script>
</html>
