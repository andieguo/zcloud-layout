function get_camera() {
	var i=1;
	$(".camerabox").each(function(){
		$(this).find(".btn").css("outline","medium none");
		$(this).find("object").find("img").attr("id","img"+i);
		var myImgId = "img"+i;//img标签的id
	    var myCameraIP =$(this).find("figure").find(".camera-switch").attr("domain");//摄像头IP地址
	    var user = $(this).find("figure").find(".camera-switch").attr("user");//摄像头访问用户名
	    var pwd =$(this).find("figure").find(".camera-switch").attr("password");//摄像头访问密码
	    //var myCameraUrl="http://www.zhiyun360.com/data/getVideoUrlAjax?initurl="+myCameraIP+"&user="+user+"&pwd="+pwd+"&jsoncallback=?";
		var type = $(this).find("figure").find(".camera-switch").attr("type");//摄像头型号
		var myipcamera = [];
		myipcamera.i= new WSNCamera();	//创建myipcamera对象
		myipcamera.i.initCamera(myCameraIP, user, pwd,type); //摄像头初始化
		var serverAddr = $("#form_serverAddr").val();
		myipcamera.i.setServerAddr(serverAddr+":8002");//设置图像服务器
		myipcamera.i.setDiv(myImgId);//设置图像显示的位置
		myipcamera.i.checkOnline(function(state){
			if(state !=""){
				$("#"+myImgId).parent("object").siblings("figure").find(".switch_open").css("pointer-events","auto");
				myipcamera.i.setResolution("640_352");//将摄像头的分辨率设置成640*480
			}	
		});
		$(this).find(".switch_open").click(function (){
	    	var kai=$(this).html();
	    	if(kai=="开"){//判断摄像头是否为开
	    		$(this).text('关');
	    		$(this).siblings("button").css("pointer-events","auto");
	    		myipcamera.i.openVideo();//打开摄像头并显示
				if(type=="H3-Series")
				{
					$(this).parents(".camerabox").find("object").css("background","black");
					$("#"+myImgId).css("margin-top","40px");
				}
	    		$(this).siblings(".ct_up").click(function () {//上
	    			myipcamera.i.control("UP");
		        })
				
	    		$(this).siblings(".ct_down").click(function () {//下
	    			myipcamera.i.control("DOWN");//向摄像头发送向下移动命令
		        })
				
	    		$(this).siblings(".ct_left").click(function () {//左
	    			myipcamera.i.control("LEFT");//向摄像头发送向左移动命令
		        })
				
	    		$(this).siblings(".ct_right").click(function () {//右
	    			myipcamera.i.control("RIGHT");//向摄像头发送向右移动命令
		        })
				
	    		$(this).siblings(".ct_h").click(function () {//水平巡航
	    			myipcamera.i.control("HPATROL");//向摄像头发送水平巡航命令
		        })
				
	    		$(this).siblings(".ct_v").click(function () {//垂直巡航
	    			myipcamera.i.control("VPATROL");//向摄像头发送垂直巡航命令
		        })
				
	    		$(this).siblings(".ct_c").click(function () {//360度巡航
	    			myipcamera.i.control("360PATROL");//向摄像头发送360度巡航命令
		        })
	    	}else{
	    		$(this).html('开');
	    		$(this).siblings("button").css("pointer-events","none");
				if(type=="H3-Series")
				{
					$(this).parents(".camerabox").find("object").css("background","none");
				}
	    		myipcamera.i.closeVideo(); //关闭视频监控  
	    	}
	    });
		i++;
	})
}