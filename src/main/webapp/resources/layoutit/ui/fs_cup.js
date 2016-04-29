var fs_cup = {

  html : ' <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>'+
                '<span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span>'+
                 '<div class="preview">量杯</div>' +
                 '<div class="view">' +
                   '<div id="fs_cup">'+
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

  create: function(){
    var e = $(".demo #fs_cup");
    var t = randomNumber();
    var n = "fs_cup_" + t;
    e.attr("id", n);
    var properties = {
        tid: n,
        title: "湿度",
        width: 140,
        height: 200,
        max: 100,
        min: 0,
        unit: "%",
        bgcolor: "#f2f5f7",
        gaugeFillColor: "#5aff00"
    };
    var ui = new FSCupUI(properties);
    console.log("ui:"+ui);
    ui.render();
    return ui;
  },

  getUI: function(properties){
      var ui = new FSCupUI(properties);
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
              
      var properties = {
          tid: divid,
          title: title,
          width: width,
          height: height,
          max: max,
          min: min,
          unit: unit,
          bgcolor: bgcolor,
          gaugeFillColor: gaugeFillColor
      };
      var ui = new FSCupUI(properties);
      ui.render();
      return ui;
  },
  //控件赋值
  setValue: function(divid,val){
    FusionCharts.items["id_"+divid].feedData( "value="+ val );
  } 
}

function FSCupUI(prop) {

  this.properties = prop;

  this.Property = {
     WIDTH : "width",
     HEIGHT : "height"
  };

  var csatGauge = new FusionCharts({
      "id": "id_"+prop.tid,
      "type": "cylinder",
      "renderAt": prop.tid,
      "width": prop.width,
      "height": prop.height,
      "dataFormat": "json",
      "dataSource": {
          "chart": {
              "manageresize": "1",
              "upperlimit": prop.max,
              "lowerlimit": prop.min,
              "tickmarkgap": "5",
              "numbersuffix": prop.unit,
              "refreshinterval": "3",
              "showborder": "0",
              "bgcolor": prop.bgcolor,
              "showhovereffect": "1",
              "cylfillcolor": prop.gaugeFillColor
          },
          "value": "0"
      }
    });
  
  var charData = csatGauge.getChartData("json");
  this.render = function(){
      csatGauge.render();
  };

  this.setUpperLimit = function(value){
      charData.chart.upperlimit = value;
      csatGauge.setChartData(charData);
  };

  this.setProperty = function(name,value){
      charData.chart[name] = value;
      csatGauge.setChartData(charData);
  };

  this.getProperty = function(name,value){
      console.log(charData.chart[name]);
      return charData.chart[name];
  };

  this.setValue = function(value){
      console.log("charData:"+charData);
      charData.value = value;
      csatGauge.setChartData(charData);
  }
};
