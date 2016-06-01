var cam_video = {

  html : ' <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>'+
                '<span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span>'+
                 '<div class="preview">视频监控类</div>' +
                 '<div class="view">' +
			             	'<div class="panel-sensor">' +
			         		'<h3 class="title">摄像头名称</h3>' +
			         		'<div class="body camera">' +
			         			'<div class="camera-btn"  id="cam_video">' +
			         				'<div class="top-left">' +
			         					'<a class="btn_camera power-off" ctr_cmd="SWITCH"></a>' +
			         				'</div>' +
			         				'<div class="right">' +
			         					'<a class="btn_camera" ctr_cmd="UP"></a>' +
			         					'<a class="btn_camera" ctr_cmd="LEFT"></a>' +
			         					'<aclass="btn_camera" ctr_cmd="RIGHT"></a>' +
			         					'<a class="btn_camera" ctr_cmd="DOWN"></a>' +
			         				'</div>' +
			         				'<div class="bottom">' +
			         					'<a class="btn_camera" ctr_cmd="HPATROL"></a>' +
			         					'<a class="btn_camera" ctr_cmd="360PATROL"></a>' +
			         					'<a class="btn_camera" ctr_cmd="VPATROL"></a>' +
			         				'</div>' +
			         			'</div>' +
			         			'<img class="camera-img" id = "img_cam_video" src="'+layoutitPath+'images/camera-bg.jpg" alt="" />' +
			         		'</div>' +
			         	'</div>' +
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
        tid: "cam_video",
        title:"摄像头名称",
        width: 300,
        height: 300,
        theme_type: 'green',//'line', 'column', 'spline', 'area', 'areaspline'
        dataType:'video'
    };
    
    //将create()输入的属性参数绘制控件UI
	if(arguments.length >0){
		$.extend(properties,arguments[0]);
	}
	else{
	    var e = $(".demo #cam_video");
	    var t = randomNumber();
	    var n = "cam_video_" + t;
	    e.attr("id", n);
	    $.extend(properties,{"tid":n});
	}
	
    var ui = new CamVideoUI(properties);
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
          dataType:'video'
      };

      var ui = new CamVideoUI(properties);
      return ui;
  },

  //摄像头控制操作
  sendCmd:function(divid,cameraObj,cmd){
	  console.log(cmd);
      if(cmd == "OPEN"){//打开摄像头
          var btnObj = $("#"+divid).find('*[ctr_cmd="OPEN"]');
    	  cameraObj.checkOnline(function(state){//先检查摄像头是否在线，在线状态才能打开摄像头
    		  if(state){
            	  cameraObj.openVideo();
                  console.log("摄像头：开");

                  $("#"+divid).children(".top-left").find("a").removeClass("power-on").addClass("power-off");
                  btnObj.attr("ctr_cmd","CLOSE");
    		  }
    	  });
      }
      else if(cmd == "CLOSE"){//关闭摄像头
    	  var btnObj = $("#"+divid).find('*[ctr_cmd="CLOSE"]');
          cameraObj.closeVideo();
          console.log("摄像头：关");

          $("#"+divid).children(".top-left").find("a").removeClass("power-off").addClass("power-on"); 
          btnObj.attr("ctr_cmd","OPEN");
      }
      else{//其它控制指令
          cameraObj.control(cmd);
      }
  }
}

function CamVideoUI(prop) {
    this.properties = prop;
    var  html = '<div class="top-left">' +
					'<a class="btn_camera power-off" ctr_cmd="OPEN"></a>' +
				'</div>' +
				'<div class="right">' +
					'<a class="btn_camera" ctr_cmd="UP"></a>' +
					'<a class="btn_camera" ctr_cmd="LEFT"></a>' +
					'<a class="btn_camera" ctr_cmd="RIGHT"></a>' +
					'<a class="btn_camera" ctr_cmd="DOWN"></a>' +
				'</div>' +
				'<div class="bottom">' +
					'<a class="btn_camera" ctr_cmd="HPATROL"></a>' +
					'<a class="btn_camera" ctr_cmd="360PATROL"></a>' +
					'<a class="btn_camera" ctr_cmd="VPATROL"></a>' +
				'</div>';
    $("#"+prop.tid).html(html);
    $("#"+prop.tid).parent().find("img").attr("id","img_"+prop.tid);
    $("#"+prop.tid).parent().parent().find("h3").text(prop.title);//更新标题
}
