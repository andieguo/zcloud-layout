//初始化查询操作
ac = new WSNAutoctrl();

//时间循环函数
function loopDay(){
	var html = '<select class="form-control" id="day" style="width:30%">';
	for(var i=1;i<=31;i++){	
		html += '<option value="'+i+'">'+i+'号</option>';
	}
	html += '</select>';
	return html;
}
function loopWeek(){
	var obj= ["周日", "周一", "周二","周三", "周四", "周五","周六"];
	var html = '<select class="form-control" id="week" style="width:30%">';
	for(i=0;i<7;i++){	
		html += '<option value="'+i+'">'+obj[i]+'</option>';
	}
	html += '</select>';	
	return html;
}

function loopHour(){
	var html = '<select class="form-control" id="hour" style="width:30%">';
	for(i=0;i<=23;i++){	
		html += '<option value="'+i+'">'+i+'时</option>';
	}
	html += '</select>';	
	return html;
}
function loopMinute(){
	var html = '<select class="form-control" id="minute" style="width:30%">';
	for(i=0;i<=59;i++){	
		html += '<option value="'+i+'">'+i+'分</option>';
	}
	html += '</select>';	
	return html;
}
function loopSecond(){
	var html = '<select class="form-control" id="second" style="width:30%">';
	for(i=0;i<=59;i++){	
		html += '<option value="'+i+'">'+i+'秒</option>';
	}
	html += '</select>';	
	return html;
}
//时间循环函数


//触发器、执行器、执行任务与执行记录切换
function switchOver(obj){
	$(obj).siblings().each(function(){
	    var id = $(this).attr("id");
		$("."+id).hide();
		$(this).attr("class","btn btn-default");
	});
	var id = $(obj).attr("id");
	$("."+id).show();
	$(obj).attr("class","btn btn-success");
}

//切换触发器类型
function trTypeChange(val){
	$(".tr_type_sensor").hide();
	$(".tr_type_timer").hide();
	if(val=="sensor"){
		$(".tr_type_sensor").show();
	}else if(val=="timer"){
		$(".tr_type_timer").show();
		$(".appoint").show();
		$(".loop").hide();
		$("#tr_way").find("option:eq(0)").attr("selected",true);
	}
}
//切换触发器类型时间选择
function trWayChange(val){
	$(".loop").hide();
	$(".appoint").hide();
	if(val=="appoint"){
		$(".appoint").show();
	}else if(val=="loop"){
		$(".loop").show();
		trWayLoop("month");
	}
}
//切换触发器类型时间选择循环方式
function trWayLoop(val){
	switch(val){
		case "month":
			$("#tr_way_loop").children("select").remove();
			$("#tr_way_loop").append(loopDay());
			$("#tr_way_loop").append(loopHour());
			$("#tr_way_loop").append(loopMinute());
		break;
		case "week":
			$("#tr_way_loop").children("select").remove();
			$("#tr_way_loop").append(loopWeek());
			$("#tr_way_loop").append(loopHour());
			$("#tr_way_loop").append(loopMinute());
		break;
		case "day":
			$("#tr_way_loop").children("select").remove();
			$("#tr_way_loop").append(loopHour());
			$("#tr_way_loop").append(loopMinute());
		break;
		case "hour":
			$("#tr_way_loop").children("select").remove();
			$("#tr_way_loop").append(loopMinute());
			$("#tr_way_loop").append(loopSecond());
		break;
		case "minute":
			$("#tr_way_loop").children("select").remove();
			$("#tr_way_loop").append(loopSecond());
		break;
	}
}

//切换执行器类型
function acTypeChange(val){
	$(".ac_type_sensor").hide();
	$(".ac_type_ipcamera").hide();
	$(".ac_type_phone").hide();
	$(".ac_type_job").hide();
	if(val=="sensor"){
		$(".ac_type_sensor").show();
	}else if(val=="ipcamera"){
		$(".ac_type_ipcamera").show();
	}else if(val=="phone"){
		$(".ac_type_phone").show();
	}else if(val=="job"){
		$(".ac_type_job").show();
		ac.setIdKey($("#input_aid").val(), $("#input_xkey").val());	    				
		ac.setServerAddr($("#input_saddr").val());
		ac.getJob("",function(dat){
			$("#ac_job_number").html("");
			for(var i = 0;i<dat.length;i++){
				var html = '<option value="'+dat[i].id+'">'+dat[i].name+'</option>';
				$("#ac_job_number").append(html);
			}
		});
	}
}

