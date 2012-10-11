		function BuilderUI(params){
			//CONSTRUCTOR:
			var self = this;
			this.buildList 		= '#build_list';
			this.survey_items 	= '.sortable_item';
			this.insertButtons 	= '.insert_buttons'; 
			this.delete_links 	= '.sortable_item .deleteLnk';
			this.edit_links 	= '.sortable_item .editSurveyItem';
			this.noItemsArea 	= '#no-items-area';
			this.zeroItem 		= '#zero-item';
			this.updateSurveyUrl= params['updateSurveyUrl'];
			this.survey_id 		= params['survey_id']
			this.new_item_form_data = null;
			//editable survey title:
			$('#survey-name').tinyEditor(self.updateSurveyUrl, {postName: 'survey[name]'})

			//making survey items sortable
			$(this.buildList).sortable({ 
				axis: 'y', 
				items: 'div.sortable_item',
				//containment: 'parent',
				handle: '.moveGrabber',
				update: function(){ 
				  	var info = $(this).sortable("serialize", {
            			key: 'survey[items_positions][]'
          			});
			        $.ajax({
			            url: self.updateSurveyUrl,
			            type: "PUT",
			            data: info
			        });
				  	self.renewItemsIndexes();
				} 
			});

			$('#doneNewItemBtn').click(function(){
				$('#editItemContainer > form').serialize();
				self.showButtons();
			});

			$('#doneEditItemBtn').click(function(){
				$.ajax('/surveys/' + self.survey_id + '/items/' + $('#editItemContainer form input[name=item_id]').val(), {
					type: 'PUT',
					data: $('#editItemContainer form').serialize()
				})
			});

			$(this.edit_links).click(function(){
				return false;
			});

			//FUNCTIONS:
			
			this.insertItem = function(html, pos, total_items){
				var btn = $(this.insertButtons + '[itemindex='+ pos + ']');
				$(html).insertAfter(btn.parents('.insertable')).hide().slideDown();
				if(total_items == 0){ 
					$(this.zeroItem).show();
					$(this.noItemsArea).hide();
				} 
				this.renewItemsIndexes();
			}
			
			this.removeItem = function(id, total_items){
			  $(this.survey_items + '[item_id=' + id + ']').slideUp(300, function(){
			    $(this).remove();
			    if(total_items == 0){
					$(self.zeroItem).hide();
					$(self.noItemsArea).show();
				}
				self.renewItemsIndexes();
			  });
			}
			
			this._currentButtons = function(){
				if($(this.noItemsArea).is(':hidden')){
					return $(this.buildList).find(this.zeroItem +' '+ this.insertButtons + ', .sortable_item ' + this.insertButtons);
				}else {
					return $(this.buildList).find(this.noItemsArea+' '+this.insertButtons)
				}
			}
			
			//change all insert buttons labels to `label`
			this.buttonsLabel = function(label){ $(this.insertButtons).html(label) }
			this.showButtons = function(){ self._currentButtons().css('display', 'block') }
			this.hideButtons = function(){ self._currentButtons().fadeOut(200) }

			this.renewItemsIndexes = function(){
				$(this.insertButtons).removeAttr('itemindex'); //cleaning itemindexes
				self._currentButtons().each(function(i, el){
					$(el).attr('itemindex', i);
				});
			}
			
			this.renewItemsIndexes();
		} 
	
		function Survey(params){
			//constructor
			this.survey_id = params['survey_id'];
			this.base_path = '/surveys/' + this.survey_id; // e.g. "/survey/1"
			this.newSurveyTypeSelector = $('#surveyTypeSelector');
			this.newSurveyTypeSelector.dropkick();
			this.total_items = params['total_items'];
			if(this.total_items == 0){ 
				$('#no-items-area').show();
				$('#zero-item').hide();
			}
			var self = this;

			this.builder_ui = new BuilderUI({
				updateSurveyUrl: params['survey_update_url'],
				survey_id: self.survey_id
			});

			//insert buttons click handler:
			$(this.builder_ui.insertButtons).live('click', function(){
				self.addItem($(this).attr('itemindex'), self.builder_ui.new_item_form_data);
				self.builder_ui.renewItemsIndexes();
				self.builder_ui.hideButtons();
			});

			//remove links click handler:
			$(this.builder_ui.delete_links).live('click', function(){
				self.deleteItem($(this).parents('.sortable_item').attr('item_id'));
				return false;
			});

			
			//callbacks:
			this.afterItemAdd	= undefined;
			this.onSuccCall  	= undefined;
			this.onErrorCall	= undefined;
			
			//functions			
			this.addItem = function(pos, params){
				var self = this;
				$.ajax(this.base_path + '/items', {
					type: 'POST',
					data: {
						item_params: params,
						item_position: pos
					},
					success: function(resp){ //resp contains new item markup
						self.builder_ui.insertItem(resp, pos, self.total_items);
						self.total_items += 1;
						if(self.afterItemAdd != undefined)
						  self.afterItemAdd(resp, pos);
					},
					error: function(){}
				});
			}		
			
			this.deleteItem = function(id){
			  var self = this;
				$.ajax(this.base_path + '/items/' + id + '/delete', {
					type: 'DELETE',
					success: function(){ //resp contains new item markup
						self.total_items -= 1;
						self.builder_ui.removeItem(id, self.total_items);
					},
					error: function(){}
				});
			}	
		}