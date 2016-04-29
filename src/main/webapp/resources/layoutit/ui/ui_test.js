var ui_test = {

	html : ' <div class="box box-element ui-draggable"> <a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>'+
                 '<div class="preview">测试</div>' +
                 '<div class="view">' +
                   ' <div id="ui_test"  mac="11:22:33:44:55">测试'+
                    '</div>'+
                  '</div>'+
         '</div>',

    create: function(id){
    	// console.log('ui create');
    	var e = $(".demo #ui_test");
		var t = randomNumber();
		var n = "ui_test_" + t;
		var r;
		e.attr("id", n);
    }

}
