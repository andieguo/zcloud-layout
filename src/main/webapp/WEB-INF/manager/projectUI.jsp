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
<title>项目发布</title>

<!-- Le styles -->
<link href="${basePath }/resources/layoutit/css/bootstrap-combined.min.css" rel="stylesheet">
<link href="${basePath }/resources/layoutit/css/layoutit.css" rel="stylesheet">
<link href="${basePath }/resources/layoutit/css/style.css" rel="stylesheet">

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
		<script src="js/html5shiv.js"></script>
	<![endif]-->

<!-- Fav and touch icons -->
<link rel="shortcut icon" href="${basePath }/resources/layoutit/images/favicon.png">

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
var basePath = "${basePath}";
var layoutitPath = basePath + "/resources/layoutit/";
var uiTemplateObj;

var layoutJSON = '{"hc_curve_238786":{"tid":"hc_curve_238786","title":"温度历史数据","width":200,"height":200,"ctype":"spline","unit":"℃","data":[[1398368037823,2],[1398470377015,6],[1398556786135,1],[1398643177964,9],[1398710239656,10],[1398784852700,7]]},"cam_video_567453":{"tid":"cam_video_567453","title":"办公室摄像头","width":300,"height":300,"theme_type":"green"},"sec_alarm_294365":{"tid":"sec_alarm_294365","title":"人体红外","width":300,"height":300,"theme_type":"green"},"ctr_switch_883841":{"tid":"ctr_switch_883841","title":"灯光1","width":300,"height":300,"theme_type":"green"},"fs_cup_407519":{"tid":"fs_cup_407519","title":"湿度实时数据","width":140,"height":200,"max":100,"min":0,"unit":"%","bgcolor":"#f2f5f7","gaugeFillColor":"#5aff00"},"fs_dial_434625":{"tid":"fs_dial_434625","title":"光强值","width":280,"height":280,"max":3000,"min":0,"unit":"Lx","layer1":{"minvalue":"0","maxvalue":"1000","code":"C1E1C1","alpha":"80"},"layer2":{"minvalue":"1000","maxvalue":"2000","code":"F6F164","alpha":"80"},"layer3":{"minvalue":"2000","maxvalue":"3000","code":"F70118","alpha":"80"}},"hc_dial_884444":{"tid":"hc_dial_884444","title":"PM2.5值","width":250,"height":250,"max":500,"min":0,"unit":"ppm","layer1":{"from":0,"to":90,"color":"green"},"layer2":{"from":90,"to":150,"color":"yellow"},"layer3":{"from":150,"to":500,"color":"red"}},"fs_temperature_273730":{"tid":"fs_temperature_273730","title":"土壤温度","width":240,"height":200,"max":100,"min":0,"unit":"℃","bgcolor":"#f3f5f7","gaugeFillColor":"#ffc420"}}';  
var content = '<div class="lyrow ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview"><input value="6 6" type="text"></div><div class="view"><div class="row-fluid clearfix"><div class="span6 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">视频监控类</div><div class="view"><div class="panel-sensor" id="cam_video_567453"></div></div></div></div><div class="span6 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">安防类</div><div class="view"><div class="panel-sensor alarm" id="sec_alarm_294365"></div></div></div></div></div></div></div><div class="lyrow ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview"><input value="4 4 4" type="text"></div><div class="view"><div class="row-fluid clearfix"><div class="span4 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">开关类</div><div class="view"><div class="panel-sensor" id="ctr_switch_883841"></div></div></div></div><div class="span4 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">曲线-hc</div><div class="view"><div id="hc_curve_238786" data-highcharts-chart="2"></div></div></div></div><div class="span4 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">量杯</div><div class="view"><div id="fs_cup_407519"></div></div></div></div></div></div></div><div class="lyrow ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview"><input value="4 4 4" type="text"></div><div class="view"><div class="row-fluid clearfix"><div class="span4 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">表盘-fs</div><div class="view"><div id="fs_dial_434625"></div></div></div></div><div class="span4 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">表盘-hc</div><div class="view"><div id="hc_dial_884444" data-highcharts-chart="17"></div></div></div></div><div class="span4 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">温度计</div><div class="view"><div id="fs_temperature_273730"></div></div></div></div></div></div></div>';

$(function(){
	initTemplateUI(layoutJSON,content);
});
</script>

</head>

<body style="min-height: 660px; cursor: auto;" class="devpreview sourcepreview">

<div class="container-fluid">
  <div class="row-fluid">
    <!--UI编辑区-->
    <div class="demo ui-sortable" style="min-height: 304px; ">
    </div>
  </div>
  <!--/row--> 
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
  
</html>
