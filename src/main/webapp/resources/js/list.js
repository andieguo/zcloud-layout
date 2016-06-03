$(function(){
	mouseover();
});

//启用颜色判断
function stateColor(){
	var stateColor = $(".state-text");
	stateColor.each(function (){
		if ($(this).attr("visible") == 0) {
			$(this).css("color","#e60016");
		}else {
			$(this).css("color","#24bab3");
		};
	});
};
//状态判断
function stateImage(){
	var stateImage = $(".state-image");
	stateImage.each(function (){
		var valueNode = $(this).parents("tr").find("a[visible]")
		console.log(23);
		if(valueNode.attr("visible") == 0) {
			$(this).removeClass("state-off").addClass("state-on");
		}else {
			$(this).removeClass("state-on").addClass("state-off");
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

