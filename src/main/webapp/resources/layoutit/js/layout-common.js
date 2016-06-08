/*定义全局变量 key:object*/
var gUiObject = {
	"fs_temperature": fs_temperature,
	"hc_dial": hc_dial,
	"fs_dial": fs_dial,
	"fs_cup": fs_cup,
	"hc_curve": hc_curve,
	"layout_subsys": layout_subsys,
	"ctr_switch": ctr_switch,
	"sec_alarm": sec_alarm,
	"cam_video": cam_video,
	"page_header": page_header,
	"page_footer": page_footer
};
/*恢复控件的UI内容*/
function resumeWidgetUI(temObj){
	for(var i in temObj){
		if(i.indexOf("layout") < 0 ){//若是布局控件则忽略此次操作
			var widgetJSFileName = i.substring(0,placeOfChar(i,2,'_'));	
			gUiObject[widgetJSFileName].create(temObj[i]);			
		}
	}	
}

/*压缩html*/
function htmlCompress(html){
	return html.replace(/\s+|\n/g, " ").replace(/>\s</g,"><");
};

function initTemplateUI(layoutJSON,content){
	   //保存控件UI属性配置数据
	   if(layoutJSON != ''){//判断数据是否为空
		   uiTemplateObj = JSON.parse(layoutJSON);
		   //渲染控件布局的div
		   if(content != ''){
			   $(".demo").html(content);
			   //渲染控件的UI
			   resumeWidgetUI(uiTemplateObj);
		   }
	   }
}
  
function initProjectUI(layoutJSON,content,imageURL,name,titleContent,footContent){
   //保存控件UI属性配置数据
   if(layoutJSON != ''){//判断数据是否为空
	   uiTemplateObj = JSON.parse(layoutJSON);
	   //渲染控件布局的div
	   if(content != ''){
		   var headerHTML = '<header class="clearfix">' +
								'<div style="width:1170px;margin: 0 auto;">' +
				   					'<img src="'+imageURL+'" alt="logo">' +
				   					'<hgroup>' +
					   					'<h1>'+name+'</h1>' +
					   					'<h2>'+titleContent+'</h2>' +
				   					'</hgroup>' +
			   					'</div>' +
		   					'</header>';
		   var footHTML = '<footer><p>'+footContent+'</p></footer>';
		   $(".demo").html(content);
		   //$(".demo").html(headerHTML+content+footHTML);
		   $(headerHTML).insertBefore('.container');
		   $(footHTML).insertAfter('.container');
		   //渲染控件的UI
		   resumeWidgetUI(uiTemplateObj);
	   }
   }
}

function placeOfChar(str, n, char) {
    var index = str.indexOf(char);
    var i = 0;
    while (index != -1) {
        i++;
        if (i == n)
            break;
        index = str.indexOf(char, index + 1);
    }
    return index;
}

function supportstorage() {
	if (typeof window.localStorage=='object') 
		return true;
	else
		return false;		
}

function randomNumber() {
	return randomFromInterval(1, 1e6);
}
function randomFromInterval(e, t) {
	return Math.floor(Math.random() * (t - e + 1) + e);
}
function randomNumber1(){
	return (new Date()).getTime()+parseInt(Math.random()*100000);
}