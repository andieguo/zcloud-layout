<!--定义全局变量 key:object--> 
var currentDocument = null;
var stopsave = 0;
var startdrag = 0;
var demoHtml = $(".demo").html();
var currenteditor = null;

function downloadLayout(){
	$.ajax({  
		type: "POST",  
		url: "/build/downloadLayout",  
		data: { layout: $('#download-layout').html() },  
		success: function(data) { window.location.href = '/build/download'; }
	});
}

function downloadHtmlLayout(){
	$.ajax({  
		type: "POST",  
		url: "/build/downloadLayout",  
		data: { layout: $('#download-layout').html() },  
		success: function(data) { window.location.href = '/build/downloadHtml'; }
	});
}

function handleJsIds() {
	handleModalIds();
	handleAccordionIds();
	handleCarouselIds();
	handleTabsIds();
}

function handleAccordionIds() {
	var e = $(".demo #myAccordion");
	var t = randomNumber();
	var n = "accordion-" + t;
	var r;
	e.attr("id", n);
	e.find(".accordion-group").each(function(e, t) {
		r = "accordion-element-" + randomNumber();
		$(t).find(".accordion-toggle").each(function(e, t) {
			$(t).attr("data-parent", "#" + n);
			$(t).attr("href", "#" + r)
		});
		$(t).find(".accordion-body").each(function(e, t) {
			$(t).attr("id", r)
		})
	})
}
function handleCarouselIds() {
	var e = $(".demo #myCarousel");
	var t = randomNumber();
	var n = "carousel-" + t;
	e.attr("id", n);
	e.find(".carousel-indicators li").each(function(e, t) {
		$(t).attr("data-target", "#" + n)
	});
	e.find(".left").attr("href", "#" + n);
	e.find(".right").attr("href", "#" + n)
}
function handleModalIds() {
	var e = $(".demo #myModalLink");
	var t = randomNumber();
	var n = "modal-container-" + t;
	var r = "modal-" + t;
	e.attr("id", r);
	e.attr("href", "#" + n);
	e.next().attr("id", n)
}
function handleTabsIds() {
	var e = $(".demo #myTabs");
	var t = randomNumber();
	var n = "tabs-" + t;
	e.attr("id", n);
	e.find(".tab-pane").each(function(e, t) {
		var n = $(t).attr("id");
		var r = "panel-" + randomNumber();
		$(t).attr("id", r);
		$(t).parent().parent().find("a[href=#" + n + "]").attr("href", "#" + r)
	})
}

function gridSystemGenerator() {
	$(".lyrow .preview input").bind("keyup", function() {
		var e = 0;
		var t = "";
		var n = $(this).val().split(" ", 12);
		$.each(n, function(n, r) {
			e = e + parseInt(r);
			t += '<div class="span' + r + ' column"></div>'
		});
		if (e == 12) {
			$(this).parent().next().children().html(t);
			$(this).parent().prev().show()
		} else {
			$(this).parent().prev().hide()
		}
	})
}
function configurationElm(e, t) {
	$(".demo").delegate(".configuration > a", "click", function(e) {
		e.preventDefault();
		var t = $(this).parent().next().next().children();
		$(this).toggleClass("active");
		t.toggleClass($(this).attr("rel"))
	});
	$(".demo").delegate(".configuration .dropdown-menu a", "click", function(e) {
		e.preventDefault();
		var t = $(this).parent().parent();
		var n = t.parent().parent().next().next().children();
		t.find("li").removeClass("active");
		$(this).parent().addClass("active");
		var r = ""; 	
		t.find("a").each(function() {
			r += $(this).attr("rel") + " "
		});
		t.parent().removeClass("open");
		n.removeClass(r);
		n.addClass($(this).attr("rel"))
	})
}
function removeElm() {
	$(".demo").delegate(".remove", "click", function(e) {
		var uid = $(this).parent().find('.view').children().attr("id");
		if(typeof(uid)!='undefined'){
			if(uid.indexOf("ui") >= 0 || uid.indexOf("fs") >= 0 || uid.indexOf("hc") >= 0
					|| uid.indexOf("ctr") >= 0 || uid.indexOf("sec") >= 0|| uid.indexOf("cam") >= 0
					|| uid.indexOf("page") >= 0 || uid.indexOf("layout") >= 0){//控件中的<div id>属性是否存在 
				delete uiTemplateObj[uid];
			}
		}
		e.preventDefault();
		$(this).parent().remove();
		if (!$(".demo .lyrow").length > 0) {
			clearDemo()
		}
	})
}
function clearDemo() {
	$(".demo").empty();
	initTemplateObj();		
}
function removeMenuClasses() {
	$("#menu-layoutit li button").removeClass("active")
}
function changeStructure(e, t) {
	$("#download-layout ." + e).removeClass(e).addClass(t)
}
function cleanHtml(e) {
	$(e).parent().append($(e).children().html())
}
function downloadLayoutSrc() {
	var e = "";
	$("#download-layout").children().html($(".demo").html());
	var t = $("#download-layout").children();
	t.find(".preview, .configuration, .drag, .remove").remove();
	t.find(".lyrow").addClass("removeClean");
	t.find(".box-element").addClass("removeClean");
	t.find(".lyrow .lyrow .lyrow .lyrow .lyrow .removeClean").each(function() {
		cleanHtml(this)
	});
	t.find(".lyrow .lyrow .lyrow .lyrow .removeClean").each(function() {
		cleanHtml(this)
	});
	t.find(".lyrow .lyrow .lyrow .removeClean").each(function() {
		cleanHtml(this)
	});
	t.find(".lyrow .lyrow .removeClean").each(function() {
		cleanHtml(this)
	});
	t.find(".lyrow .removeClean").each(function() {
		cleanHtml(this)
	});
	t.find(".removeClean").each(function() {
		cleanHtml(this)
	});
	t.find(".removeClean").remove();
	$("#download-layout .column").removeClass("ui-sortable");
	$("#download-layout .row-fluid").removeClass("clearfix").children().removeClass("column");
	if ($("#download-layout .container").length > 0) {
		changeStructure("row-fluid", "row")
	}
	formatSrc = $.htmlClean($("#download-layout").html(), {
		format: true,
		allowedAttributes: [
			["id"],
			["class"],
			["data-toggle"],
			["data-target"],
			["data-parent"],
			["role"],
			["data-dismiss"],
			["aria-labelledby"],
			["aria-hidden"],
			["data-slide-to"],
			["data-slide"]
		]
	});
	$("#download-layout").html(formatSrc);
	$("#downloadModal textarea").empty();
	$("#downloadModal textarea").val(formatSrc)
}

