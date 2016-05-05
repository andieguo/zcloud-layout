
function WSNAutoctrl() {
	var thiz = this;
	if (arguments.length == 2) {
		thiz.uid = arguments[0];
		thiz.xKey = arguments[1];
	} else {
		thiz.uid = null;
		thiz.xKey = null;
	}
	thiz.saddr = "zhiyun360.com:8001";
	 
	thiz.setIdKey = function(uid, key) {
		thiz.uid = uid;
		thiz.xKey = key;		
	};
	
	thiz.initZCloud = function(uid, key) {
		thiz.uid = uid;
		thiz.key = key;		
	};
	
	thiz.setServerAddr = function(addr) {
		thiz.saddr = addr;
	};
	
	thiz.getTrigger = function() {
		var url = "http://"+thiz.saddr+"/v2/trigger/"+thiz.uid;
		var id = null;
		var  cb = null;
		if (arguments.length == 1) {cb = arguments[0];}
		else {id = arguments[0]; cb = arguments[1];}
		if (id != null) {
			url += "?id="+id;
		} 
		$.ajax({
			type: "GET",
	    	url: url,
	    	dataType:"json",
	    	beforeSend: function( xhr ) {
				xhr.setRequestHeader("X-ApiKey", thiz.xKey);
			},
	    	success: function(data) {
	        	cb(data);
	    	}
    	});
	};
	thiz.createTrigger = function(name, type, param, cb) {
		var t = {};
		t['name'] = name;
		t['type'] = type;
		t['param'] = param;
		var url = "http://"+thiz.saddr+"/v2/trigger/"+thiz.uid;
		$.ajax({
			type: "POST",
	    	url: url,
	    	dataType:"json",
	    	data:JSON.stringify(t),
	    	beforeSend: function( xhr ) {
				xhr.setRequestHeader("X-ApiKey", thiz.xKey);
			},
	    	success: function(data) {
	        	if (cb)cb(data);
	    	}
    	});
	};
	thiz.deleteTrigger = function(id, cb) {
		var url = "http://"+thiz.saddr+"/v2/trigger/"+thiz.uid;	
		url += "?id="+id;
		$.ajax({
			type: "DELETE",
	    	url: url,
	    	dataType:"json",
	    	beforeSend: function( xhr ) {
				xhr.setRequestHeader("X-ApiKey", thiz.xKey);
			},
	    	success: function(data) {
	        	if (cb) cb(data);
	    	}
    	});
	};
	
	thiz.getActuator = function() {
		var url = "http://"+thiz.saddr+"/v2/actuator/"+thiz.uid;
		var id = null;
		var  cb = null;
		if (arguments.length == 1) {cb = arguments[0];}
		else {id = arguments[0]; cb = arguments[1];}
		if (id != null) {
			url += "?id="+id;
		} 
		$.ajax({
			type: "GET",
	    	url: url,
	    	dataType:"json",
	    	beforeSend: function( xhr ) {
				xhr.setRequestHeader("X-ApiKey", thiz.xKey);
			},
	    	success: function(data) {
	        	cb(data);
	    	}
    	});
	};
	thiz.createActuator = function(name, type, param, cb) {
		var t = {};
		t['name'] = name;
		t['type'] = type;
		t['param'] = param;
		var url = "http://"+thiz.saddr+"/v2/actuator/"+thiz.uid;
		$.ajax({
			type: "POST",
	    	url: url,
	    	dataType:"json",
	    	data:JSON.stringify(t),
	    	beforeSend: function( xhr ) {
				xhr.setRequestHeader("X-ApiKey", thiz.xKey);
			},
	    	success: function(data) {
	        	cb(data);
	    	}
    	});
	};
	thiz.deleteActuator = function(id, cb) {
		var url = "http://"+thiz.saddr+"/v2/actuator/"+thiz.uid;	
		url += "?id="+id;
		$.ajax({
			type: "DELETE",
	    	url: url,
	    	dataType:"json",
	    	beforeSend: function( xhr ) {
				xhr.setRequestHeader("X-ApiKey", thiz.xKey);
			},
	    	success: function(data) {
	        	if (cb) cb(data);
	    	}
    	});
	}
	
	thiz.getJob = function() {
		var url = "http://"+thiz.saddr+"/v2/job/"+thiz.uid;
		var id = null;
		var  cb = null;
		if (arguments.length == 1) {cb = arguments[0];}
		else {id = arguments[0]; cb = arguments[1];}
		if (id != null) {
			url += "?id="+id;
		} 
		$.ajax({
			type: "GET",
	    	url: url,
	    	dataType:"json",
	    	beforeSend: function( xhr ) {
				xhr.setRequestHeader("X-ApiKey", thiz.xKey);
			},
	    	success: function(data) {
	        	cb(data);
	    	}
    	});
	};
	thiz.createJob = function(name, enable, param, cb){
		var t = {};
		t['name'] = name;
		t['enable'] = enable;
		t['param'] = param;
		var url = "http://"+thiz.saddr+"/v2/job/"+thiz.uid;
		$.ajax({
			type: "POST",
	    	url: url,
	    	dataType:"json",
	    	data:JSON.stringify(t),
	    	beforeSend: function( xhr ) {
				xhr.setRequestHeader("X-ApiKey", thiz.xKey);
			},
	    	success: function(data) {
	        	cb(data);
	    	}
    	});
	};
	thiz.deleteJob = function(id, cb){
		var url = "http://"+thiz.saddr+"/v2/job/"+thiz.uid;	
		url += "?id="+id;
		$.ajax({
			type: "DELETE",
	    	url: url,
	    	dataType:"json",
	    	beforeSend: function( xhr ) {
				xhr.setRequestHeader("X-ApiKey", thiz.xKey);
			},
	    	success: function(data) {
	        	if (cb) cb(data);
	    	}
    	});
	};
	
	
	thiz.setJob = function(id, en, cb) {
		var url = "http://"+thiz.saddr+"/v2/job/"+thiz.uid;	
		url += "?id="+id;
		var t = {
			enable:en
		};
		$.ajax({
			type: "PUT",
	    	url: url,
	    	dataType:"json",
	    	data:JSON.stringify(t),
	    	beforeSend: function( xhr ) {
				xhr.setRequestHeader("X-ApiKey", thiz.xKey);
			},
	    	success: function(data) {
	        	if (cb) cb(data);
	    	}
    	});
	};
	
	thiz.getSchedudler = function(jid,duration,cb){
		var url = "http://"+thiz.saddr+"/v2/schedudler/"+thiz.uid;	
		var q = "";
		if (duration != "") {
			if (q.length > 0) q += "&";
			q += "duration="+duration;
		}
		if (jid != "") {
			if (q.length > 0) q += "&";
			q += "jid="+jid;
		}
		if (q.length > 0) {
			url += "?"+q;
		}
	
		$.ajax({
			type: "GET",
	    	url: url,
	    	dataType:"json",
	    	beforeSend: function( xhr ) {
				xhr.setRequestHeader("X-ApiKey", thiz.xKey);
			},
	    	success: function(data) {
	        	if (cb) cb(data);
	    	}
    	});
    };
    thiz.deleteSchedudler = function(id, cb){
    	var url = "http://"+thiz.saddr+"/v2/schedudler/"+thiz.uid;	
    	url += "?id="+id;
   	    $.ajax({
			type: "DELETE",
	    	url: url,
	    	dataType:"json",
		    beforeSend: function( xhr ) {
				xhr.setRequestHeader("X-ApiKey", thiz.xKey);
			},
	    	success: function(data) {
	        	if (cb) cb(data);
	    	}
    	});	
	};
}