//添加实时数据
function addPlot(obj, value) {
    var state = obj.find('.Real_time').attr("class");
    if (state.indexOf("success") > 0){
        var chart = obj.find("object").highcharts();
        var series = chart.series[0];
        var point = {	//获取新的点，并返回给动态图表
            x: (new Date()).getTime() + 28800000,
            y: parseFloat(value)
        };
        series.addPoint([point.x, point.y], true, true);
    }
}

//第n个指定字符的位置
function placeOfChar(str, n, char) {
    var index = str.indexOf(char);
    var i = 0;
    while (index != -1) {
        i++;
        if (i == n)
            break;
        index = str.indexOf(char, index + 1);
    }
    return index;
}

//显示信息采集
function Collection(obj){
	$("#collection").animate({left:'0px'});
	$("#execute").animate({left:'1024px'});
	$("#viedo").animate({left:'1024px'});
    $("#picture").animate({left:'1024px'});
	$(".change").find("button").attr("class","btn btn-default");
	$(obj).attr("class","btn btn-success");
	$(".content").height($("#collection").height()+55).css("min-height","560px");
}

//显示执行设备
function Execute(obj){
	$("#collection").animate({left:'-1024px'});
	$("#execute").animate({left:'-1024px'});
	$("#viedo").animate({left:'1024px'});
	$("#picture").animate({left:'1024px'});
	$(".change").find("button").attr("class","btn btn-default");
	$(obj).attr("class","btn btn btn-success");
	$(".content").height($("#execute").height()+55).css("min-height","560px");
}

//显示视频监控
function Viedo(obj){
	$("#collection").animate({left:'-1024px'});
	$("#execute").animate({left:'-2048px'});
	$("#viedo").animate({left:'-2048px'});
	$("#picture").animate({left:'1024px'});
	$(".change").find("button").attr("class","btn btn-default");
	$(obj).attr("class","btn btn-success");
	$(".content").height($("#viedo").height()+55).css("min-height","560px");
}

//显示视频监控
function Picture(obj){
    $("#collection").animate({left:'-1024px'});
    $("#execute").animate({left:'-2048px'});
    $("#viedo").animate({left:'-3072px'});
    $("#picture").animate({left:'-3072px'});
    $(".change").find("button").attr("class","btn btn-default");
    $(obj).attr("class","btn btn-success");
    $(".content").height($("#picture").height()+55).css("min-height","560px");
}

