var ctr_switch = {

  html : ' <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>'+
                '<span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span>'+
                 '<div class="preview">开关类</div>' +
                 '<div class="view">' +
                    '<div class="panel-sensor panel-switch">'+
                        '<h3 class="title">开关名称</h3>'+
                        '<div class="body">'+
	                        '<div id="ctr_switch">'+
	                            '<img class="switch_button" src="'+layoutitPath+'images/off.png"/>'+
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
        tid: "ctr_switch",
        title:"开关名称",
        //width: 300,
        //height: 300,
        theme_type: 'green',//'line', 'column', 'spline', 'area', 'areaspline'
        dataType:'realTime'
    };
    
    //将create()输入的属性参数绘制控件UI
	if(arguments.length >0){
		$.extend(properties,arguments[0]);
	}
	else{
	    var e = $(".demo #ctr_switch");
	    var t = randomNumber();
	    var n = "ctr_switch_" + t;
	    e.attr("id", n);
	    $.extend(properties,{"tid":n});
	}
	
    var ui = new CtrSwitchUI(properties);
    return ui;
  },

  showAttr: function(properties){
      $("#widget_title").val(properties.title);
      //$("#widget_width").val(properties.width);
      //$("#widget_height").val(properties.height);
      $("#theme_type").val(properties.theme_type);  
  },

  updateAttr: function(divid){
      var title = $("#widget_title").val();
      //var width = parseInt($("#widget_width").val());
      //var height = parseInt($("#widget_height").val());
      var theme_type = $("#theme_type").val();

      var properties = {
          tid: divid,
          title: title,
          //width: width,
          //height: height,
          theme_type: theme_type,
          dataType:'realTime'
      };
      
      var ui = new CtrSwitchUI(properties);
      return ui;
  },
  //设置开关状态
  setValue:function(divid,chan,val){
    var reg = /^.*D[1-3].*$/;
    if(reg.test(chan)){
      if(val){
        console.log("开关ID:"+divid);
          $("#"+divid).find(".switch_button").attr("src",layoutitPath+"images/on.png");
      }
      else{
          $("#"+divid).find(".switch_button").attr("src",layoutitPath+"images/off.png");
      }
    }
  },

  sendCmd:function(clickObj,rtcObj,dataObj){
    var src = clickObj.attr("src");
    //console.log(src);

    if(src.indexOf("off") >=0 ){
      //发送开指令
      console.log(dataObj.mac+" -> "+dataObj.command.open);
      rtcObj.sendMessage(dataObj.mac, dataObj.command.open);
    }
    else{
      //发送关指令
      console.log(dataObj.mac+" -> "+dataObj.command.close);
      rtcObj.sendMessage(dataObj.mac, dataObj.command.close);
    }
  }
}

function CtrSwitchUI(prop)
{
	this.properties = prop;
	var html = '<img class="switch_button" src="'+layoutitPath+'images/off.png"/>';
	$("#"+prop.tid).html(html);
	$("#"+prop.tid).parent().parent().find("h3").text(prop.title);//更新标题
}