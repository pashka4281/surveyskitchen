


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


# @clear_ck_editor_instances = ->
# 	if (CKEDITOR.instances['rich-text-area'])
# 		CKEDITOR.remove(CKEDITOR.instances['rich-text-area'])

# @init_ck_editor = ->
# 	return if (CKEDITOR.instances['rich-text-area'])
# 	if($('#rich-text-area').length > 0)
#     	CKEDITOR.replace( "rich-text-area" )



#init modal buttons/links click event handler
$(document).on 'click', '[data-toggle="modal"]', (el) =>
	self = this
	_el  = $(el.currentTarget)
	_modal = $(_el.data('target')).removeClass('hide')
	$('<div id="modal-bg"></div>').appendTo('body')
	url = if _el.is('a') then _el.attr('href') else _el.data('url')
	if url is undefined then return false
	$.ajax url,
		method: 'GET'
		dataType: 'html'
		success: (resp) ->
			_modal.find('.modal-body').html(resp)
			self.init_ck_editor()
	false


$('.modal .close').on 'click', (el) =>
	# self.clear_ck_editor_instances()
	$('#modal-bg').remove()
	$(el.currentTarget).parents('.modal').addClass('hide')
	$('.modal .modal-body #newItem').html('')
	false