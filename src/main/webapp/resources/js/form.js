//main高度自适应
$(function docHeight() {
	var a = $(window).height() - $(".header").height() - $(".banner").height() - $(".footer").height();
	$(".main").css("height",a + "px");
});
//模板类型改变事件
function templateTypeChange(url){
	var type = $("#templateType").val();
	if(type != -1){
		 $.ajax({//提交给后台
				url : url,
				type : 'post',
				data : {'type':type},
				dataType : 'json',
				beforeSend:function(){
					//这里是开始执行方法，显示效果，效果自己写
					var a = new ProgressBar();
					a.start();
				},
				//complete:function(){
					//方法执行完毕，效果自己可以关闭，或者隐藏效果
				//},
				success : function(data) {//返回的data本身即是一个JSON对象
					if(data.status == 1){//push成功
						var array = data.data[0];
						$('#templateList').empty();
						$('#templateList').append("<option value='-1'>请选择</option>");
						for(var i=0;i<array.length;i++){
							var tid = array[i].tid;
							var name = array[i].name;
// 							console.log("tid:"+tid);
							$('#templateList').append("<option value='"+tid+"'>"+name+"</option>");
						}

						var a = new ProgressBar();
						a.end();
						
					}else if(data.status==0){//push失败，恢复UI部分
						console.log("failed");
					}
				},
				error : function() {
					alert("您请求的页面有异常 ");
				}
		});
	}else{
		$('#templateList').empty();
	}
}
//模板ID改变事件
function templateIdChange(url){
	var tid = $("#templateList").val();
	if(tid != -1){
		$.ajax({//提交给后台
				url : url,
				type : 'post',
				data : {'id':tid},
				dataType : 'json',
				beforeSend:function(){
					//这里是开始执行方法，显示效果，效果自己写
					var a = new ProgressBar();
					a.start();
				},
				//complete:function(){
					//方法执行完毕，效果自己可以关闭，或者隐藏效果
				//},
				success : function(data) {//返回的data本身即是一个JSON对象
					if(data.status == 1){
						console.log("data:"+data.data);
						dataJson = JSON.parse(data.data);
						if ($("#config")[0]) {
							contentBuild(dataJson)
							configNavActive()
						}
						var a = new ProgressBar();
						a.end();
						
					}else if(data.status==0){
						console.log("failed");
					}
				},
				error : function() {
					alert("您请求的页面有异常 ");
				}
		});
	}
}
//进度条
var ProgressBar = function () {
	this.start = function () {
		parent.$("body").prepend('<div id="progress-bar"></div>');
		parent.$("#progress-bar").animate({width:'30%'},"slow")
	}
	this.end = function () {
		parent.$("#progress-bar").animate({
			"width": "100%"
		}, function () {
			$(this).remove()
		})
	}
};
//构造UI编辑视图
function contentBuild(dataJson){
	//加载title
	var content = "<div class='head'>";
	$.each(dataJson,function(name,value) {
		if(typeof(value.dataType) != 'undefined'){
			content = content + "<a>"+ value.title+"</a>";
		}
	});
	content = content + "</div>";
	//加载content	
	$.each(dataJson,function(name,value) {
		if(typeof(value.dataType) != 'undefined'){
			if(value.dataType == 'video'){
				content = content + "<div class='video body hide' id="+value.tid+">"
				 + "<label>摄像头地址：</label><input type='text' value='Camera:192.168.1.91:81' class='address'><hr>"
				 + "<label>用户名：</label><input type='text' value='admin' class='user'><hr>"
				 + "<label>密码：</label><input type='text' value='admin' class='pwd'><hr>"
				 + "<label>摄像头类型：</label><input type='text' value='H3-Series' class='camtype'>"
				 + "</div>";
			}else{
				content = content + "<div class='sensor body hide' id="+value.tid+">"
				 + "<label>地址：</label><input type='text' value='' class='address'><hr>"
				 + "<label>通道：</label><input type='text' value='' class='channel'><hr>"
				 + "<label>命令：</label><input type='text' value='{}' class='command'>"
				 + "</div>";		
			}
		}
	});
	$("#config").html(content);
}
//硬件数据配置：active
function configNavActive(){
	var head = $("#config .head").children("a");
	var body = $("#config .body");
	head.eq(0).addClass("active");
	body.eq(0).removeClass("hide");
	head.click(function(){
		var n = $(this).index();
		if ($("#config .body").eq(n).css("display") == ("none")) {
			$.each(body, function(i){
				body.eq(i).hide();
			});
			$.each(head, function(i){
				head.eq(i).removeClass("active");
			});
			body.eq(n).show();
			$(this).addClass("active");
			configChange(n);
		};
	});

	for (var ii = 0; ii <= head.length - 1; ii++) {
		var bodyInput = body.eq(ii).find("input");
		var value = "";
		for (var i = 0; i <= bodyInput.length - 1; i++) {
			value += bodyInput.eq(i).attr("value");
		};
		if (value) {
			head.eq(ii).addClass("on");
		};
	};
};
//硬件数据配置：change
function configChange(a){
	var n = $("#config .body").eq(a).children("input");
	n.change(function(){
		var head = $("#config .head").children("a");
		head.eq(a).addClass("on");
		var value = "";
		for (var i = 0; i <= n.length - 1; i++) {
			value += n.eq(i).val();
		};
		if (!value) {
			head.eq(a).removeClass("on");
		};
	});
};
//关闭美图秀秀弹窗
function loadImgClose(){
	$(".altContent-shell").eq(0).css("display","none");
	$("#editForm").removeClass("filter");
};