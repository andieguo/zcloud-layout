var sec_alarm = {

  html :  ' <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>'+
                '<span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span>'+
                 '<div class="preview">安防类</div>' +
                 '<div class="view">' +
                    '<div class="panel-sensor alarm" id="sec_alarm">'+
                        '<h3 class="title">安防设备名称</h3>'+
                        '<div class="body">'+
                          '<div class="button">' +
                            '<button class="btn btn-success" type="button">布防<tton>' +
                            '<button class="btn btn-danger" type="button">撤防<tton>' +
                          '</div>' +
                          '<img src="'+layoutitPath+'images/alarm-on.png" alt="">' +
                          '<div class="value" id="alarm_text">正在检测中...</div>' +
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

  create: function(){//默认情况下无参数，可接收控件属性参数对象create(properties)
    var properties = {
        tid: "sec_alarm",
        title:"安防设备名称",
        width: 300,
        height: 300,
        theme_type: 'green',//'line', 'column', 'spline', 'area', 'areaspline',
        dataType:'realTime'
    };

    //将create()输入的属性参数绘制控件UI
	if(arguments.length >0){
		$.extend(properties,arguments[0]);
	}
	else{
	    var e = $(".demo #sec_alarm");
	    var t = randomNumber();
	    var n = "sec_alarm_" + t;
	    e.attr("id", n);
	    $.extend(properties,{"tid":n});
	}
    
    var ui = new SecAlarmUI(properties);
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
          dataType:'realTime'
      };
      
      var ui = new SecAlarmUI(properties);
      return ui;
  },

  //设置报警器的状态、布防撤防的状态
  setValue:function(divid,chan,val){
    //模拟量0/1
    var reg1 = /^.*A[0-7].*$/;
    if(reg1.test(chan)){
        if(val == 0){//正常状态
          $("#"+divid).find("img").attr("src",layoutitPath+"images/alarm-on.png");
          $("#"+divid).find("#alarm_text").text("已布防，正在检测...");
          $("#"+divid).find("#alarm_text").css("color","blue");
        }
        if(val == 1){//报警状态
          $("#"+divid).find("img").attr("src",layoutitPath+"images/alarm-activ.gif");
          $("#"+divid).find("#alarm_text").text("检测到异常！");
          $("#"+divid).find("#alarm_text").css("color","red");
        }
    }
    
    //开关量
    var reg2 = /^.*D[0-3].*$/;
    if(reg2.test(chan)){
        if(val == 0){//已撤防
          $("#"+divid).find("img").attr("src",layoutitPath+"images/alarm-off.png");
          $("#"+divid).find("#alarm_text").text("已撤防");
          $("#"+divid).find("#alarm_text").css("color","black");
        }
        if(val == 1){//布防
          $("#"+divid).find("#alarm_text").text("已布防，正在检测...");
          $("#"+divid).find("#alarm_text").css("color","blue");
        }        
    }

  },

  sendCmd:function(clickObj,rtcObj,dataObj){
    var text = clickObj.text();
    console.log(text);
    if(text == "布防"){
      //发送布防指令
      console.log(dataObj.mac+" -> "+dataObj.command.open);
      rtcObj.sendMessage(dataObj.mac, dataObj.command.open);
    }
    else{
      //发送撤防指令
      console.log(dataObj.mac+" -> "+dataObj.command.close);
      rtcObj.sendMessage(dataObj.mac, dataObj.command.close);
    }
  }
}

function SecAlarmUI(prop)
{
	this.properties = prop;
	var html = '<h3 class="title">'+prop.title+'</h3>'+
		    '<div class="body">'+
			    '<div class="button">' +
			      '<button class="sec_button btn btn-success" type="button">布防<tton>' +
			      '<button class="sec_button btn btn-danger" type="button">撤防<tton>' +
			    '</div>' +
			    '<img src="'+layoutitPath+'images/alarm-on.png" alt="">' +
			    '<div class="value" id="alarm_text">正在检测中...</div>' +
		    '</div>';
	$("#"+prop.tid).html(html);
}