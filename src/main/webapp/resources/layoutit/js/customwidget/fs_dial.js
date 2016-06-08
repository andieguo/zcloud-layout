var fs_dial = {

  	html : ' <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>'+
                   '<span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span>'+
                   '<div class="preview">表盘-fs</div>' +
                   '<div class="view">' +
	                   '<div class="panel-sensor">'+
						   '<h3 class="title">温度</h3>'+
						   '<div class="body">'+
							   '<div id="fs_dial">'+
							   '</div>'+
						   '</div>'+
					   '</div>'+
                   '</div>'+
             '</div>',

    configHtml :'<div class="attr-header">属性设置<button data-target="#close" class="close">&times;</button></div>' +
                    '<div class="attr-body">' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">标题</span>' +
                        '<input class="w150p widgetAttrChange" id = "widget_title" type="text" placeholder="标题名称">' +
                      '</div><br>' +
                      /*'<div class="input-prepend mr10p">' +
                        '<span class="add-on">控件宽度</span>' +
                        '<input class="w50p widgetAttrChange" id="widget_width" type="text">' +
                      '</div>' +*/
                      /*'<div class="input-prepend mr10p">' +
                        '<span class="add-on">控件高度</span>' +
                        '<input class="w50p widgetAttrChange" id="widget_height" type="text">' +
                      '</div>' +*/
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">最小值</span>' +
                        '<input class="w50p widgetAttrChange" id="min_value" type="text">' +
                      '</div>' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">最大值</span>' +
                        '<input class="w50p widgetAttrChange" id="max_value" type="text">' +
                      '</div>' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">单位</span>' +
                        '<input class="w50p widgetAttrChange" id="value_unit" type="text">' +
                      '</div><br>' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">layer1.from</span>' +
                        '<input class="w50p widgetAttrChange" id="layer1_from" type="text">' +
                      '</div>' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">layer1.to</span>' +
                        '<input class="w50p widgetAttrChange" id="layer1_to" type="text">' +
                      '</div>' +    
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">layer1.color</span>' +
                        '<input class="w100p widgetAttrChange" id="layer1_color" type="text">' +
                      '</div><br>' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">layer2.from</span>' +
                        '<input class="w50p widgetAttrChange" id="layer2_from" type="text">' +
                      '</div>' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">layer2.to</span>' +
                        '<input class="w50p widgetAttrChange" id="layer2_to" type="text">' +
                      '</div>' +    
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">layer2.color</span>' +
                        '<input class="w100p widgetAttrChange" id="layer2_color" type="text">' +
                      '</div><br>' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">layer3.from</span>' +
                        '<input class="w50p widgetAttrChange" id="layer3_from" type="text">' +
                      '</div>' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">layer3.to</span>' +
                        '<input class="w50p widgetAttrChange" id="layer3_to" type="text">' +
                      '</div>' +    
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">layer3.color</span>' +
                        '<input class="w100p widgetAttrChange" id="layer3_color" type="text">' +
                      '</div>' +                  
                ' </div>',           

    create: function(){//默认情况下无参数，可接收控件属性参数对象create(properties)
        var properties = {
            tid: "fs_dial",
            title:"温度",
            //width: 233,
            //height: 233,
            min: 0,
            max: 120,
            unit: "℃",
            layer1: {"minvalue": "0","maxvalue": "50","code": "C1E1C1","alpha": "80"},
            layer2: {"minvalue": "50","maxvalue": "85","code": "F6F164","alpha": "80"},
            layer3: {"minvalue": "85","maxvalue": "120","code": "F70118","alpha": "80"},
            dataType:'realTime'
        };
        
        //将create()输入的属性参数绘制控件UI
    	if(arguments.length >0){
    		$.extend(properties,arguments[0]);
    	}
    	else{
        	var e = $(".demo #fs_dial");
      		var t = randomNumber();
      		n = "fs_dial_" + t;
      		e.attr("id", n);
      		$.extend(properties,{"tid":n});
    	}
    	
        var ui = new FSDialUI(properties);
        ui.render();
        return ui;
    },

    showAttr: function(properties){
        $("#widget_title").val(properties.title);
        //$("#widget_width").val(properties.width);
        //$("#widget_height").val(properties.height);
        $("#min_value").val(properties.min);
        $("#max_value").val(properties.max);
        $("#value_unit").val(properties.unit);

        $("#layer1_from").val(properties.layer1.minvalue);
        $("#layer1_to").val(properties.layer1.maxvalue);
        $("#layer1_color").val('#'+properties.layer1.code);

        $("#layer2_from").val(properties.layer2.minvalue);
        $("#layer2_to").val(properties.layer2.maxvalue);
        $("#layer2_color").val('#'+properties.layer2.code);

        $("#layer3_from").val(properties.layer3.minvalue);
        $("#layer3_to").val(properties.layer3.maxvalue);
        $("#layer3_color").val('#'+properties.layer3.code);     
    },

    updateAttr: function(divid){
        var title = $("#widget_title").val();
        //var width = parseInt($("#widget_width").val());
        //var height = parseInt($("#widget_height").val());  
        var max = parseInt($("#max_value").val());
        var min = parseInt($("#min_value").val());
        var unit = $("#value_unit").val();
        var layer1_from = $("#layer1_from").val();
        var layer1_to = $("#layer1_to").val();
        var layer1_color = ($("#layer1_color").val()).substring(1);
        var layer2_from =$("#layer2_from").val();
        var layer2_to = $("#layer2_to").val();
        var layer2_color = ($("#layer2_color").val()).substring(1); 
        var layer3_from = $("#layer3_from").val();
        var layer3_to = $("#layer3_to").val();
        var layer3_color = ($("#layer3_color").val()).substring(1);     

        //标题显示
        $("#"+divid).closest(".view").find(".title").text(title);

        var properties = {
            tid: divid,
            title: title,
            //width: width,
            //height: height,
            max: max,
            min: min,
            unit: unit,
            layer1:{"minvalue":layer1_from,"maxvalue":layer1_to,"code":layer1_color,"alpha": "80"},
            layer2:{"minvalue":layer2_from,"maxvalue":layer2_to,"code":layer2_color,"alpha": "80"},
            layer3:{"minvalue":layer3_from,"maxvalue":layer3_to,"code":layer3_color,"alpha": "80"},
            dataType:'realTime'
        };

        var ui = new FSDialUI(properties);
        ui.render();
        return ui;
    },

    //控件赋值
    setValue: function(divid,chan,val){
	    var reg = /^.*A[0-7].*$/;
	    if(reg.test(chan)){
	    	var fsId = $("#"+divid).children().attr("id");
	    	FusionCharts.items[fsId].feedData( "value="+ val );
	    }
    }    

}

