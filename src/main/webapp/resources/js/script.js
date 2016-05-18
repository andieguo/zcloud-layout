$(function() {
	docHeight();
	topNav();
	configChange(0);
});
$(window).resize(function () {
	docHeight();
});
//nav、main高度自适应
function docHeight() {
	var a = $(window).height() - $(".header").height() - $(".banner").height() - $(".footer").height();
	$(".topNav").css("height",a - 20 + "px");
	$(".main").css("height",a + "px");
	$("#iframe").css("height",a + "px");
};
//nav下拉效果
function topNav(){
	var a = $(".topNav").children("li");
	var b = a.children("a");
	var lastClickTime = new Date().getTime();
	var delay = 300; //单击时间间隔
	b.click(function(){
		if (new Date().getTime() - lastClickTime < delay) {return;};
		lastClickTime = new Date().getTime();
		if ($(this).siblings("ul").css("display") == ("none")) {
			$.each(a, function(i){
				if (a.eq(i).children("ul").css("display") == "block") {
					a.eq(i).children("ul").slideToggle(250);
					a.eq(i).find("i").removeClass("icon-on").addClass("icon-off");
				};
			});
			$(this).siblings("ul").slideToggle(250);
			$(this).siblings("i").removeClass("icon-off").addClass("icon-on");
		};
	});
};
//硬件数据配置：切换按钮
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