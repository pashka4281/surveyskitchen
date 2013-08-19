class this.Survey
	constructor: (params) ->
		@survey_id     = params['survey_id']
		@base_path     = "/surveys/#{@survey_id}" # e.g. "/survey/1"
		@translates    = params['translates']
		@total_items   = params['total_items']
		@trashed_items = params['trashed_items']
		@locale        = params['locale']
		$('#no-items-area').show() if @total_items is 0
		@self = this

		@buildList      = '#build_list'
		@survey_items   = '.survey_item'
		@noItemsArea    = '#no-items-area'
		@new_item_area  = '#new-item-area'
		@edit_item_area = '#edit-item-area'
		@add_item_tab   = '#add-item-tab'
		@remove_from_trashbox_link = "#trashed-items-list li .deleteLnk"

		@delete_links 	= '.survey_item .deleteLnk'
		@updateSurveyUrl= params['survey_update_url']
		@new_item_form_data = null
		@current_action_item_id = null


		# tabs functionality (jquery ui tabs) for toolbox
		@tabs = $('#tabs').tabs()

		@stickyBar = $('.stickyBar')
		@new_item_area = $( "#new-item-area" )
		@build_list    = $( "#build_list" )

		@makeToolboxScrollable()

		# let the new_item_area items be draggable
		$( "ul li", @new_item_area ).draggable
			cancel: "a.ui-icon" # clicking an icon won't initiate dragging
			revert: "invalid" # when not dropped, the item will revert back to its initial position
			containment: "document"
			helper: "clone"
			connectToSortable: '#survey-items-list'
			scroll: true
	

		$( '#survey-items-list', @build_list ).sortable
			placeholder: "drop-placeholder"
			axis: 'y'
			calcel: '.zero-item'
			forcePlaceholderSize: true
			cursor: 'move'
			opacity: 0.7
			revert: 200
			scrollSensitivity: 10
			scrollSpeed: 7
			tolerance: "intersect"
			start: (event, ui) =>
				_item  = ui.item
				prev_id = _item.prev().attr('item_id')
				_item.data('start_prev_id', prev_id)
			stop: (event, ui) =>
				_item  = ui.item
				i_type = $('button', _item).data('item-type')

				if (_item.hasClass("new-item"))
					prev_id = _item.prev().attr('item_id')
					loading_placeholder = $("<li class='item-loading-placeholder'>#{@translates.loading_item}</li>")
					_item.replaceWith(loading_placeholder)

					$.ajax
						url: "#{@updateSurveyUrl}/items"
						type: 'POST'
						dataType: 'json'
						data:
							item_type: i_type
							previous_item_id: prev_id
							survey_id: @survey_id
						success: (resp) =>
							reponse_item = $(resp.html)
							loading_placeholder.replaceWith(reponse_item)
							reponse_item.hide().slideDown(500)
							if @total_items is 0
								$(@noItemsArea).hide()
							@total_items += 1
							# @renewItemsIndexes()
				else
					if _item.hasClass('selected_item')
						@stickyBar.containedStickyScroll('fixToOffset', {offset: _item.offset().top})

					return true if _item.data('start_prev_id') is _item.prev().attr('item_id')

					$.ajax "#{@updateSurveyUrl}/items/#{_item.attr('item_id')}/move",
						type: 'PUT'
						data:
							previous_item_id: _item.prev().attr('item_id')
							survey_id: @survey_id
						success: (resp) -> #resp contains new item markup
							# $(resp).insertAfter(item).hide().slideDown()
							# @renewItemsIndexes()
							# @total_items += 1


		$( '#survey-items-list', @build_list ).disableSelection();
		# // let the trash be droppable, accepting the new_item_area items
		
		$(document).on 'click', @survey_items, (el) =>
			@editItem($(el.currentTarget).attr('item_id'))

		$(document).on 'click', @remove_from_trashbox_link, (el) =>
			_el = $(el.currentTarget)
			li = $(el.currentTarget).parents('li.trashed-item')
			item_id  = li.attr('item_id')
			$.ajax
				url: "#{@updateSurveyUrl}/items/#{item_id}"
				type: 'DELETE'
				data:
					survey_id: @survey_id
				success: (resp) =>
					li.fadeOut 300, =>
						li.remove()
					@trashed_items -= 1
					$('#trashbox-btn span.trash-cnt').html("(#{@trashed_items})")

		$(document).on 'click', @add_item_tab, (el) =>
			@clearEditingTab()

		#new item button clicked
		$(document).on 'click', "#new-item-area button", (el) =>
			i_type = $(el.currentTarget).data('item-type')
			prev_id = $('#survey-items-list .survey_item:last-child').attr('item_id')
			loading_placeholder = $("<li class='item-loading-placeholder'>#{@translates.loading_item}</li>").appendTo('#survey-items-list')
			$.ajax
				url: "#{@updateSurveyUrl}/items"
				type: 'POST'
				dataType: 'json'
				data:
					item_type: i_type
					previous_item_id: prev_id
					survey_id: @survey_id
				success: (resp) =>
					reponse_item = $(resp.html)
					loading_placeholder.replaceWith(reponse_item)
					reponse_item.hide().slideDown(500)
					if @total_items is 0
						$(@noItemsArea).hide()
					@total_items += 1

		#button on the empty survey welcome block
		$(document).on 'click', '#work-area-texting button', (el) =>
			$(@add_item_tab).click()
			$('#tabs').effect('highlight')

		#remove links click handler:
		$(document).on 'click', @delete_links, (el) =>
			@deleteItem($(el.currentTarget).parents('.survey_item').attr('item_id'))
			false

		#copy link click handler
		$(document).on 'click', '.item-copy-link', (el) =>
			self = this
			item = $(el.currentTarget).parents('.survey_item')
			$.ajax "#{@updateSurveyUrl}/items/#{item.attr('item_id')}/copy",
                type: 'POST'
                data:
                    survey_id: @survey_id
                    previous_item_id: item.attr('item_id')
                success: (resp) -> #resp contains new item markup
                    $(resp).insertAfter(item).hide().slideDown()
                    self.renewItemsIndexes()
                    self.total_items += 1
			false

		$(document).on 'submit', "#{@edit_item_area} form", (el) =>
			# iframe_result = document.getElementById('edit-item-frame').contentWindow.submitItemForm();
			_form = $(el.currentTarget)
			_item_id = _form.find('input[name="item_id"]').val()
			if(_form.validationEngine('validate'))
				$.ajax "#{@updateSurveyUrl}/items/#{_item_id}",
					type: 'PUT'
					data: _form.serialize()		
			false

	#DEPRECATED
	renewItemsIndexes: ->
		$(@survey_items).removeAttr('itemindex').each (i, el) =>
			$(el).attr('itemindex', i)

	clearEditingTab: =>
		# item_id = $(@edit_item_area).data('editing_item')
		clear_ck_editor_instances()
		$(@edit_item_area).removeData('editing_item')
		$(@survey_items).removeClass('selected_item')
		@tabs.find("#{@edit_item_area} .info-block").show()
		@tabs.find("#{@edit_item_area} form").validationEngine('detach')
		@tabs.find("#{@edit_item_area} .edit-form-wrapper").html('')
		@makeToolboxScrollable()

	# load item properties and show up edit tab
	editItem: (item_id)=>
		return if $(@edit_item_area).data('editing_item') is item_id
		clear_ck_editor_instances()
		self = this;
		$(@edit_item_area).data('editing_item', item_id)
		$(@survey_items).removeClass('selected_item')
		item = $("#{@survey_items}[item_id=#{item_id}]").addClass('selected_item')
		
		$("#tabs a[href=\"#{@edit_item_area}\"]").click()
		edit_form_wrapper = @tabs.find("#{@edit_item_area} .edit-form-wrapper")
		info_block = @tabs.find("#{@edit_item_area} .info-block")
		edit_form_wrapper.html("<div>#{@translates.loading_item}</div>")
		$.ajax "#{@updateSurveyUrl}/items/#{item_id}/edit",
			type: 'GET'
			success: (resp) -> #resp contains edit form
				edit_form_wrapper.html(resp).hide().fadeIn(100)
				info_block.hide()
				self.stickyBar.containedStickyScroll('fixToOffset', {offset: item.offset().top})
				$("form", edit_form_wrapper).validationEngine('detach').validationEngine 'attach',
					promptPosition: "inline"
					scroll: false
				init_ck_editor(self.locale)
	
	#functions

	# sticky toolbox
	makeToolboxScrollable: =>
		@stickyBar.containedStickyScroll 'attachScroll',
			duration: 200
			closeChar: 'x'

	copyItem: (id, pos) =>
		self = this
		$.ajax "#{@updateSurveyUrl}/items/#{id}/copy",
			type: 'POST'
			data:
				item_position: pos
			success: (resp) -> #resp contains new item markup
				# self.renewItemsIndexes()
				self.total_items += 1


	addItem: (pos, params) =>
		self = this
		$.ajax "#{@updateSurveyUrl}/items",
			type: 'POST'
			data:
				item_params: params
				item_position: pos
				survey_id: @survey_id
			success: (resp) -> #resp contains new item markup
				if self.total_items is 0
					$(self.noItemsArea).hide()
				self.total_items += 1

	#removing item from to the trashbox
	deleteItem: (id) =>
		self = this
		$.ajax "#{@updateSurveyUrl}/items/#{id}/delete", 
			type: 'DELETE'
			data:
				survey_id: @survey_id
			success: -> #resp contains new item markup
				self.total_items -= 1
				self.trashed_items += 1
				$('#trashbox-btn span.trash-cnt').html("(#{self.trashed_items})")
				$(self.add_item_tab).click()
				$(self.survey_items + "[item_id=#{id}]").slideUp 300, ->
					$(@).remove()
					$(self.noItemsArea).show() if self.total_items is 0


	restoreItem: (id) =>
		self = this