function FSDialUI(prop) {
    this.properties = prop;
       
    var csatGauge = new FusionCharts({
        "type": "angulargauge",
        "renderAt": prop.tid,
        "width": 233,
        "height": 233,
        "dataFormat": "json",
        "dataSource": {
            "chart": {
                "manageresize": "1",
                "origw": "260",
                "origh": "260",
                "bgcolor": "FFFFFF",
                "upperlimit": prop.max,
                "lowerlimit": prop.min,
                "basefontcolor": "000000",
                "majortmnumber": "11",
                "majortmcolor": "000000",
                "majortmheight": "8",
                "minortmnumber": "5",
                "minortmcolor": "000000",
                "minortmheight": "3",
                "tooltipbordercolor": "000000",//鼠标经过显示值的边框颜色
                "tooltipbgcolor": "333333",//鼠标经过显示值的背景色
                "tooltipcolor": "ffffff",//鼠标经过显示值的字体颜色
                "tooltipborderradius": "3",//鼠标经过显示值的圆角值
                "gaugeouterradius": "100",
                "gaugestartangle": "225",
                "gaugeendangle": "-45",
                "placevaluesinside": "1",
                "gaugeinnerradius": "80%",
                "annrenderdelay": "0",
                "gaugefillmix": "",
                "pivotradius": "10",
                "showpivotborder": "0",
                "pivotfillmix": "{CCCCCC},{666666}",
                "pivotfillratio": "50,50",
                "showshadow": "0",
                "gaugeoriginx": "128",
                "gaugeoriginy": "120",
                "showborder": "0",
                "showValue": "1",
                "valueBelowPivot": "1"
            },
            "colorrange": {
                "color": [prop.layer1,prop.layer2,prop.layer3]
            },
            "dials": {
                "dial": [
                    {
                        "value": "0",
                        "bordercolor": "FFFFFF",
                        "bgcolor": "666666,CCCCCC,666666",
                        "borderalpha": "0",
                        "basewidth": "10"
                    }
                ]
            },
            "annotations": {
                "groups": [
                    {
                        "x": "128",
                        "y": "120",
                        "showbelow": "10",
                        "items": [
                            {
                                "type": "circle",
                                "x": "0",
                                "y": "0",
                                "radius": "111",
                                "color": "dddddd"
                            },
                            {
                                "type": "circle",
                                "x": "0",
                                "y": "0",
                                "radius": "110",
                                "color": "ffffff"//"color": "666666"
                            }
                        ]
                    },
                    {
                        "x": "160",
                        "y": "160",
                        "showbelow": "0",
                        "scaletext": "1",
                        "items": [
                            {
                                "type": "text",
                                "y": "35",
                                "x": "-30",
                                "label": prop.title+'('+prop.unit+')',
                                "fontcolor": "000000",
                                "fontsize": "16",
                                "bold": "1"
                            }
                        ]
                    }
                ]
            },
            "value": "28"
        }
    });

  var charData = csatGauge.getChartData("json");
  this.render = function(){
      csatGauge.render();
  };
}
