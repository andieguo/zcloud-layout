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
                          '<img src="img/alarm-on.png" alt="">' +
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

  create: function(){
    var e = $(".demo #sec_alarm");
    var t = randomNumber();
    var n = "sec_alarm_" + t;
    var r;
    e.attr("id", n);

    var properties = {
        tid: n,
        title:"安防设备名称",
        width: 300,
        height: 300,
        theme_type: 'green',//'line', 'column', 'spline', 'area', 'areaspline'
    };

    return {properties:properties};
  },

  getUI: function(properties){
      var ui = new FSCupUI(properties);
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

      $("#"+divid).children("h3").text(title);
      var properties = {
          tid: divid,
          title: title,
          width: width,
          height: height,
          theme_type: theme_type,
      };
      return {properties:properties};
  },

  setValue:function(divid,val){
    if(val == -1){//撤防
      $("#"+divid).find("img").attr("src","img/alarm-off.png");
      $("#"+divid).find("#alarm_text").text("已撤防");
      $("#"+divid).find("#alarm_text").css("color","black");
    }
    if(val == 0){//正常状态
      $("#"+divid).find("img").attr("src","img/alarm-off.png");
      $("#"+divid).find("#alarm_text").text("正在检测...");
      $("#"+divid).find("#alarm_text").css("color","black");
    }
    if(val == 1){//报警状态
      $("#"+divid).find("img").attr("src","img/alarm-activ.gif");
      $("#"+divid).find("#alarm_text").text("检测到危险气体！");
      $("#"+divid).find("#alarm_text").css("color","red");
    }
  },

  sendCtrCmd:function(divid,object){
    var src = $("#"+divid).find(".switch_button");
    console.log(src);
/*    if(src.indexOf("off") >=0 ){
      //发送控制指令
      ctr_switch.switchStat(divid,1);
    }
    else{
      //发送控制指令
      ctr_switch.switchStat(divid,0);
    }*/
  }
}