# Reference jQuery
$ = jQuery

# Adds plugin object to jQuery
$.fn.extend
	# Change pluginName to your plugin's name.
	jTabs: (options) ->
		# Default settings
		settings =
			length: 5 # number of star to display
			star_width: 23

	    # Merge default settings with options.
		settings = $.extend settings, options

		$.each this, (i,el) =>
			_el = $(el)
			_el.find('.handle input').click (e)=>
				_el.find('.tab').removeClass('active')
				$(e.currentTarget).parents('.tab').addClass('active')
			# _el.find('.active content').addClass('visible')
		$(@)