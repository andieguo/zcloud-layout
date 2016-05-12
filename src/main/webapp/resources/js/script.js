$(function() {
	docHeight();
	topNav();
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