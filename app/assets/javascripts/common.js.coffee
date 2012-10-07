@addLoaderHover = -> 
	$('<div id="hover">
		<div id="circleG">
			<div id="circleG_1" class="circleG"></div>
			<div id="circleG_2" class="circleG"></div>
			<div id="circleG_3" class="circleG"></div>
		</div>
	</div>').appendTo('body').hide().fadeIn(100)

@removeLoaderHover = ->
	$('#hover').fadeOut 100, ->
		$(@).remove()

jQuery ->
	$.ajaxSetup({
		#success: ->	alert('success')
		#error: -> alert('error')
	})