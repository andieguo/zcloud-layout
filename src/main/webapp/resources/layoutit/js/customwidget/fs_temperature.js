var fs_temperature = {

	html : '<div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>'+
			 '<span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span>'+
			 '<div class="preview">温度计</div>' +
			 '<div class="view">' +
	             '<div class="panel-sensor">'+
				   '<h3 class="title">温度</h3>'+
				   '<div class="body">'+
					   '<div id="fs_temperature">'+
					   '</div>'+
				   '</div>'+
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
                    '<input class="w50p widgetAttrChange" id ="widget_width" type="text">' +
                  '</div>' +
                  '<div class="input-prepend mr10p">' +
                    '<span class="add-on">控件高度</span>' +
                    '<input class="w50p widgetAttrChange" id ="widget_height" type="text">' +
                  '</div>' +   
                  '<div class="input-prepend mr10p">' +
                    '<span class="add-on">最小值</span>' +
                    '<input class="w50p widgetAttrChange" id ="min_value" type="text">' +
                  '</div>' +  
                  '<div class="input-prepend mr10p">' +
                    '<span class="add-on">最大值</span>' +
                    '<input class="w50p widgetAttrChange" id ="max_value" type="text">' +
                  '</div>' + 
                  '<div class="input-prepend mr10p">' +
                    '<span class="add-on">单位</span>' +
                    '<input class="w50p widgetAttrChange" id ="value_unit" type="text">' +
                  '</div>' +                                                                    
                  '<div class="input-prepend mr10p">' +
                    '<span class="add-on">背景颜色</span>' +
                    '<input class="w100p widgetAttrChange" id="bg_color" type="text">' +
                  '</div>' +
                  '<div class="input-prepend mr10p">' +
                    '<span class="add-on">填充颜色</span>' +
                    '<input class="w100p widgetAttrChange" id="fill_color" type="text">' +
                  '</div>' +
                ' </div>',

  create: function(){//默认情况下无参数，可接收控件属性参数对象create(properties)
    var properties = {
        tid: "fs_temperature",
        title: "温度",
        width: 240,
        height: 200,
        max: 100,
        min: 0,
        unit: "℃",
        bgcolor: "#f3f5f7",
        gaugeFillColor: "#ffc420",
        dataType:'realTime'
    };
    
    //将create()输入的属性参数绘制控件UI
	if(arguments.length >0){
		$.extend(properties,arguments[0]);
	}
	else{
	  	var e = $(".demo #fs_temperature");
		var t = randomNumber();
		var n = "fs_temperature_" + t;
		e.attr("id", n);
		$.extend(properties,{"tid":n});
	}
	
    var ui = new TemperatureUI(properties);
    ui.render();
    return ui;
  },

  showAttr: function(properties){
      $("#widget_title").val(properties.title);
      $("#widget_width").val(properties.width);
      $("#widget_height").val(properties.height);
      $("#min_value").val(properties.min);
      $("#max_value").val(properties.max);
      $("#value_unit").val(properties.unit);

      $("#bg_color").val(properties.bgcolor);
      $("#fill_color").val(properties.gaugeFillColor);   
  },
  
  updateAttr: function(divid){
      var title = $("#widget_title").val();
      var width = parseInt($("#widget_width").val());
      var height = parseInt($("#widget_height").val());
      var max = parseInt($("#max_value").val());
      var min = parseInt($("#min_value").val());
      var unit = $("#value_unit").val();
      var bgcolor = $("#bg_color").val();
      var gaugeFillColor = $("#fill_color").val();
      
      //标题显示
      $("#"+divid).parents(".view").find(".title").text(title);  
      
      var properties = {
          tid: divid,
          title: title,
          width: width,
          height: height,
          max: max,
          min: min,
          unit: unit,
          bgcolor: bgcolor,
          gaugeFillColor: gaugeFillColor,
          dataType:'realTime'
      };
      var ui = new TemperatureUI(properties);
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

function TemperatureUI(prop) {

  this.properties = prop;

  this.Property = {
     WIDTH : "width",
     HEIGHT : "height"
  };

  var csatGauge = new FusionCharts({
    "type": "thermometer",
    "renderAt": prop.tid,
    "width": prop.width,
    "height": prop.height,
    "dataFormat": "json",
    "dataSource": {
        "chart": {
            "upperLimit": prop.max,
            "lowerLimit": prop.min,
            "numberSuffix": prop.unit,
            "decimals": "1",
            "showhovereffect": "1",
            "gaugeFillColor": prop.gaugeFillColor,
            "gaugeBorderColor": "#008ee4",
            "showborder": "0",
            "bgcolor": prop.bgcolor,
            "tickmarkgap": "5",
            "theme": "fint"
        },
        "value": "28"
    }
  });
  this.render = function(){
      csatGauge.render();
  };
};
