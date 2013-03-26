class this.Survey
	constructor: (params) ->
		@survey_id = params['survey_id']
		@base_path = "/surveys/#{@survey_id}" # e.g. "/survey/1"
		@translates = params['translates']
		@total_items = params['total_items']
		@trashed_items = params['trashed_items']
		$('#no-items-area').show() if @total_items is 0
		@self = this

		@buildList 		= '#build_list'
		@survey_items 	= '.survey_item'
		@insertButtons 	= '.insert_buttons'
		@noItemsArea 	= '#no-items-area'
		@zero_item 		= '#zero-item'

		@cancel_btn 	= '#cancel-btn'
		@delete_links 	= '.survey_item .deleteLnk'
		@edit_links 	= '.survey_item .item-edit-link'
		@updateSurveyUrl= params['survey_update_url']
		@new_item_form_data = null
		@current_action_item_id = null
		@renewItemsIndexes()

		$(document).on 'click', '#item_type_buttons button', (e) =>
			val = $(e.target).data('item-type')
			$('#new_survey_item').hide()
			$('#new_survey_item')
				.data('selected-item', true) #boolean indicator that shows that we selected item type
				.parents('.modal').find('.modal-header h3').text("New #{$(e.target).text()}")
			$('#newItem').append($("<iframe id=\"new-item-frame\" src=\"#{@base_path}/items/new?item_class=#{val}\"></iframe>")).show()
			#$('#newItem').html(itemsHtmlArray[val]).show()
			$('#doneNewItemBtn').removeAttr('disabled')
			# init_ck_editor()

		#insert buttons click handler:
		$(document).on 'click', @insertButtons, (el) =>
			_el = $(el.currentTarget)
			switch _el.data('action')
				when 'add_item'
					@addItem(_el.attr('itemindex'), @new_item_form_data)
				when 'copy_item'
					@copyItem(@current_action_item_id, _el.attr('itemindex'))
			
			@renewItemsIndexes()
			@hideButtons()
			@toggle_cancel_btn()

		#edit buttons click handler:
		$(document).on 'click', @edit_links, (el) =>
			_el = $(el.currentTarget)
			$('<div id="modal-bg"></div>').appendTo('body')
			modal = $('#editItemContainer')
			modal.find('#editItem').html('').append($("<iframe id=\"edit-item-frame\" src=\"#{_el.attr('data-url')}\"></iframe>"))
			$('#editItemContainer #edit-question-id').data('question_id', _el.parents('.survey_item').attr('item_id'))
			modal.removeClass('hide')
			false


		#remove links click handler:
		$(document).on 'click', @delete_links, (el) =>
			@deleteItem($(el.currentTarget).parents('.survey_item').attr('item_id'))
			false

		$('.sortable_item .moveGrabber').click => false

		$(@cancel_btn).hide().click =>
			@new_item_form_data = null
			@.hideButtons()
			@.toggle_cancel_btn()

		#copy link click handler
		$(document).on 'click', '.item-copy-link', (el) =>
			current_item_id = $(el.currentTarget).parents('.survey_item').attr('item_id')
			@toggle_cancel_btn()
			@show_and_prepare_buttons_for('copy_item', current_item_id)
			false

		#move link click handler
		$(document).on 'click', '.item-move-link', (el) =>
			current_item_id = $(el.currentTarget).parents('.survey_item').attr('item_id')
			@toggle_cancel_btn()
			@show_and_prepare_buttons_for('move_item', current_item_id)
			false

		$('#doneNewItemBtn').click =>
			# textarea = $('#rich-text-area')
			# if textarea.length > 0
			# 	textarea.val(CKEDITOR.instances['rich-text-area'].getData());

			if $('#new_survey_item').data('selected-item')
				iframe_result = document.getElementById('new-item-frame').contentWindow.submitItemForm();
				if iframe_result
					@show_and_prepare_buttons_for 'add_item', null
					@new_item_form_data = iframe_result
					@.showButtons()
					@.toggle_cancel_btn()
					@close_modals()
			false

		$('#doneEditItemBtn').click =>
			iframe_result = document.getElementById('edit-item-frame').contentWindow.submitItemForm();
			item_id = $('#editItemContainer #edit-question-id').data('question_id')
			if iframe_result
				$.ajax "/surveys/#{@survey_id}/items/#{item_id}",
					type: 'PUT'
					data: iframe_result
				@close_modals()
			false

		$('#new-item-btn').click =>
			$('#doneNewItemBtn').attr('disabled', true)
			@new_item_modal()
		

	close_modals: ->
		# CKEDITOR.instances[name].destroy(true) for name of CKEDITOR.instances
		$('#modal-bg').remove()
		$('.modal').addClass('hide')

	new_item_modal: ->
		$('<div id="modal-bg"></div>').appendTo('body')
		modal = $('#newItemContainer').removeClass('hide')
		modal.find('#new_survey_item').show()
		modal.find('#newItem').html('').hide()

	#FUNCTIONS:
	toggle_cancel_btn: ->
		if $(@cancel_btn).is(':hidden')
			$("#stickyBar .btn:not(#{@cancel_btn}), .item_tools button").attr('disabled', 'disabled')
		else
			$("#stickyBar .btn, .item_tools button").removeAttr 'disabled'
		$("#{@cancel_btn}, #new-item-btn").toggle()

	_currentButtons: ->
		$(@buildList).find(".survey_item #{@insertButtons}")

	#change all insert buttons labels and sets data-action attribute for use in their click callback function
	show_and_prepare_buttons_for: (action, current_action_item_id) ->
		@current_action_item_id = current_action_item_id
		label = @translates[action]
		if action is "move_item"
			@showButtons()
		else
			@showButtons()
		@_currentButtons().data('action', action).find('span').html(label)

	showButtons: -> @_currentButtons().css({visibility: 'inherit'})
	hideButtons: -> @_currentButtons().css({visibility: 'hidden'})

	renewItemsIndexes: ->
		$(@insertButtons).removeAttr('itemindex') #cleaning itemindexes
		@._currentButtons().each (i, el) =>
			$(el).attr('itemindex', i)
	
	#functions
	copyItem: (id, pos) =>
		self = this
		$.ajax "#{@base_path}/items/#{id}/copy",
			type: 'POST'
			data:
				item_position: pos
			success: (resp) -> #resp contains new item markup
				btn = $(self.insertButtons + "[itemindex=#{pos}]")
				$(resp).insertAfter(btn.parents('.survey_item')).hide().slideDown()
				self.renewItemsIndexes()
				self.total_items += 1


	addItem: (pos, params) =>
		self = this
		$.ajax "#{@base_path}/items",
			type: 'POST'
			data:
				item_params: params
				item_position: pos
			success: (resp) -> #resp contains new item markup
				btn = $(self.insertButtons + "[itemindex=#{pos}]")
				$(resp).insertAfter(btn.parents('.survey_item')).hide().slideDown()
				if self.total_items is 0
					$(self.noItemsArea).hide()
				self.renewItemsIndexes()
				self.total_items += 1


	deleteItem: (id) =>
		self = this
		$.ajax "#{@base_path}/items/#{id}/delete", 
			type: 'DELETE'
			success: -> #resp contains new item markup
				self.total_items -= 1
				self.trashed_items += 1
				$('#trashbox-btn span.trash-cnt').html("(#{self.trashed_items})")
				$(self.survey_items + "[item_id=#{id}]").slideUp 300, ->
					$(@).remove()
					$(self.noItemsArea).show() if self.total_items is 0
					self.renewItemsIndexes()