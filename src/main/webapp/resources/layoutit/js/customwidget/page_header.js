var page_header = {

	html :  '<div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>'+
                '<span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span>'+
              '<div class="preview">项目头</div>'+
              '<div class="view">'+
              	'<div>'+
	              	'<div class="body">'+
	                  '<header class="clearfix" id="page_header">'+
	                    '<img src="'+layoutitPath+'images/prog_logo1.jpg" alt="logo">'+
	                    '<hgroup>'+
	                      '<h1>项目名称</h1>'+
	                      '<h2>此处为对项目的简单描述</h2>'+
	                    '</hgroup>'+
	                  '</header>'+
	                  '<div class="header-bg"></div>'+
	                '</div>'+
	             '</div>'+
              '</div>'+
            '</div>',

    configHtml :  '<div class="attr-header">属性设置<button data-target="#close" class="close">&times;</button></div>' +
                    '<div class="attr-body">' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">项目名称</span>' +
                        '<input class="w150p widgetAttrChange" id = "prog_name" type="text" placeholder="项目名称">' +
                      '</div><br>' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">项目描述</span>' +
                        '<input class="w200p widgetAttrChange" id="prog_des" type="text">' +
                      '</div><br>' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">项目logo</span>' +
                        '<input class="w150p widgetAttrChange" id="prog_logo" type="text">' +
                      '</div>' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">主题风格</span>' +
                        '<select class="w100p widgetAttrChange" id="theme_type">' +
                            '<option value="green" selected="selected">green</option>' +
                            '<option value="yellow">yellow</option>' +
                            '<option value="blue">blue</option>' +
                            '<option value="black">black</option>' +
                        '</select>' +
                      '</div>' +      
                ' </div>',

    create: function() {//默认情况下无参数，可接收控件属性参数对象create(properties)
        var properties = {
            tid: "page_header",
            prog_name:"项目名称",
            prog_des: "此处为对项目的简单描述",
            prog_logo: "images/prog_logo1.jpg",
            theme_type: 'green',//'line', 'column', 'spline', 'area', 'areaspline'
        };

        //将create()输入的属性参数绘制控件UI
    	if(arguments.length >0){
    		$.extend(properties,arguments[0]);
    	}
    	else{
            var e = $(".demo #page_header");
            var t = randomNumber();
            var n = "page_header_" + t;
            e.attr("id", n);
            $.extend(properties,{"tid":n});
    	}
    	
    	var ui = new PageHeaderUI(properties);
        return ui;
    },

    showAttr: function(properties){
        $("#prog_name").val(properties.prog_name);
        $("#prog_des").val(properties.prog_des);
        $("#prog_logo").val(properties.prog_logo);
        $("#theme_type").val(properties.theme_type);  
    },
    updateAttr: function(divid){
        var prog_name = $("#prog_name").val();
        var prog_des = $("#prog_des").val();
        var prog_logo = $("#prog_logo").val();
        var theme_type = $("#theme_type").val();

        $("#"+divid).find("h1").text(prog_name);
        $("#"+divid).find("h2").text(prog_des);
        $("#"+divid).find("img").attr("src",prog_logo);

        var properties = {
            tid: divid,
            prog_name: prog_name,
            prog_des: prog_des,
            prog_logo: prog_logo,
            theme_type: theme_type,
        };
        
        var ui = new PageHeaderUI(properties);
        return ui;
    },
}

function PageHeaderUI(prop)
{
	this.properties = prop;
	var html = '<img src="'+layoutitPath+prop.prog_logo+'" alt="logo">'+
			   '<hgroup>'+
			   '<h1 contenteditable="true">'+prop.prog_name+'</h1>'+
			   '<h2 contenteditable="true">'+prop.prog_des+'</h2>'+
			   '</hgroup>';
	$("#"+prop.tid).html(html);
}