function get_data(){
	$(".controlbox").each(function(){
		var command=$(this).attr("command");
		command = command.substr(1, command.length-2);
		command = command.replace(/"/g, "'");
		command = command.replace(/(^\s+)|(\s+$)/g,"").replace(/\s/g,"");
		var command_list1=command.split("','");
		if(command_list1.length<5){
			$(this).find(".switch_down").hide();
			$(this).find(".switch_up").hide();
		}
		for (var i=0; i<command_list1.length; i++) {
			var command_list2 = command_list1[i].split(":");
			if(command_list2.length==2){
				if(i<=3){
					$(this).find(".switch").children("button").eq(i).html(command_list2[0].replace(/'/g,""));
					$(this).find(".switch").children("button").eq(i).attr("command",command_list2[1].replace(/'/g,"")).css("pointer-events","auto");
				}else if(i>3){
					var  button='<button style="pointer-events: auto;" command="'+command_list2[1].replace(/'/g,"")+'" type="button" class="btn btn-default">'+command_list2[0].replace(/'/g,"")+'</button>';
					$(this).find(".switch").append(button);
				}
			}
		}
	})

	
	/*****************数据获取初始化********************/
	var myZCloudID = $("#form_flowId").val();
	var myZCloudKey =$("#form_flowKey").val();
	var serverAddr = $("#form_serverAddr").val();
	var rtc = new WSNRTConnect(myZCloudID,myZCloudKey);//创建数据连接服务对象	
	if(serverAddr != null && serverAddr != ""){
		rtc.setServerAddr(serverAddr+":28080");
	}
	rtc.connect();
	var strmac="";
	rtc.onConnect = function() {
		$(".z_status").html("数据推送服务已连接。");		
		$(".sensorbox").each(function () {//感知设备查询
			var mac=$(this).attr("mac");
		
			
			if((mac!=null)&&(strmac.match(mac) == null)){
				mac = mac.substring(0, 23);
				strmac=strmac+":"+mac;
				rtc.sendMessage(mac,"{ECHO=?}");
			};
		});
		$(".controlbox").each(function () {//控制设备查询
			var mac=$(this).attr("mac");
			
			if((mac!=null)&&(strmac.match(mac) == null)){
				mac = mac.substring(0, 23);
				strmac=strmac+":"+mac;
				rtc.sendMessage(mac,"{ECHO=?}");
			};
		});
	}
	rtc.onConnectLost = function(){
		console.log("reconnectlost");
		$(".z_status").html("数据推送服务掉线。");
	};
	/*****************数据获取初始化********************/
	
	
	/*****************实时数据处理********************/
	rtc.onmessageArrive = function(mac, dat) {
		if ((dat[0] == '{' )&& (dat[dat.length-1] == '}')) {
			var data = dat.substr(1, dat.length-2);
			var tags = data.split(",");
			for (var i=0; i<tags.length; i++) {
				var t = tags[i];
				var v = t.split("=");
				if(v.length == 2){
					var dat_mac=mac+"_"+v[0];
					$(".sensorbox").each(function(){
						var each_mac=$(this).attr("mac");
						if(each_mac==dat_mac){
							var d = new Date();
							var time = d.toLocaleString(); 
							$(this).find(".value").html(v[1]);
							$(this).find("time").html(time);
							$(this).find(".bwWrapper").find(".BWfade").hide();
							$(this).find(".bwWrapper").find(".gray").attr("class","colours");
							addPlot($(this), v[1]);
						}
					})
					$(".controlbox").each(function(){
						var each_mac=$(this).attr("mac");
						var mac_list = each_mac.substring(0, 23);
						var wei = each_mac.substring(25, 26);
						wei=parseInt(wei).toString(2);
						if(mac_list==mac){
							var d = new Date();
							var h = d.getHours();
							var m = d.getMinutes();
							var s = d.getSeconds();
							var time2 = h+":"+m+":"+s; 
							var li = "<li>"+time2+"<--"+dat+"</li>";
					   		$(this).find(".rt").prepend(li);
					   		//var dat_wei=parseInt(v[1]).toString(2);
					   		$(this).find(".bwWrapper").find(".BWfade").hide();
							$(this).find(".bwWrapper").find(".gray").attr("class","colours");
						}
	                })
				}
			}
		}
	}
	/*****************实时数据处理********************/
	
	
	/*****************执行设备***********************/
	$(".switch").children("button").click(function() {
			var command = $(this).attr("command");
	   		var mac = $(this).parent(".switch").parent(".switch_box").parent(".controlbox").attr("mac");
	   		mac = mac.substr(0, 23);
	   		rtc.sendMessage(mac,command);
	   		var d = new Date();
			var h = d.getHours();
			var m = d.getMinutes();
			var s = d.getSeconds();
			var time2 = h+":"+m+":"+s; 
	   		var li = "<li>"+time2+"<--"+command+"</li>";
	   		$(this).parent(".switch").parent(".switch_box").siblings(".control_message").find(".rt").prepend(li);
	});
	$(".clear").click(function() {
   		$(this).siblings(".control_message").find(".rt").html("");
	});
	/*****************执行设备***********************/
	
	
	/*****************获取历史数据********************/
	var myHisData = new WSNHistory(myZCloudID,myZCloudKey);//建立对象
	if(serverAddr != null && serverAddr != ""){
		myHisData.setServerAddr(serverAddr+":8080");
	}
	$(".chart").find(".btn-group").find("button").click(function() {
		$(this).siblings("button").each(function(){
			var class_str1 = $(this).attr("class");
			class_str1 = class_str1.replace("btn-success", "btn-default");
			$(this).attr("class",class_str1);
		})
		var class_str2 = $(this).attr("class");
		class_str2 = class_str2.replace("btn-default", "btn-success");
		$(this).attr("class",class_str2);
	})
	$("#collection").find("button").click(function(){
    	var time= $(this).attr("time");
		var dom = $(this).parent("div").parent(".chart").parent(".sensorbox");
		var unit = dom.attr("unit");
		var channel = dom.attr("mac");
		var obj = $(this).parent("div").siblings("object");
		var lineType = dom.attr("lineType");
		obj.html("<img src='pic/loading.gif' />");
		myHisData[time](channel, function(dat){
			if(dat.datapoints.length >0){
				var data =DataAnalysis(dat);
				showChart(obj,lineType, unit, false,eval(data));//将接收到的数据画曲线
			}else{
				obj.html("<center>您访问的时间段没有数据！</center>");
			}
		})
		
	})
	$("#collection").find(".Real_time").click();
	/*****************获取历史数据********************/
	
	/*****************获取图片历史数据***********************/
	$("#picture").find("button").click(function(){
		var time= $(this).attr("time");
		var dom = $(this).parent("div").parent(".chart").parent(".sensorbox");
		var channel = dom.attr("domain");
		var obj = $(this).parent("div").siblings("div");
		var id = obj.attr("id");
		var lineType = dom.attr("lineType");
		//obj.html("<img src='pic/loading.gif' />");
		console.log("channel", channel, id);
		if(time=='queryLast1H'){
			myHisData.queryLast(channel,function(dat){
				console.log("dat:", dat);
				if(dat.datapoints.length >0){
					var dat2 = JSON.parse(DataAnalysis(dat));
					time = time.replace("queryLast","");
					photoShow(id,dat2,time);
				}else{
					obj.html("<center style='margin-top:90px;font-size:32px;'>您访问的时间段没有数据！</center>");
				}
			},"duration=1hour&interval=0");
		}else{
			myHisData[time](channel, function(dat){
				console.log("dat:", dat);
				if(dat.datapoints.length >0){
					var dat2 = JSON.parse(DataAnalysis(dat));
					time = time.replace("queryLast","");
					photoShow(id,dat2,time);
				}else{
					obj.html("<center style='margin-top:90px;font-size:32px;'>您访问的时间段没有数据！</center>");
				}
			});
		}
	})	
	$("#picture").find(".Real_time").click();
	/*****************获取图片历史数据***********************/

}