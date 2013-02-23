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

#init modal buttons/links click event handler
$(document).on 'click', '[data-toggle="modal"]', ->
	_this  = $(@)
	_modal = $(_this.data('target')).removeClass('hide')
	$('<div id="modal-bg"></div>').appendTo('body')
	url = if _this.is('a') then _this.attr('href') else _this.data('url')
	if url is undefined then return false
	$.ajax url,
		method: 'GET'
		dataType: 'html'
		success: (resp) ->
			_modal.find('.modal-body').html(resp)
	false

$('.modal .close').on 'click', ->
	$('#modal-bg').remove()
	$(@).parents('.modal').addClass('hide')
	false