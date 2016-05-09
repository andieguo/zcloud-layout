var hc_curve = {

	html : ' <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>'+
                '<span class="configuration"><button type="button" class="btn btn-mini" data-target="#attrEditorModal" role="button" data-toggle="modal">编辑</button></span>'+
                 '<div class="preview">曲线-hc</div>' +
                 '<div class="view">' +
                   '<div id="hc_curve">'+
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
                        '<span class="add-on">线形</span>' +
                        '<select class="w100p widgetAttrChange" id="curve_type">' +
                            '<option value="spline" selected="selected">spline</option>' +
                            '<option value="line">line</option>' +
                            '<option value="column">column</option>' +
                            '<option value="area">area</option>' +
                            '<option value="areaspline">areaspline</option>' +
                        '</select>' +
                      '</div>' +
                      '<div class="input-prepend mr10p">' +
                        '<span class="add-on">单位</span>' +
                        '<input class="w50p widgetAttrChange" id="value_unit" type="text">' +
                      '</div>' +        
                ' </div>',

    create: function() {//默认情况下无参数，可接收控件属性参数对象create(properties)
        var properties = {
            tid: "hc_curve",
            title:"温度历史数据",
            width: 600,
            height: 200,
            ctype: 'spline',//'line', 'column', 'spline', 'area', 'areaspline'
            unit: "℃",
            data: [[1398368037823,2],[1398470377015,6],[1398556786135,1],[1398643177964,9],[1398710239656,10],[1398784852700,7]],
            dataType:'realTime|history'
        };
        
        //将create()输入的属性参数绘制控件UI
    	if(arguments.length >0){
    		$.extend(properties,arguments[0]);
    		//此条语句至关重要，否则控件UI会加载失败
    		$("#"+properties.tid).removeAttr("data-highcharts-chart");
    	}
    	else{
            var e = $(".demo #hc_curve");
            var t = randomNumber();
            var n = "hc_curve_" + t;
            e.attr("id", n);
            $.extend(properties,{"tid":n});
    	}

        var ui = new HCCurveUI(properties);
        return ui;
    },

    showAttr: function(properties){
        $("#widget_title").val(properties.title);
        $("#widget_width").val(properties.width);
        $("#widget_height").val(properties.height);
        $("#curve_type").val(properties.ctype);
        $("#value_unit").val(properties.unit);    
    },
    updateAttr: function(divid){
        var title = $("#widget_title").val();
        var width = parseInt($("#widget_width").val());
        var height = parseInt($("#widget_height").val());
        var ctype = $("#curve_type").val();
        var unit = $("#value_unit").val(); 
        var data = [[1398368037823,2],[1398470377015,6],[1398556786135,1],[1398643177964,9],[1398710239656,10],[1398784852700,7]];     
        var properties = {
            tid: divid,
            title: title,
            width: width,
            height: height,
            ctype: ctype,
            unit: unit,
            data: data,
            dataType:'realTime|history'
        };
        var ui = new HCCurveUI(properties);
        return ui;
    },
    
    //曲线控件赋值
    setData: function(divid,data){//data数据格式为json格式数据
        var chart = $("#"+divid).highcharts();
        var dat = eval(DataAnalysis(data));//格式转换
        chart.series[0].setData(dat);
    },
    
    //动态增加数据点
    setValue:function(divid,chan,val){
        var reg = /^.*A[0-7].*$/;
        if(reg.test(chan)){
            var chart = $("#"+divid).highcharts();
            var series = chart.series[0];
            var point = {   //获取新的点，并返回给动态图表
                x: (new Date()).getTime() + 28800000,
                y: parseFloat(val)
            };
            series.addPoint([point.x, point.y], true, true);
        }
    } 
}

function HCCurveUI(prop) {

  this.properties = prop;

  var dial = new Highcharts.Chart({
        chart: {
            renderTo: $('#'+prop.tid)[0],
            type: prop.ctype,
            animation: false,
            zoomType: 'x',
            width: prop.width,
            height: prop.height,
        },
        legend: {
            enabled: false
        },
        title: {
            text: ''
        },
        xAxis: {
            type: 'datetime'
        },
        yAxis: {
            title: {
                text: ''
            },

            minorGridLineWidth: 0,
            gridLineWidth: 1,
            alternateGridColor: null
        },
        tooltip: {
            formatter: function () {
                return '' +
                    Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br><b>' + this.y + prop.unit + '</b>';
            }
        },
        plotOptions: {
            spline: {
                lineWidth: 2,
                states: {
                    hover: {
                        lineWidth: 3
                    }
                },
                marker: {
                    enabled: false,
                    states: {
                        hover: {
                            enabled: true,
                            symbol: 'circle',
                            radius: 3,
                            lineWidth: 1
                        }
                    }
                }

            },
            line: {
                lineWidth: 1,
                states: {
                    hover: {
                        lineWidth: 1
                    }
                },
                marker: {
                    enabled: false,
                    states: {
                        hover: {
                            enabled: true,
                            symbol: 'circle',
                            radius: 3,
                            lineWidth: 1
                        }
                    }
                }

            }
        },
        series: [{
            marker: {
                symbol: 'square'
            },
            data: prop.data,
            step: false

        }]
        ,
        navigation: {
            menuItemStyle: {
                fontSize: '10px'
            }
        }
  });

};

//将JSON格式的数据转换成[x1,y1],[x2,y2],[x3,y3]...格式的数组
function DataAnalysis(data,timezone)
{
    var str='';
    var temp;
    var len=data.datapoints.length;
    if(timezone == null)
    {
        timezone = "+8";
    }
    var zoneOp = timezone.substring(0,1);
    var zoneVal = timezone.substring(1);
    //var tzSecond = zoneVal*3600000; 修改于2015年2月1日 连接自己的数据服务器没用到时区参数
    var tzSecond = 0;
    $.each(data.datapoints,function(i,ele){
        if(zoneOp =='+')
        {
            temp = Date.parse(ele.at)+tzSecond;
        }
        if(zoneOp =='-')
        {
            temp = Date.parse(ele.at)-tzSecond;
        }
        if(ele.value.indexOf("http") != -1)
        {
            str=str+'['+temp+',"'+ele.value+'"]';
        }else{
            str=str+'['+temp+','+ele.value+']';
        }
        if(i!=len-1)
            str=str+',';
    });
    return "["+ str+"]";
}