$(window).resize(function() {
	$("body").css("min-height", $(window).height() - 90);
	$(".demo").css("min-height", $(window).height() - 160)
});

function initContainer(){
	$(".demo, .demo .column").sortable({
		connectWith: ".column",
		opacity: .35,
		handle: ".drag",
		start: function(e,t) {
			if (!startdrag) stopsave++;
			startdrag = 1;
		},
		stop: function(e,t) {
			if(stopsave>0) stopsave--;
			startdrag = 0;
		}
	});
	configurationElm();
}

$(document).ready(function() {
	var tabContent = "";
	var layoutContent = "";
	for(var p in gUiObject){
		if(p.indexOf("layout") >= 0){//布局类控件
			layoutContent = gUiObject[p].html + layoutContent;
		}
		else{//其它控件
			tabContent = gUiObject[p].html + tabContent;
		}
	}
	$("#estRows").html($("#estRows").html() + layoutContent);//布局类渲染
	$("#elmComponents").html(tabContent + $("#elmComponents").html());//组件类渲染


	CKEDITOR.disableAutoInline = true;

	var contenthandle = CKEDITOR.replace( 'contenteditor' ,{
		language: 'zh-cn',
		contentsCss: [layoutitPath+'css/bootstrap-combined.min.css'],
		allowedContent: true
	});
	$("body").css("min-height", $(window).height() - 90);
	$(".demo").css("min-height", $(window).height() - 130);
	
	$(".sidebar-nav .lyrow").draggable({//布局拖拽处理
		connectToSortable: ".demo",
		helper: "clone",
		handle: ".drag",
		start: function(e,t) {
			if (!startdrag) stopsave++;
			startdrag = 1;
		},
		drag: function(e, t) {
			t.helper.width(400)
		},
		stop: function(e, t) {

			var uid = t.helper.children(".view").children().attr("id");
			if(typeof(uid)!='undefined'){//控件中的<div id>属性是否存在 
				if(uid.indexOf("layout") >= 0){//自定义ui控件
					var ui = gUiObject[uid].create();//根据拖动的控件创建对象
					uiTemplateObj[ui.properties.tid] = ui.properties;//将拖动后创建的控件ID、属性进行缓存
				}
			}

			$(".demo .column").sortable({
				opacity: .35,
				connectWith: ".column",
				start: function(e,t) {
					if (!startdrag) stopsave++;
					startdrag = 1;
				},
				stop: function(e,t) {
					if(stopsave>0) stopsave--;
					startdrag = 0;
				}
			});
			if(stopsave>0) stopsave--;
			startdrag = 0;
		}
	});
	
	$(".sidebar-nav .box").draggable({//组件拖拽处理
		connectToSortable: ".column",
		helper: "clone",
		handle: ".drag",
		start: function(e,t) {
			if (!startdrag) stopsave++;
			startdrag = 1;
		},
		drag: function(e, t) {
			t.helper.width(400)
		},
		stop: function(e, t) {			
			handleJsIds();
			var uid = t.helper.children(".view").children().attr("id");
			if(typeof(uid)!='undefined'){//控件中的<div id>属性是否存在 
				if(uid.indexOf("fs") >= 0 || uid.indexOf("hc") >= 0 
					|| uid.indexOf("ctr") >= 0 || uid.indexOf("sec") >= 0|| uid.indexOf("cam") >= 0
					|| uid.indexOf("page") >= 0){//自定义ui控件
					var ui = gUiObject[uid].create();//根据拖动的控件创建对象
					uiTemplateObj[ui.properties.tid] = ui.properties;//将拖动后创建的控件ID、属性进行缓存
				}
			}
			if(stopsave>0) stopsave--;
			startdrag = 0;
		}
	});
	initContainer();
	
	$('body.edit .demo').on("click","[data-target=#editorModal]",function(e) {
		e.preventDefault();
		currenteditor = $(this).parent().parent().find('.view');
		var eText = currenteditor.html();
		contenthandle.setData(eText);
	});

	//开关类控件按键触发
	$(".switch_button").click(function(){
		var src = $(this).attr("src");
		if(src.indexOf("off") >=0 ){
	      $(this).attr("src","img/on.png");
	    }
	    else{
	      $(this).attr("src","img/off.png");
	    }
	});

	<!--控件属性编辑--> 
	$('body.edit .demo').on("click","[data-target=#attrEditorModal]",function(e) {
		console.log("attrEditorModal");
		console.log($("#attrModal").html());
		var uid = $(this).parent().parent().find('.view').children().attr("id");
		console.log(uid);

		//从缓存中取出控件的属性列表
		//var data = JSON.parse(localStorage.getItem("uiTemplateStorage"));
		//var property = data[templateId][uid];
		var property = uiTemplateObj[uid];

		if(property){
			var widgetIndex = uid.substring(0,uid.lastIndexOf("_"));
			console.log(widgetIndex);

			var configHtml = gUiObject[widgetIndex].configHtml;//编辑代码
			$("#attrModal").html(configHtml);
			gUiObject[widgetIndex].showAttr(property);//显示控件属性值

			$("#attrModal").fadeIn(500);
			var attrModalHeigh = $("#attrModal").outerHeight(true);
			$("body").animate({paddingBottom: attrModalHeigh + 20},500);
			$(".demo").animate({minHeight: $(window).height() - 130 - attrModalHeigh},500);
			$("body").css("min-height", $(window).height() - 90 - attrModalHeigh);
		}

		//根据新属性更新控件样式
		$(".widgetAttrChange").change(function(){
			/*先更新id，再从缓存中删除原id、属性*/
	        new_uid = uid.substring(0,placeOfChar(uid,2,'_')+1) + randomNumber();
	        $("#"+uid).attr("id",new_uid);  
	        delete uiTemplateObj[uid];//删除原控件属性记录
	        uid = new_uid;

			var ui = gUiObject[widgetIndex].updateAttr(uid);//动态更新控件显示
			uiTemplateObj[ui.properties.tid] = ui.properties;//将拖动后创建的控件ID、属性进行缓存			
		});

	});

	<!--属性窗口关闭-->
	$('#attrModal').on("click","[data-target=#close]",function(e) {
		$('#attrModal').fadeOut(500);
		setTimeout(function() {$('#attrModal').empty()}, 500);
		$("body").css("padding-bottom","20px");
		$(".demo").animate({minHeight: $(window).height() - 130},500);
		$("body").css("min-height", $(window).height() - 90);
	});
	$("#savecontent").click(function(e) {
		e.preventDefault();
		currenteditor.html(contenthandle.getData());
	});
	$("[data-target=#downloadModal]").click(function(e) {
		e.preventDefault();
		downloadLayoutSrc();
	});
	$("[data-target=#shareModal]").click(function(e) {
		e.preventDefault();
		pushTemplate();
	});
	$("#download").click(function() {
		downloadLayout();
		return false
	});
	$("#downloadhtml").click(function() {
		downloadHtmlLayout();
		return false
	});
	$("#edit").click(function() {
		$("body").removeClass("devpreview sourcepreview");
		$("body").addClass("edit");
		removeMenuClasses();
		$(this).addClass("active");
		return false
	});
	$("#clear").click(function(e) {
		e.preventDefault();
		clearDemo()
	});
	$("#devpreview").click(function() {
		$("body").removeClass("edit sourcepreview");
		$("body").addClass("devpreview");
		removeMenuClasses();
		$(this).addClass("active");
		return false
	});
	$("#sourcepreview").click(function() {
		$("body").removeClass("edit");
		$("body").addClass("devpreview sourcepreview");
		removeMenuClasses();
		$(this).addClass("active");
		return false
	});
	$("#fluidPage").click(function(e) {
		e.preventDefault();
		changeStructure("container", "container-fluid");
		$("#fixedPage").removeClass("active");
		$(this).addClass("active");
		downloadLayoutSrc()
	});
	$("#fixedPage").click(function(e) {
		e.preventDefault();
		changeStructure("container-fluid", "container");
		$("#fluidPage").removeClass("active");
		$(this).addClass("active");
		downloadLayoutSrc()
	});
	$(".nav-header").click(function() {
		$(".sidebar-nav .boxes, .sidebar-nav .rows").hide();
		$(this).next().slideDown()
	});
	$('#undo').click(function(){
		stopsave++;
		if (undoLayout()) initContainer();
		stopsave--;
	});
	$('#redo').click(function(){
		stopsave++;
		if (redoLayout()) initContainer();
		stopsave--;
	})
	removeElm();
	gridSystemGenerator();
})