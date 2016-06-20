//main高度自适应
$(function docHeight() {
	var a = $(window).height() - $(".header").height() - $(".banner").height() - $(".footer").height();
	$(".main").css("height",a + "px");
});
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