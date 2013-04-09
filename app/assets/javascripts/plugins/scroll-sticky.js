(function( $ ){

  $.fn.containedStickyScroll = function( options ) {
  
	var defaults = {  
		oSelector : this.selector,
		easing: 'swing',
		duration: 500,
		queue: true
	}  
                  
	var options =  $.extend(defaults, options);
  	//this.css('position','relative');
	
  	$(window).scroll(function() {
  		// clearTimeout($.data(this, 'scrollTimer'));
	   //  $.data(this, 'scrollTimer', setTimeout(function() {
		    getObject = options.oSelector;
	        if($(window).scrollTop() > ($(getObject).parent().offset().top) &&
	           ($(getObject).parent().height() + $(getObject).parent().position().top - 30) > ($(window).scrollTop() + $(getObject).height())){
	        	$(getObject).animate({ 'margin-top': ($(window).scrollTop() - $(getObject).parent().offset().top) + "px" }, 
	            { queue: options.queue, easing: options.easing, duration: options.duration });
	        }
	        else if($(window).scrollTop() < ($(getObject).parent().offset().top)){
	        	$(getObject).animate({ 'margin-top': "0px" },
	            { queue: options.queue, easing: options.easing, duration: options.duration });
	        }
	    // }, 250));
  		
	}).scroll();

  };
})( jQuery );