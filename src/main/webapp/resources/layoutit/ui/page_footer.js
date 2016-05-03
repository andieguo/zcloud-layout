var page_footer = {

	html :  '<div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>'+
                '<span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span>'+
              '<div class="preview">项目尾</div>'+
              '<div class="view">'+
                  '<footer contenteditable="true" id = "page_footer">此处填写项目的版权信息</footer>'+
              '</div>'+
            '</div>',

    configHtml :  '<div class="attr-header">属性设置<button data-target="#close" class="close">&times;</button></div>' +
                    '<div class="attr-body">' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">项目尾信息</span>' +
                        '<input class="w150p widgetAttrChange" id = "footer_info" type="text" placeholder="项目尾信息">' +
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

    create: function() {//默认情况下无参数，可接收控件属性参数对象create(properties)
        var e = $(".demo #page_footer");
        var t = randomNumber();
        var n = "page_footer_" + t;
        var r;
        e.attr("id", n);

        var properties = {
            tid: n,
            footer_info:"项目尾信息",
            width: 300,
            height: 300,
            theme_type: 'green',//'line', 'column', 'spline', 'area', 'areaspline'
        };

        //将create()输入的属性参数绘制控件UI
    	if(arguments.length >0){
    		$.extend(properties,arguments[0]);
    	}
        
        var ui = new PageFooterUI(properties);
        return ui;
    },

    showAttr: function(properties){
        $("#footer_info").val(properties.footer_info);
        $("#widget_width").val(properties.width);
        $("#widget_height").val(properties.height);
        $("#theme_type").val(properties.theme_type);  
    },
    updateAttr: function(divid){
        var footer_info = $("#footer_info").val();
        var width = parseInt($("#widget_width").val());
        var height = parseInt($("#widget_height").val());
        var theme_type = $("#theme_type").val();

        var properties = {
            tid: divid,
            footer_info: footer_info,
            width: width,
            height: height,
            theme_type: theme_type,
        };
        
        var ui = new PageFooterUI(properties);
        return ui;
    },
}

function PageFooterUI(prop)
{
	this.properties = prop;
	var html = prop.footer_info;
	$("#"+prop.tid).html(html);
}