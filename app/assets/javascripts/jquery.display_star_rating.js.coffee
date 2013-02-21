# Reference jQuery
$ = jQuery

# Adds plugin object to jQuery
$.fn.extend
	# Change pluginName to your plugin's name.
	jDisplayStars: (options) ->
		# Default settings
		settings =
			length: 5 # number of star to display
			star_width: 23

	    # Merge default settings with options.
		settings = $.extend settings, options

		$.each this, (i,el) =>
			_el = $(el)
			rating        = _el.data('rating')
			size          = _el.data('size')
			outer_width   = settings.star_width * size
			width_percent = rating / size * outer_width + 'px'
			rating_bg     = $('<div class="star-bg"></div>').css width: width_percent
			rating_outer  = $('<div class="rating-outer"></div>').css width: outer_width + 'px'
			rating_value  = $("<div class=\"rating-value\">#{rating}</div>")

			rating_bg.appendTo(_el)
			rating_outer.appendTo(_el)
			rating_value.appendTo(_el)
		$(@)