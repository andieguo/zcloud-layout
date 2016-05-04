var layout_subsys = {

	html :  '<div class="lyrow ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>'+
              '<span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span>'+
              '<div class="preview">子系统标题布局</div>'+
              '<div class="view">'+
                  '<div class="panel-subsys" id = "layout_subsys">'+
                    '<h3 class="title">子系统标题</h3>'+
                    '<div class="body column"></div>'+
                  '</div>'+
              '</div>'+
            '</div>',

    configHtml :  '<div class="attr-header">属性设置<button data-target="#close" class="close">&times;</button></div>' +
                    '<div class="attr-body">' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">标题</span>' +
                        '<input class="w150p widgetAttrChange" id = "widget_title" type="text" placeholder="标题名称">' +
                      '</div><br>' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">控件宽度</span>' +
                        '<input class="w50p widgetAttrChange" id="widget_width" type="text">' +
                      '</div>' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">控件高度</span>' +
                        '<input class="w50p widgetAttrChange" id="widget_height" type="text">' +
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

    create: function() {
        var properties = {
            tid: "layout_subsys",
            title:"子系统标题",
            width: 300,
            height: 300,
            theme_type: 'green',//'line', 'column', 'spline', 'area', 'areaspline'
        };
        //将create()输入的属性参数绘制控件UI
    	if(arguments.length >0){
    		$.extend(properties,arguments[0]);
    	}
    	else{
	        var e = $(".demo #layout_subsys");
	        var t = randomNumber();
	        var n = "layout_subsys_" + t;
	        e.attr("id", n);
	        $.extend(properties,{"tid":n});
    	}
        var ui = new LayoutSubsysUI(properties);
        return ui;
    },

    showAttr: function(properties){
        $("#widget_title").val(properties.title);
        $("#widget_width").val(properties.width);
        $("#widget_height").val(properties.height);
        $("#theme_type").val(properties.theme_type);  
    },
    
    updateAttr: function(divid){
        var title = $("#widget_title").val();
        var width = parseInt($("#widget_width").val());
        var height = parseInt($("#widget_height").val());
        var theme_type = $("#theme_type").val();

        var properties = {
            tid: divid,
            title: title,
            width: width,
            height: height,
            theme_type: theme_type,
        };
        
        $("#"+divid).children("h3").text(title);
        //var ui = new LayoutSubsysUI(properties);
        return {"properties":properties};
    },
}

function LayoutSubsysUI(prop)
{
	this.properties = prop;
	var html = '<h3 class="title">'+prop.title+'</h3>'+
    		   '<div class="body column"></div>';
	$("#"+prop.tid).html(html);
}