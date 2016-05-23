$(function(){
	enableColor();
	mouseover();
});
//启用颜色判断
function enableColor(){
	var enableColor = $(".table-body:eq(0) .font-red");
	$.each(enableColor ,function(i) {
		if (enableColor.eq(i).html().indexOf("启用") != -1) {
			enableColor.eq(i).css("color","#24bab3");
		};
	});
};
//鼠标经过改变背景颜色
function mouseover(){
	var tr = $(".table-body tbody tr");
	tr.mouseover(function(){
		$(this).css("background-color","#F7F7F7");
	});
	tr.mouseout(function(){
		$(this).css("background-color","none");
	});
};
