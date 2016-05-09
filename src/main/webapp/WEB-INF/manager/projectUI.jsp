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

var layoutJSON = '{"layout_subsys_127661":{"tid":"layout_subsys_127661","title":"实时温度","width":300,"height":300,"theme_type":"green"},"layout_subsys_181325":{"tid":"layout_subsys_181325","title":"实时湿度","width":300,"height":300,"theme_type":"green"},"hc_dial_9210":{"tid":"hc_dial_9210","title":"实时温度","width":300,"height":300,"max":100,"min":0,"unit":"℃","layer1":{"from":30,"to":50,"color":"green"},"layer2":{"from":0,"to":30,"color":"yellow"},"layer3":{"from":50,"to":100,"color":"red"}},"fs_cup_57708":{"tid":"fs_cup_57708","title":"实时湿度","width":140,"height":200,"max":100,"min":0,"unit":"%","bgcolor":"#f2f5f7","gaugeFillColor":"#5aff00"},"hc_curve_456731":{"tid":"hc_curve_456731","title":"历史温度数据","width":600,"height":200,"ctype":"spline","unit":"℃","data":[[1398368037823,2],[1398470377015,6],[1398556786135,1],[1398643177964,9],[1398710239656,10],[1398784852700,7]]},"ctr_switch_982525":{"tid":"ctr_switch_982525","title":"灯光1","width":300,"height":300,"theme_type":"green"},"ctr_switch_784937":{"tid":"ctr_switch_784937","title":"灯光2","width":300,"height":300,"theme_type":"green"},"ctr_switch_574909":{"tid":"ctr_switch_574909","title":"声光报警","width":300,"height":300,"theme_type":"green"},"cam_video_634597":{"tid":"cam_video_634597","title":"会议室摄像头","width":300,"height":300,"theme_type":"green"},"cam_video_29189":{"tid":"cam_video_29189","title":"办公室摄像头","width":300,"height":300,"theme_type":"green"},"sec_alarm_771399":{"tid":"sec_alarm_771399","title":"人体红外检测","width":300,"height":300,"theme_type":"green","dataType":"realTime"}}';  

var content = ' <div class="lyrow ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview"><input value="12" type="text"></div><div class="view"><div class="row-fluid clearfix"><div class="span12 column ui-sortable"><div class="lyrow ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview"><input value="6 6" type="text"></div><div class="view"><div class="row-fluid clearfix"><div class="span6 column ui-sortable"><div class="lyrow ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">子系统标题布局</div><div class="view"><div class="panel-subsys" id="layout_subsys_127661"><h3 class="title">实时温度</h3><div class="body column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">表盘-hc</div><div class="view"><div id="hc_dial_9210" data-highcharts-chart="0"></div></div></div></div></div></div></div></div><div class="span6 column ui-sortable"><div class="lyrow ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">子系统标题布局</div><div class="view"><div class="panel-subsys" id="layout_subsys_181325"><h3 class="title">实时湿度</h3><div class="body column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">量杯</div><div class="view"><div id="fs_cup_57708"></div></div></div></div></div></div></div></div></div></div></div><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">曲线-hc</div><div class="view"><div id="hc_curve_456731" data-highcharts-chart="1"></div></div></div><div class="lyrow ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview"><input value="6 6" type="text"></div><div class="view"><div class="row-fluid clearfix"><div class="span6 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">开关类</div><div class="view"><div class="panel-sensor" id="ctr_switch_982525"></div></div></div></div><div class="span6 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">开关类</div><div class="view"><div class="panel-sensor" id="ctr_switch_784937"></div></div></div></div></div></div></div><div class="lyrow ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview"><input value="4 4 4" type="text"></div><div class="view"><div class="row-fluid clearfix"><div class="span4 column ui-sortable"><div class="box box-element ui-draggable" style="display: block; position: relative; opacity: 1; z-index: 0;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">开关类</div><div class="view"><div class="panel-sensor" id="ctr_switch_574909"></div></div></div></div><div class="span4 column ui-sortable"></div><div class="span4 column ui-sortable"></div></div></div></div></div></div></div></div><div class="lyrow ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview"><input value="6 6" type="text"></div><div class="view"><div class="row-fluid clearfix"><div class="span6 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">视频监控类</div><div class="view"><div class="panel-sensor" id="cam_video_634597"></div></div></div></div><div class="span6 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">视频监控类</div><div class="view"><div class="panel-sensor" id="cam_video_29189"></div></div></div></div></div></div></div><div class="lyrow ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview"><input value="6 6" type="text"></div><div class="view"><div class="row-fluid clearfix"><div class="span6 column ui-sortable"><div class="box box-element ui-draggable" style="display: block; position: relative; opacity: 1; z-index: 0;"><a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a><span class="drag label"><i class="icon-move"></i>拖动</span><span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span><div class="preview">安防类</div><div class="view"><div class="panel-sensor alarm" id="sec_alarm_771399"></div></div></div></div><div class="span6 column ui-sortable"></div></div></div></div>';


