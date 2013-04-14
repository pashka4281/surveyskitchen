(function( $ ){

  $.fn.containedStickyScroll = function(action_name, options ) {
	var defaults = {  
		oSelector : this.selector,
		easing: 'swing',
		duration: 200,
		queue: false
	}

	var options =  $.extend(defaults, options);
	self = $(options.oSelector);

	if(action_name == 'fixToOffset'){
		detachScroll();
		var item_offset = options.offset,
			total_offset = item_offset - self.data('init-offset');
		// console.log(offset)
		self.animate({ 'margin-top': total_offset + "px" },
		    { queue: options.queue, easing: options.easing, duration: options.duration });
  	}else if(action_name == 'attachScroll'){
  		if(self.data('init-offset') == undefined)
  			self.data('init-offset',self.offset().top );
  		attachScroll();
  	}


	function attachScroll(){
		// console.log('attachScroll')
		$(window).scroll(function() {
	  		// clearTimeout($.data(this, 'scrollTimer'));
		   //  $.data(this, 'scrollTimer', setTimeout(function() {
			    getObject = options.oSelector;
		        if($(window).scrollTop() > (self.parent().offset().top)){
		        	self.animate({ 'margin-top': ($(window).scrollTop() - self.parent().offset().top) + "px" }, 
		            { queue: options.queue, easing: options.easing, duration: options.duration });
		        }
		        else if($(window).scrollTop() < (self.parent().offset().top)){
		        	self.animate({ 'margin-top': "0px" },
		            { queue: options.queue, easing: options.easing, duration: options.duration });
		        }
		    // }, 250));
	  		
		}).scroll();
	}

	function detachScroll(){
		$(window).unbind();
	}

  };
})( jQuery );