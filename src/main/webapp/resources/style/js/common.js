function setModule(){//模块设置
	var height_header = $('header').height();
	var height_footer = $('footer').height();
	var heigh_window = $(window).height();
	var min_height = heigh_window-height_footer-height_header-25;
	$('#body').css("min-height",min_height);
}