var hardwareInfo={
		"zcloudID":"1155223953",
		"zcloudKEY":"Xrk6UicNrbo3KiX1tYDDaUq9HAMHBYhuE2Sb4NLKFKdNcLH5",
		"serverAddr":"1234",
	    "data": [
	        {
	           "tid": "hc_dial_9210",
			   "title": "实时温度",
			   "address": "00:12:4B:00:02:CB:A8:52",
			   "channel":"A0",
			   "command":null,
			   "dataType":"realTime"
	        }, {
	           "tid": "fs_cup_57708",
			   "title": "实时湿度",
			   "address": "00:12:4B:00:02:CB:A8:52",
			   "channel":"A1",
			   "command":null,
			   "dataType":"realTime"
	        }, {
	           "tid": "hc_curve_456731",
			   "title": "历史温度数据",
			   "address": "00:12:4B:00:02:CB:A8:52",
			   "channel":"A0",
			   "command":null,
			   "dataType":"realTime|history"
	        }, {
	           "tid": "ctr_switch_982525",
			   "title": "灯光1",
			   "address": "00:12:4B:00:03:A7:E1:17",
			   "channel":"D1.1",
			   "command":{"open":"{OD1=1,D1=?}","close":"{CD1=1,D1=?}"},
			   "dataType":"realTime"
	        }, {
	           "tid": "ctr_switch_784937",
			   "title": "灯光2",
			   "address": "00:12:4B:00:03:A7:E1:17",
			   "channel":"D1.2",
			   "command":{"open":"{OD1=2,D1=?}","close":"{CD1=2,D1=?}"},
			   "dataType":"realTime"
	        }, {
	           "tid": "ctr_switch_574909",
			   "title": "声光报警",
			   "address": "00:12:4B:00:02:63:3C:CF",
			   "channel":"D1.1",
			   "command":{"open":"{OD1=1,D1=?}","close":"{CD1=1,D1=?}"},
			   "dataType":"realTime"
	        }, {
	           "tid": "cam_video_634597",
			   "title": "会议室摄像头",
			   "address": "Camera:192.168.1.91:81",
			   "user":"admin",
			   "pwd":"admin",
			   "camtype":"H3-Series",
			   "dataType":"video"
	        }, {
	           "tid": "cam_video_29189",
			   "title": "办公室摄像头",
			   "address": "Camera:192.168.1.90:81",
			   "user":"admin",
			   "pwd":"admin",
			   "camtype":"H3-Series",
			   "dataType":"video"
	        }, {
	           "tid": "sec_alarm_771399",
			   "title": "人体红外",
			   "address": "00:12:4B:00:02:63:3C:B7",
			   "channel":"A0|D0.1",
			   "command":{"open":"{OD0=1,D0=?}","close":"{CD0=1,D0=?}"},
			   "dataType":"realTime"
	        }              
	    ]
	};

var realTimeSensorArry=[];		//实时采集类
var hisDataSensorArry=[];		//历史数据类
var videoArry=[];				//视频监控类

//控件分类
function widgetClassify(data){
	for(var i in data){
		//实时数据类
		if(data[i].dataType.indexOf("realTime")>=0)
		{
			realTimeSensorArry.push(data[i]);
		}

		//历史数据类
		if(data[i].dataType.indexOf("history")>=0)
		{
			hisDataSensorArry.push(data[i]);
		}

		//视频监控类
		if(data[i].dataType.indexOf("video")>=0){
			var obj = {};
			obj["cameraInfo"] = data[i];
			obj["tid"] = data[i].tid;
			obj["cameraObj"] = new WSNCamera();

			//摄像头初始化
			obj["cameraObj"].initCamera(data[i].address, data[i].user, data[i].pwd,data[i].camtype);
			//设置视频监控显示的img标签id
			obj["cameraObj"].setDiv("img_"+data[i].tid);
			
			//将摄像头对象加入数组
			videoArry.push(obj);
		}		
	}
}

