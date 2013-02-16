#remove loader function
@addLoaderHover = -> 
	$('<div id="hover">
		<div id="circleG">
			<div id="circleG_1" class="circleG"></div>
			<div id="circleG_2" class="circleG"></div>
			<div id="circleG_3" class="circleG"></div>
		</div>
	</div>').appendTo('body').hide().fadeIn(100)

#remove loader function
@removeLoaderHover = ->
	$('#hover').fadeOut 100, ->
		$(@).remove()


jQuery ->
	#init modal buttons/links click event handler
	$('[data-toggle="modal"]').click ->
		_this  = $(this)
		_modal = $(_this.data('target')).removeClass('hide')
		$('<div id="modal-bg"></div>').appendTo('body')
		$.ajax(_this.attr('href'), {
			method: 'GET',
			dataType: 'html',
			success: (resp) ->
				_modal.find('.modal-body').html(resp)
		})
		return false

	$('.modal .close').on 'click', ->
		$('#modal-bg').remove()
		$(this).parents('.modal').addClass('hide')
		return false