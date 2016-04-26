$(function(){
	$(".switch_box").children(".switch_down").click(function(){
		var switch_height = $(this).siblings(".switch").height();//height值
		var switch_top = parseInt($(this).siblings(".switch").css("marginTop").replace('px','')); //margin-top值 
		if((switch_height+switch_top)>160){
			switch_top=switch_top-160;
			switch_top=switch_top+"px";
			$(this).siblings(".switch").animate({marginTop :switch_top});
		}
	})
	
	$(".switch_box").children(".switch_up").click(function(){
		var switch_top = parseInt($(this).siblings(".switch").css("marginTop").replace('px','')); //margin-top值 
		if(switch_top<0){
			switch_top=switch_top+160;
			switch_top=switch_top+"px";
			$(this).siblings(".switch").animate({marginTop :switch_top});
		}
	})
})