//处理传感器实时上报来的数据
function handleSensorIncomingData(mac,chan,val){	
	for(var i in realTimeSensorArry){
		var value = val;
		if(realTimeSensorArry[i].address == mac){
			console.log(mac+" -> " +chan +"="+val);
			var divid = realTimeSensorArry[i].tid;
			var widgetIndex = divid.substring(0,placeOfChar(divid,2,'_'));
			
			var chanArray = (realTimeSensorArry[i].channel).split('|');
			
			for(var j in chanArray){
				if(chanArray[j].indexOf(chan) >= 0){
					if(chanArray[j].indexOf('.') >= 0){//特殊处理D1-D3具有的数据位
						var dataBit = chanArray[j].substring(chanArray[j].indexOf('.')+1);//记录数据位数
						value = getNumBit(val,dataBit);						
					}
					//将数据传递给控件进行处理
					gUiObject[widgetIndex].setValue(divid,chan,value);
				}
			}
		}
	}
}

//处理传感器历史数据
function handleSensorHisData(hisDataObj){
	for(var i in hisDataSensorArry){
		var divid = hisDataSensorArry[i].tid;
		var widgetIndex = divid.substring(0,placeOfChar(divid,2,'_'));
		var chan = hisDataSensorArry[i].address + '_' + hisDataSensorArry[i].channel;

		hisDataObj.queryLast1H(chan,function(data){//默认查询1小时
			gUiObject[widgetIndex].setData(divid,data);
		});		
	}
}

//返回数据的第n位bit
function getNumBit(num,n){
	num = parseInt(num);
	n = parseInt(n);
    var a = num & n;
    if(a == 0){
    	return 0;
    }
    else{
    	return 1;
    }	
}

//文档就绪
$(function(){
	initTemplateUI(layoutJSON,content);
	widgetClassify(hardwareInfo.data);

	//实时数据
	var rtc = new WSNRTConnect(hardwareInfo.zcloudID,hardwareInfo.zcloudKEY);
	rtc.connect();
	rtc.onConnect = function () {
		console.log("连接成功！");
	};
	rtc.onConnectLost = function () {
		console.log("掉线！")
	};
	rtc.onmessageArrive = function (mac, dat) {
		console.log(mac+" -> " +dat);
		
		var data = dat;
		var chan,val;
		while(1){
		  if(data.indexOf(',') == -1)
		  {
		    chan = data.substring(data.indexOf('{')+1,data.indexOf('='));
		    val = data.substring(data.indexOf('=')+1,data.indexOf('}'));
		    handleSensorIncomingData(mac,chan,val);//数据处理
		    console.log("DEBUG "+chan+':'+val);
		    break;
		  }
		  else{
			chan = data.substring(data.indexOf('{')+1,data.indexOf('='));
		    val = data.substring(data.indexOf('=')+1,data.indexOf(','));
		    handleSensorIncomingData(mac,chan,val);//数据处理
		    console.log("DEBUG "+chan+':'+val);
		    data = "{"+data.substring(data.indexOf(',')+1);
		  }
		}
	};
	
	//历史数据查询
	var hisData = new WSNHistory(hardwareInfo.zcloudID,hardwareInfo.zcloudKEY);
	handleSensorHisData(hisData);

	//开关控制类、安防类按钮监听事件
	$(".switch_button,.sec_button").click(function(){
		var clickObj =$(this);
		var divid = $(this).parents(".view").children().attr("id");
		var widgetIndex = divid.substring(0,placeOfChar(divid,2,'_'));
		for(var i in realTimeSensorArry){
			if(realTimeSensorArry[i].tid == divid){
				var sendObj = {"mac":realTimeSensorArry.address,"command":realTimeSensorArry[i].command}
				gUiObject[widgetIndex].sendCmd(clickObj,rtc,sendObj);
				break;
			}
		}
	});

	//摄像头控制类按钮监听事件
	$(".btn_camera").click(function(){
		var cmd = $(this).attr("ctr_cmd");
		var divid = $(this).parents(".view").children().attr("id");
		var widgetIndex = divid.substring(0,placeOfChar(divid,2,'_'));
		for(var i in videoArry){
			if(videoArry[i].tid == divid){
				gUiObject[widgetIndex].sendCmd(divid,videoArry[i].cameraObj,cmd);
				break;
			}
		}
	});	
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
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/wsn/camera-1.1.js"></script>
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/wsn/WSNCamera.js"></script>  
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/wsn/WSNRTConnect.js"></script>
  <script type="text/javascript" src="${basePath }/resources/layoutit/js/wsn/WSNHistory.js"></script>    
</html>
