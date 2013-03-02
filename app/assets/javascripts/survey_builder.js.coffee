@GlobalClasses = {}

class this.BuilderUI
	constructor: (params) ->
		@buildList 		= '#build_list'
		@survey_items 	= '.survey_item'
		@insertButtons 	= '.insert_buttons'
		@noItemsArea 	= '#no-items-area'
		@zero_item 		= '#zero-item'

		@cancel_btn 	= '#cancel-btn'
		@delete_links 	= '.survey_item .deleteLnk'
		@edit_links 	= '.survey_item .editSurveyItem'
		@updateSurveyUrl= params['updateSurveyUrl']
		@survey_id		= params['survey_id']
		@new_item_form_data = null
		@renewItemsIndexes()

		$('.sortable_item .moveGrabber').click => false

		$(@cancel_btn).hide().click =>
			@new_item_form_data = null
			@.hideButtons()
			@.toggle_cancel_btn()

		$('#doneNewItemBtn').click =>
			textarea = $('#rich-text-area')
			if textarea.length > 0
				textarea.val(CKEDITOR.instances['rich-text-area'].getData());

			if($('#new_survey_item').data('selected-item'))
				@new_item_form_data = $('#newItemContainer form').serialize()
				@.showButtons()
				@.toggle_cancel_btn()
			false

		$('#doneEditItemBtn').click =>
			textarea = $('#rich-text-area')
			if textarea.length > 0
				textarea.val(CKEDITOR.instances['rich-text-area'].getData());
			$.ajax
				url: "/surveys/#{@survey_id}/items/" + $('#editItemContainer form input[name=item_id]').val()
				type: 'PUT'
				data: $('#editItemContainer form').serialize()
			false

		$(@edit_links).click => false

	#FUNCTIONS:
	insertItem: (html, pos, total_items) ->
		btn = $(@insertButtons + "[itemindex=#{pos}]")
		console.log btn
		console.log btn.parents('.insertable')
		$(html).insertAfter(btn.parents('.insertable')).hide().slideDown()
		console.log total_items
		if total_items is 0
			$(@noItemsArea).hide()
			$(@zero_item).show()
		@renewItemsIndexes()

	removeItem: (id, total_items) =>
		console.log total_items
		self = this
		$(@survey_items + "[item_id=#{id}]").slideUp 300, ->
			$(@).remove()
			$("#{self.noItemsArea}, #{self.zero_item}").toggle() if total_items is 0
			self.renewItemsIndexes()

	toggle_cancel_btn: ->
		if $(@cancel_btn).is(':hidden')
			$("#stickyBar .btn:not(#{@cancel_btn})").attr('disabled', 'disabled')
		else
			$("#stickyBar .btn").removeAttr 'disabled'
		$("#{@cancel_btn}, #new-item-btn").toggle()

	_currentButtons: ->
		if($(@noItemsArea).is(':hidden'))
			return $(@buildList).find("#{@zero_item} #{@insertButtons}, .survey_item #{@insertButtons}")
		else
			return $(@buildList).find("#{@noItemsArea} #{@insertButtons}")

	#change all insert buttons labels to `label`
	buttonsLabel: (label) ->  $(@insertButtons).html(label)
	showButtons: -> @._currentButtons().css({'visibility': 'inherit'})
	hideButtons: -> @._currentButtons().css({'visibility': 'hidden'})

	renewItemsIndexes: ->
		$(@insertButtons).removeAttr('itemindex') #cleaning itemindexes
		@._currentButtons().each (i, el) =>
			$(el).attr('itemindex', i)


class this.Survey
	constructor: (params) ->
		@survey_id = params['survey_id']
		@base_path = "/surveys/#{@survey_id}" # e.g. "/survey/1"
		@total_items = params['total_items']
		$('#no-items-area, #zero-item').toggle() if @total_items is 0
		@builder_ui = new BuilderUI(updateSurveyUrl: params['survey_update_url'], survey_id: @survey_id)
		@self = this

		#insert buttons click handler:
		$(document).on 'click', @builder_ui.insertButtons, (el) =>
			console.log $(el.currentTarget)
			console.log $(el.currentTarget).prop('itemindex')
			@addItem($(el.currentTarget).attr('itemindex'), @builder_ui.new_item_form_data)
			@builder_ui.renewItemsIndexes()
			@builder_ui.hideButtons()
			@builder_ui.toggle_cancel_btn()

		#remove links click handler:
		$(document).on 'click', @builder_ui.delete_links, (el) =>
			@deleteItem($(el.currentTarget).parents('.survey_item').attr('item_id'))
			false

		#callbacks:
		afterItemAdd = 	undefined
		onSuccCall   =	undefined
		onErrorCall  = 	undefined
	
	#functions			
	addItem: (pos, params) =>
		self = this
		$.ajax "#{@base_path}/items",
			type: 'POST'
			data:
				item_params: params
				item_position: pos
			success: (resp) -> #resp contains new item markup
				self.builder_ui.insertItem(resp, pos, self.total_items)
				self.total_items += 1
				if(@afterItemAdd != undefined)
					@afterItemAdd(resp, pos)

	deleteItem: (id) =>
		self = this
		$.ajax "#{@base_path}/items/#{id}/delete",
			type: 'DELETE'
			success: -> #resp contains new item markup
				self.total_items -= 1
				self.builder_ui.removeItem(id, self.total_items)