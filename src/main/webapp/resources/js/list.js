$(function(){
	mouseover();
});

//启用颜色判断
function stateColor(){
	var stateColor = $(".state-text");
	stateColor.each(function (){
		if ($(this).parents("tr").attr("visible") == 0) {
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
		var valueNode = $(this).parents("tr");
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
//使能project
function enableAction(url){
	var stateText = $(".state-text");
	stateText.click(function(){
		//var url = "${basePath}/project/enable";
		var status = $(this).parents("tr").attr("visible");
		var id = $(this).parents("tr").find("tt").text();
		var partentThis = $(this);
		var r = confirm("亲，确定要执行启用操作么？")
		if (r == true) {
			$.ajax({//提交给后台
				url : url,
				type : 'post',
				data : {'id':id,'deleted':status},
				dataType : 'json',
				success : function(data) {//返回的data本身即是一个JSON对象
					if(data.status == 1){//push成功
						if(status == 1){
							partentThis.parents("tr").attr("visible",0);
							partentThis.text("停用");
						}else if(status == 0){
							partentThis.parents("tr").attr("visible",1);
							partentThis.text("启用");
						}
						stateColor();
						stateImage();
					}else if(data.status==0){//push失败，恢复UI部分
						console.log("failed");
					}
				},
				error : function() {
					alert("您请求的页面有异常 ");
				}
			});
		}else {
			return;
		}
	})
};
