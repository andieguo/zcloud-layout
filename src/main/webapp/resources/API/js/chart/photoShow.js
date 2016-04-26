var serverTime = Math.round(new Date().getTime()/1000);
function getSecond(num_data){
	var num=parseInt(num_data);
	var num_type=num_data.replace(/[0-9]/g,"");
	switch(num_type){
		case "H": return num*60*60; break;
		case "D": return num*60*60*24; break;
		case "W": return num*7*60*60*24; break;
		case "M": return num*60*60*24*30; break;
		case "Y": return num*60*60*24*365; break;
		default: return num*60*60*24;	
	}
}
function getEnd(d,second){
	null == second && (second = 0);
	second = d.getTime() - second*1000;
	var d = new Date(second);
	(d.getMonth()+1)<10?mo='0'+(d.getMonth()+1):mo=d.getMonth()+1;
	d.getDate()<10?day='0'+d.getDate():day=d.getDate();
	d.getHours()<10?h='0'+d.getHours():h=d.getHours();
	d.getMinutes()<10?mi='0'+d.getMinutes():mi=d.getMinutes();
	d.getSeconds()<10?s='0'+d.getSeconds():s=d.getSeconds();
	var time = d.getFullYear()+"-"+mo+"-"+day+"T"+h+":"+mi+":"+s+"Z";
	return time;	
}
function showImg(obj){
	var src= $(obj).attr("osrc");
	console.log('click', src);
	$("#popupImg").find("img").attr("src",src);
	$("#popupImg").show();
}

function hideImg(){
	$("#popupImg").find("img").attr("src");
	$("#popupImg").hide();
}
var mytimeline = [];
var	options = {
		"height": "315px",
		"style": "box"
	};
function photoShow(sensor_id,dat,time) {
	var second = getSecond(time);
	mytimeline[sensor_id] = {
		sensor_id: sensor_id,
		data: [],
		dataBuffer: '%',
		start: null,
		timeline: new links.Timeline(document.getElementById(sensor_id)),
		fromRelease: serverTime,
		fromOld: 0,
		toRelease: 4100731932,  //don`t change this time, connect with user_controller.php sensor_photo_data()
		toOld: 0,
		delay: getNowTime(),
		circlingReleaseInterval: null,
		dataArray: [],
		count: 0,
		onRangeChangeCall: null
	};
	//draw timeline
	mytimeline[sensor_id].timeline.draw(mytimeline.data, options);
	//set timeline visible time range
	var start = new Date((serverTime - 1.3*second) * 1000);
	var end   = new Date((serverTime +  0.1*second) * 1000);
	mytimeline[sensor_id].timeline.setVisibleChartRange(start, end);

	//get release data
	callBackPhoto(mytimeline[sensor_id], true,dat);
	//mytimeline[sensor_id].circlingReleaseInterval = setInterval(function(){callBackPhoto(mytimeline[sensor_id], true); }, 10000);
        
    // attach an event listener using the links events handler
    //links.events.addListener(mytimeline[sensor_id].timeline, 'rangechanged', function(){ onRangeChanged(mytimeline[sensor_id]);});
}

function callBackPhoto(mytimeline, release,dat) {
	if(dat.length > 0){
		mytimeline.fromRelease = (dat[dat.length-1][0]-28800*1000)/1000;
		console.log((dat[dat.length-1][0])/1000);
		for(i=0; i<dat.length; i++){
			var img_url = dat[i][1];
			var img_url_s = img_url.substring(0, img_url.length-5)+"_75x75"+img_url.substring(img_url.length-5);
			//console.log(img_url);

			if(mytimeline.dataBuffer.indexOf((dat[i][0]-28800*1000)/1000) < 0){
				mytimeline.dataBuffer = mytimeline.dataBuffer.concat((dat[i][0]-28800*1000)/1000+'%');
				var style = 'width:64px; height:48px;';
				//插入图片
				//mytimeline.data.push({'start': new Date((dat[i][0])/1000-28800*1000),'content': '<img src=\"' + img_url +'\" style="' + style + 'cursor: pointer;" onclick="showImg(this);" alt="图片加载中..." title="点击查看大图">'});
				mytimeline.data.push({'start': new Date(dat[i][0]-28800*1000),'content': '<img src=\"' +img_url_s +'\" osrc=\"'+dat[i][1]+'\"'+' style="' + style + 'cursor: pointer;" onclick="showImg(this);" alt="图片加载中..." title="点击查看大图">'});
				if((dat[dat.length-1][0]-28800*1000)/1000 > getEndTime(mytimeline) || (dat[dat.length-1][0]-28800*1000)/1000 < getStartTime(mytimeline)){
					$('#info'+mytimeline.sensor_id).show();
				}
		    }										
		}		
		//Set new data in timeline
		mytimeline.timeline.setData(mytimeline.data);
	}
}

function onRangeChanged(mytimeline) {
	/*如果当前时间线在start end之间，隐藏新图像提示*/
	var now_time = getNowTime();
	if(now_time > getStartTime(mytimeline) && now_time < getEndTime(mytimeline))
	{
		$('#info'+mytimeline.sensor_id).hide(); 
	}
	//如果当前时间线小于start，隐藏未完全显示提示
	if(now_time < getStartTime(mytimeline)){
		$('#infoShow'+mytimeline.sensor_id).hide();
	}
	
//	if(mytimeline.onRangeChangeCall == null){
//		mytimeline.onRangeChangeCall = setTimeout(function(){callBackPhoto(mytimeline, false);}, 1500);
//	}
//	if(getNowTime() - mytimeline.delay < 1000){
//		clearTimeout(mytimeline.onRangeChangeCall);
//		mytimeline.onRangeChangeCall = setTimeout(function(){callBackPhoto(mytimeline, false);}, 1500);
//	}
	mytimeline.delay = getNowTime();
}
//以秒为时间单位
function getNowTime(){
	return new Date(new Date()).getTime()/1000;
}

function getStartTime(mytimeline){
	return new Date(mytimeline.timeline.getVisibleChartRange().start).getTime()/1000;
}

function getEndTime(mytimeline){
	return new Date(mytimeline.timeline.getVisibleChartRange().end).getTime()/1000;
}