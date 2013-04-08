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



		#remove links click handler:
		$(document).on 'click', @delete_links, (el) =>
			@deleteItem($(el.currentTarget).parents('.survey_item').attr('item_id'))
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

	renewItemsIndexes: ->
		$(@survey_items).removeAttr('itemindex').each (i, el) =>
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