function saveValidate(){
	var namepass=true,titleContentpass=true,footContentpass=true,idpass=true,keypass=true,addrpass=true,typepass=true,tidpass=true;
	var name = $("#name").val();
	var titleContent = $("#titleContent").val();
	var footContent = $("#footContent").val();
	var zcloudID = $("#zcloudID").val();
	var zcloudKEY = $("#zcloudKEY").val();
	var serverAddr = $("#serverAddr").val();
	var templateType = $("#templateType").val();
	var tid = $("#templateList").val();
	if(name == ""){
		namepass = false;
		$('<span class="error">项目名不能为空</span>').insertAfter('#name');
		//console.log("项目名不能为空");
	}
	if(titleContent == ""){
		titleContentpass = false;
		$('<span class="error">项目头详细信息不能为空</span>').insertAfter('#titleContent');
		//console.log("项目名不能为空");
	}
	if(footContent == ""){
		footContentpass = false;
		$('<span class="error">项目尾详细信息不能为空</span>').insertAfter('#footContent');
		//console.log("项目名不能为空");
	}
	if(zcloudID == ""){
		idpass = false;
		$('<span class="error">智云ID不能为空</span>').insertAfter('#zcloudID');
		//console.log("智云ID不能为空");
	}
	if(zcloudKEY == ""){
		keypass = false;
		$('<span class="error">智云KEY不能为空</span>').insertAfter('#zcloudKEY');
		//console.log("智云KEY不能为空");
	}
	if(serverAddr == ""){
		addrpass = false;
		$('<span class="error">智云服务器地址不能为空</span>').insertAfter('#serverAddr');
		//console.log("智云服务器地址不能为空");
	}
	if(templateType == -1){
		typepass = false;
		$('<span class="error">请选择模板类型</span>').insertAfter('#templateType');
		//console.log("请选择模板类型");
	}
	if(tid == null || tid == -1){
		tidpass = false;
		$('<span class="error">模板ID不能为空</span>').insertAfter('#templateList');
		//console.log("模板ID不能为空");
	}
	return namepass && titleContentpass && footContentpass && idpass && keypass && addrpass && typepass && tidpass;
}


//美图秀秀
function loadImg(basePath){
	var altContentTop = $("body").height()/2 - 240;
	var altContentLeft = $(".panel").eq(0).width()/2 - 300;
	$(".altContent-shell").eq(0).css({
		"display":"block",
		"top":altContentTop + "px",
		"left":altContentLeft + "px"
	});
	$("#editForm").addClass("filter");
	/*第1个参数是加载编辑器div容器，第2个参数是编辑器类型，第3个参数是div容器宽，第4个参数是div容器高*/
	xiuxiu.embedSWF("altContent",5,"100%","100%");
  //修改为您自己的图片上传接口
	xiuxiu.setUploadURL(basePath+"/uploadImage");
  xiuxiu.setUploadType(2);
  xiuxiu.setUploadDataFieldName("upload_file");
	xiuxiu.onInit = function ()
	{
		xiuxiu.loadPhoto(basePath+"/resources/images/meituxiuxiu.jpg");
	};
	xiuxiu.onUploadResponse = function (data)
	{
//		console.log("data:"+JSON);
		if(data != ''){
			var dat = JSON.parse(data);
			console.log("status:"+dat.status);
			console.log("data:"+dat.data);
			console.log("boolean:"+(dat.status == 1));
			if(dat.status == 1){//push成功
				var path = basePath+"/photo/"+dat.data;
				$("#imageSrc").attr('src',path);
				$(".altContent-shell").eq(0).css("display","none");
				$("#editForm").removeClass("filter");
			}else{
				console.log("提交图片失败!");
			}
		}
	};
};