//创建job获取执行器与触发器信息
function getAidTid(){
	ac.setIdKey($("#input_aid").val(), $("#input_xkey").val());	    				
	ac.setServerAddr($("#input_saddr").val());	
	ac.getTrigger("", function(dat){
		$("#sel_job_tids").html("");
		for(var i = 0;i<dat.length;i++){
			var html = '<option value="'+dat[i].id+'">'+dat[i].name+'</option>';
			console.log(html);
			$("#sel_job_tids").append(html);
		}
	});
	ac.getActuator("",function(dat){
		$("#sel_job_aids").html("");
		for(var i = 0;i<dat.length;i++){
			var html = '<option value="'+dat[i].id+'">'+dat[i].name+'</option>';
			console.log(html);
			$("#sel_job_aids").append(html);
		}
	});
}
function selJobTids(){
	var val = $("#job_tids").val();
	var num = $("#sel_job_tids").val();
	if(val.length>0){
		$("#job_tids").val(val+","+num);
	}else{
		$("#job_tids").val(num);
	}
}
function selJobAids(){
	var val = $("#job_aids").val();
	var num = $("#sel_job_aids").val();
	if(val.length>0){
		$("#job_aids").val(val+","+num);
	}else{
		$("#job_aids").val(num);
	}
}
//创建job获取执行器与触发器信息
$(document).ready(function(){
	
	trTypeChange("sensor");
	acTypeChange("sensor");
	$(".form_datetime").datetimepicker({
        format: "yyyy-mm-dd hh:ii:ss",
        autoclose: true,
        todayBtn: true,
        pickerPosition: "bottom-left",
        language:"zh-CN"
	});
	//查询触发器
	$("#btn_tr_find").click(function(){
		ac.setIdKey($("#input_aid").val(), $("#input_xkey").val());	    				
		ac.setServerAddr($("#input_saddr").val());	
		var num;
		if(isNaN(parseInt($("#input_trid").val()))){//传递字符串不能转换为数字查询所有ID
			num = "";
		}else{//传递字符串能转换为数字查询指定ID
			num = parseInt($("#input_trid").val());
		}
		ac.getTrigger(num, function(dat){
			$(".query_tr").find("tbody").html("");
			for(var i = 0;i<dat.length;i++){
				var html = "<tr><td><input type='checkbox' class='check_tr'/> <span>"+dat[i].id+"</span></td><td>"+dat[i].name+"</td><td>"+JSON.stringify(dat[i].param)+"</td><td>"+dat[i].type+"</td><td>"+dat[i].ctime+"</td></tr>"; 
				$(".query_tr").find("tbody").append(html);
			}
		});

	});
	//创建触发器
	$("#btn_tr_new").click(function(){
		ac.setIdKey($("#input_aid").val(), $("#input_xkey").val());	    				
		ac.setServerAddr($("#input_saddr").val());	
		var name = $("#tr_name").val();
		var type = $("#tr_type").val();
		//判断触发器类型
		if(type=="sensor"){
			var status = $("#tr_once").val();
			if(status=="true"){
				status =true;
			}else{
				status =false;
			}
			var pa = {
				"mac": $("#tr_mac").val(), 
				"ch": $("#tr_ch").val(), 			
				"op": $("#tr_op").val(),
				"value": $("#tr_value").val(), 			
				"once": status
			};
		}else if(type=="timer"){
			var tr_way = $("#tr_way").val();
			if(tr_way == "appoint"){
				var tr_appoint_time = $("#tr_appoint_time").val();
				var t = tr_appoint_time.split(" ");
				var m = t[0].split("-");
				var n = t[1].split(":");
				var pa = {"year": m[0],"month": m[1],"week": "*","day": m[2],"hour": n[0],"minute": n[1],"second": n[2]};
			}else if(tr_way == "loop"){
				var tr_loop = $("#tr_loop").val();
				var tr_loop_val = $("#tr_loop_val").val();
				var month = $("#month").val();
				var week = $("#week").val();
				var day = $("#day").val();
				var hour = $("#hour").val();
				var minute = $("#minute").val();
				var second = $("#second").val();
				var pa = {"year": "*","month": "*","week": "*","day_of_week":"*","day": "*","hour": "*","minute": "*","second": "0"};
				switch(tr_loop){
					case "minute":
						pa["minute"] = "*/"+tr_loop_val;
						pa["second"] = second;
					break;
					case "hour":
						pa["hour"] = "*/"+tr_loop_val;
						pa["minute"] = minute;
						pa["second"] = second;
					break;
					case "day":	
						pa["day"] = "*/"+tr_loop_val;
						pa["hour"] = hour;
						pa["minute"] = minute;
					break;
					case "week":
						pa["week"] = "*/"+tr_loop_val;
						pa["day_of_week"] = week;
						pa["hour"] = hour;
						pa["minute"] = minute;
					break;
					case "month": 
						pa["month"] = "*/"+tr_loop_val;
						pa["day"] = day;
						pa["hour"] = hour;
						pa["minute"] = minute;
					break;
				}
			}
		}
		ac.createTrigger(name, type, pa, function(dat){
			console.log(dat);
			$("#btn_tr_find").click();
		});
	});
	//删除触发器
	$("#btn_tr_del").click(function(){
		ac.setIdKey($("#input_aid").val(), $("#input_xkey").val());	    				
		ac.setServerAddr($("#input_saddr").val());	
		$(".check_tr").each(function(){
			if($(this).is(':checked')){
				var num = $(this).siblings("span").text();
				ac.deleteTrigger(num);
			}
		});
		setTimeout('$("#btn_tr_find").click()', 1000 );
	});
	$(".tr_all").click(function(){
		if($(this).is(':checked')){
			$(".check_tr").attr("checked","checked");
		}else{
			$(".check_tr").removeAttr("checked");
		}
	});
	//////////////////////////////////////

	$("#btn_ac_find").click(function(){
		ac.setIdKey($("#input_aid").val(), $("#input_xkey").val());	    				
		ac.setServerAddr($("#input_saddr").val());	
		var num;
		if(isNaN(parseInt($("#input_acid").val()))){
			num = "";
		}else{
			num = parseInt($("#input_acid").val());
		}
		ac.getActuator(num,function(dat){
			$(".query_ac").find("tbody").html("");
			for(var i = 0;i<dat.length;i++){
				var html = "<tr><td><input type='checkbox' class='check_ac'/> <span>"+dat[i].id+"</span></td><td>"+dat[i].name+"</td><td>"+JSON.stringify(dat[i].param)+"</td><td>"+dat[i].type+"</td><td>"+dat[i].ctime+"</td></tr>"; 
				$(".query_ac").find("tbody").append(html);
			}
		});
	});
	$("#btn_ac_new").click(function(){
		ac.setIdKey($("#input_aid").val(), $("#input_xkey").val());	    				
		ac.setServerAddr($("#input_saddr").val());	
		var name = $("#ac_name").val();
		var type = $("#ac_type").val();
		var pa = { };
		switch(type){
			case "sensor":
				pa["mac"] = $("#ac_sensor_mac").val();
				pa["data"] = $("#ac_sensor_data").val();
			break;
			case "ipcamera":
				pa["mac"] = $("#ac_ipcamera_mac").val();
				pa["type"] = $("#ac_ipcamera_type").val();
				pa["user"] = $("#ac_ipcamera_user").val();
				pa["pwd"] = $("#ac_ipcamera_pwd").val();
				pa["data"] = $("#ac_ipcamera_action").val();
			break;
			case "phone":
				pa["mac"] = $("#ac_phone_number").val();
				pa["data"] = $("#ac_phone_data").val();
			break;
			case "job":
				var status = $("#ac_job_data").val();
				if(status=="true"){
					status =true;
				}else{
					status =false;
				}
				pa["jid"] = $("#ac_job_number").val();
				pa["enable"] = status; 
			break;
		}
		ac.createActuator(name, type, pa, function(dat){
			console.log(dat);
			$("#btn_ac_find").click();
		});
	});
	$("#btn_ac_del").click(function(){
		ac.setIdKey($("#input_aid").val(), $("#input_xkey").val());	    				
		ac.setServerAddr($("#input_saddr").val());
		$(".check_ac").each(function(){
			if($(this).is(":checked")){
				var num = $(this).siblings("span").text();
				ac.deleteActuator(num, function(dat){
    				console.log("del ok");
    			});
			}
		});
		setTimeout('$("#btn_ac_find").click()', 1000 );
	});	  
	$(".ac_all").click(function(){
		if($(this).is(':checked')){
			$(".check_ac").attr("checked","checked");
		}else{
			$(".check_ac").removeAttr("checked");
		}
	});
	//////////////////////////////////////////////
	$("#btn_job_find").click(function(){
		ac.setIdKey($("#input_aid").val(), $("#input_xkey").val());	    				
		ac.setServerAddr($("#input_saddr").val());
		var num;
		if(isNaN(parseInt($("#input_jobid").val()))){
			num = "";
		}else{
			num = parseInt($("#input_jobid").val());
		}
		ac.getJob(num,function(dat){
			$(".query_job").find("tbody").html("");
			for(var i = 0;i<dat.length;i++){
				var html = "<tr><td><input type='checkbox' class='check_job'/> <span>"+dat[i].id+"</span></td><td>"+dat[i].name+"</td><td>"+dat[i].enable+"</td><td>"+JSON.stringify(dat[i].param)+"</td><td>"+dat[i].ctime+"</td></tr>"; 
				$(".query_job").find("tbody").append(html);
			}
		});
	});
	$("#btn_job_new").click(function(){
		ac.setIdKey($("#input_aid").val(), $("#input_xkey").val());	    				
		ac.setServerAddr($("#input_saddr").val());
		var name = $("#job_name").val();
		var status = $("#job_status").val();
		if(status=="true"){
			status =true;
		}else{
			status =false;
		}
		var pa = {
			tids:[],
			aids:[]
		};
		var job_tids = $("#job_tids").val();
		var job_aids = $("#job_aids").val();
		var t = job_tids.split(",");
		var a = job_aids.split(",");
		for(var i=0;i<t.length;i++){
			pa.tids[i] = parseInt(t[i]);
		}
		for(var i=0;i<a.length;i++){
			pa.aids[i] = parseInt(a[i]);
		}
		ac.createJob(name, status, pa, function(dat){
			console.log(dat);
			$("#btn_job_find").click();
		});
	});
	$("#btn_job_del").click(function(){
		ac.setIdKey($("#input_aid").val(), $("#input_xkey").val());	    				
		ac.setServerAddr($("#input_saddr").val());
		$(".check_job").each(function(){
			if($(this).is(":checked")){
				var num = $(this).siblings("span").text();
				ac.deleteJob(num, function(dat){
    				console.log("job del ok");
    			});
			}
		});
		setTimeout('$("#btn_job_find").click()', 1000 );
	});
	$("#btn_job_en").click(function(){
		ac.setIdKey($("#input_aid").val(), $("#input_xkey").val());	    				
		ac.setServerAddr($("#input_saddr").val());
		$(".check_job").each(function(){
			if($(this).is(":checked")){
				var num = $(this).siblings("span").text();
				var status = $(this).parent("td").parent("tr").children("td:eq(2)").html();
				if(status=="true"){
					status =false;
				}else{
					status =true;
				}
				console.log(status);
				ac.setJob(num, status, function(dat){
    				console.log('set en ok');
    			});
			}
		});
		setTimeout('$("#btn_job_find").click()', 1000 );
	});
	$(".job_all").click(function(){
		if($(this).is(':checked')){
			$(".check_job").attr("checked","checked");
		}else{
			$(".check_job").removeAttr("checked");
		}
	});
	////////////////////////////////////////////////
	$("#btn_sc_find").click(function(){
		ac.setIdKey($("#input_aid").val(), $("#input_xkey").val());	    				
		ac.setServerAddr($("#input_saddr").val());
		var opt = {};
		
		//var paramet = $("#input_scid").val();
		//var parameter = paramet.replace(/[0-9]/g,"");
		var NA=isNaN(parseInt($("#input_scid").val()));
		if(!NA){
			opt['jid'] = parseInt($("#input_scid").val());
		}
		var du = $("#select_sc_duration").val();
		opt['duration'] = du;
		
		ac.getSchedudler(opt,  function(dat){
			$(".query_sc").find("tbody").html("");
			for(var i = 0;i<dat.length;i++){
				var html = "<tr><td><input type='checkbox' class='check_sc' /> <span>"+dat[i].id+"</span></td><td>"+dat[i].jid+"</td><td>"+dat[i].at+"</td></tr>"; 
				$(".query_sc").find("tbody").append(html);
			}
			console.log(dat);
		});
	});
    $("#btn_sc_del").click(function(){
    	ac.setIdKey($("#input_aid").val(), $("#input_xkey").val());	    				
		ac.setServerAddr($("#input_saddr").val());
		$(".check_sc").each(function(){
			if($(this).is(":checked")){
				var num = $(this).siblings("span").text();
				ac.delSchedudler(num, function(dat){
    	    		console.log('del scxxx ok');
    	    	});
			}
		});
    	setTimeout('$("#btn_sc_find").click()', 1000 );
	});
	$(".sc_all").click(function(){
		if($(this).is(':checked')){
			$(".check_sc").attr("checked","checked");
		}else{
			$(".check_sc").removeAttr("checked");
		}
	});
});