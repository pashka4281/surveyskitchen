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
			if($('#new_survey_item').data('selected-item'))
				@new_item_form_data = $('#newItemContainer form').serialize()
				@.showButtons()
				@.toggle_cancel_btn()
			false

		$('#doneEditItemBtn').click =>
			$.ajax
				url: "/surveys/#{@survey_id}/items/" + $('#editItemContainer form input[name=item_id]').val()
				type: 'PUT'
				data: $('#editItemContainer form').serialize()
			false

		$(@edit_links).click => false

	#FUNCTIONS:
	insertItem: (html, pos, total_items) ->
		btn = $(@insertButtons + "[itemindex=#{pos}]")
		$(html).insertAfter(btn.parents('.insertable')).hide().slideDown()
		if @total_items is 0
			$(@noItemsArea).hide()
			$(@zero_item).show()
		@renewItemsIndexes()

	removeItem: (id, total_items) =>
		$(@survey_items + "[item_id=#{id}]").slideUp 300, =>
			$(@).remove()
			$("#{@noItemsArea}, #{@zero_item}").toggle() if @total_items is 0
		@renewItemsIndexes()

	toggle_cancel_btn: ->
		if $(@cancel_btn).is(':hidden')
			$("#newItemBar .btn:not(#{@cancel_btn})").attr('disabled', 'disabled')
		else
			$("#newItemBar .btn").removeAttr('disabled')
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
		$(@insertButtons).removeAttr('itemindex'); #cleaning itemindexes
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
				self.builder_ui.insertItem(resp, pos, @total_items)
				@total_items += 1
				if(@afterItemAdd != undefined)
					@afterItemAdd(resp, pos)

	deleteItem: (id) =>
		it = this
		$.ajax "#{@base_path}/items/#{id}/delete",
			type: 'DELETE'
			success: -> #resp contains new item markup
				@total_items -= 1
				it.builder_ui.removeItem(id, @total_items)