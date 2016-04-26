$(function(){
	var myZCloudID = $("#listRealData_flowId").val();
	var myZCloudKey =$("#listRealData_flowKey").val();
	var serverAddr =$("#listRealData_serverAddr").val();
	///////////////////ʵʱ����
	var rtc = new WSNRTConnect(myZCloudID,myZCloudKey);//�����������ӷ������	
	if(serverAddr != null && serverAddr != ""){
		rtc.setServerAddr(serverAddr+":28080");
	}
	rtc.connect();
	//�ص����������ӳɹ�������
	rtc.onConnect = function () {
		console.log("rtconnect connected");
		$(".datamac").each(function () {//��֪�豸��ѯ
			var mac=$(this).attr("mac");
			if(mac!=null){
				var data_mac=mac.split('_');
				rtc.sendMessage(data_mac[0],"{"+data_mac[1]+"=?}");
			};
		});
	}
	//�ص����������ߴ�����
	rtc.onConnectLost = function () {
		rtc.connect();//����֮����������
	};
	rtc.onmessageArrive = function(mac, dat) {
		if ((dat[0] == '{' )&& (dat[dat.length-1] == '}')) {
			var data = dat.substr(1, dat.length-2);
			var tags = data.split(",");
			for (var i=0; i<tags.length; i++) {
				var t = tags[i];
				var v = t.split("=");
				if(v.length == 2){
					var dat_mac=mac+"_"+v[0];
					$(".datamac").each(function (){
						var d = new Date();
						var time = d.toLocaleString(); 
                        if ($(this).attr("mac") == dat_mac){
							$(this).siblings('.newdata').html(v[1]);
							$(this).siblings('.newtime').html(time);
						}
                    })
				}
			}
		}
	}
})		    	 