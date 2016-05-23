//main高度自适应
$(function docHeight() {
	var a = $(window).height() - $(".header").height() - $(".banner").height() - $(".footer").height();
	$(".main").css("height",a + "px");
});
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