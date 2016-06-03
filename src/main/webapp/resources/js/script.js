$(function() {
	docHeight();
	topNav();
});
$(window).resize(function () {
	docHeight();
});
//nav、main高度自适应
function docHeight() {
	var a = $(window).height() - $(".header").height() - $(".banner").height() - $(".footer").height();
	$(".topNav").css("height",a - 20 + "px");
	$(".main").css("height",a + "px");
	$("#iframe").css("height",a + "px");
};
//topNav
function topNav(){
	//topNav下拉效果
	var a = $(".topNav").children("li");
	var b = a.children("a");
	var lastClickTime = new Date().getTime();
	var delay = 300; //单击时间间隔
	b.click(function(){
		if (new Date().getTime() - lastClickTime < delay) {return;};
		lastClickTime = new Date().getTime();
		if ($(this).siblings("ul").css("display") == ("none")) {
			$.each(a, function(i){
				if (a.eq(i).children("ul").css("display") == "block") {
					a.eq(i).children("ul").slideToggle(250);
					a.eq(i).find("i").removeClass("icon-on").addClass("icon-off");
				};
			});
			$(this).siblings("ul").slideToggle(250);
			$(this).siblings("i").removeClass("icon-off").addClass("icon-on");
		};
	});
	//topNav高亮
	var c = $(".topNav").find("ul").find("a");
	c.click(function(){
		$.each(c,function(i){
			c.eq(i).removeClass("active");
		});
		$(this).addClass("active");
	});
};

/* ==========================================================
 * bootstrap-alert.js v2.3.2
 * http://getbootstrap.com/2.3.2/javascript.html#alerts
 * ==========================================================
 * Copyright 2013 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================== */


!function ($) {

  "use strict"; // jshint ;_;


 /* ALERT CLASS DEFINITION
  * ====================== */

  var dismiss = '[data-dismiss="alert"]'
    , Alert = function (el) {
        $(el).on('click', dismiss, this.close)
      }

  Alert.prototype.close = function (e) {
    var $this = $(this)
      , selector = $this.attr('data-target')
      , $parent

    if (!selector) {
      selector = $this.attr('href')
      selector = selector && selector.replace(/.*(?=#[^\s]*$)/, '') //strip for ie7
    }

    $parent = $(selector)

    e && e.preventDefault()

    $parent.length || ($parent = $this.hasClass('alert') ? $this : $this.parent())

    $parent.trigger(e = $.Event('close'))

    if (e.isDefaultPrevented()) return

    $parent.removeClass('in')

    function removeElement() {
      $parent
        .trigger('closed')
        .remove()
    }

    $.support.transition && $parent.hasClass('fade') ?
      $parent.on($.support.transition.end, removeElement) :
      removeElement()
  }


 /* ALERT PLUGIN DEFINITION
  * ======================= */

  var old = $.fn.alert

  $.fn.alert = function (option) {
    return this.each(function () {
      var $this = $(this)
        , data = $this.data('alert')
      if (!data) $this.data('alert', (data = new Alert(this)))
      if (typeof option == 'string') data[option].call($this)
    })
  }

  $.fn.alert.Constructor = Alert


 /* ALERT NO CONFLICT
  * ================= */

  $.fn.alert.noConflict = function () {
    $.fn.alert = old
    return this
  }


 /* ALERT DATA-API
  * ============== */

  $(document).on('click.alert.data-api', dismiss, Alert.prototype.close)

}(window.jQuery);