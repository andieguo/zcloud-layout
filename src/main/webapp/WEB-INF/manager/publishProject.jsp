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

var layoutJSON = '${templateEntity.layoutJSON}';  

var content = '${templateEntity.layoutContent}';

var macList = JSON.parse('${projectEntity.macList}');

var hardwareInfo={
		"zcloudID":'${projectEntity.zcloudID}',
		"zcloudKEY":'${projectEntity.zcloudKEY}',
		"serverAddr":'${projectEntity.serverAddr}',
	    "data": macList
	};

var realTimeSensorArry=[];		//实时数据类
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
		var data = dat;
		var chan,val;
		while(1){
		  if(data.indexOf(',') == -1)
		  {
		    chan = data.substring(data.indexOf('{')+1,data.indexOf('='));
		    val = data.substring(data.indexOf('=')+1,data.indexOf('}'));
		    handleSensorIncomingData(mac,chan,val);//数据处理
		    break;
		  }
		  else{
			chan = data.substring(data.indexOf('{')+1,data.indexOf('='));
		    val = data.substring(data.indexOf('=')+1,data.indexOf(','));
		    handleSensorIncomingData(mac,chan,val);//数据处理
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
		var divid = $(this).closest(".view").find(".body").children().attr("id");
		var widgetIndex = divid.substring(0,placeOfChar(divid,2,'_'));
		for(var i in realTimeSensorArry){
			if(realTimeSensorArry[i].tid == divid){
				var sendObj = {"mac":realTimeSensorArry[i].address,"command":realTimeSensorArry[i].command}
				gUiObject[widgetIndex].sendCmd(clickObj,rtc,sendObj);
				break;
			}
		}
	});

	//摄像头控制类按钮监听事件
	$(".btn_camera").click(function(){
		var cmd = $(this).attr("ctr_cmd");
		var divid = $(this).closest(".view").find(".body").children().attr("id");
		var widgetIndex = divid.substring(0,placeOfChar(divid,2,'_'));
		for(var i in videoArry){
			if(videoArry[i].tid == divid){
				gUiObject[widgetIndex].sendCmd(divid,videoArry[i].cameraObj,cmd);
				break;
			}
		}
	});	
});
$(function(){
	var a = $(window).width();
	var b = $(window).width() - $(".container").width();
	$(".header-bg").css("width",a + "px");
	$(".header-bg").css("left",-b/2 + "px");
	$(".footer-bg").css("width",a + "px");
	$(".footer-bg").css("left",-b/2 + "px");
});
</script>

</head>

<body style="min-height: 660px; cursor: auto;" class="devpreview sourcepreview">

<div class="container">
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
