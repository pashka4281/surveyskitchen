class SurveyItemsController < ApplicationController
	before_filter :authenticate_user!
	helper :all

	def new
		item_class = get_item_constant(params[:item_class])
		render nothing: true and return unless item_class
		
		@survey = current_account.surveys.find(params[:survey_id])
		@survey_item = item_class.new
		render layout: 'item_modal'
	end

	def edit
		@survey = current_account.surveys.find(params[:survey_id])
		@survey_item = @survey.items.find(params[:id])
		render layout: false
	end

	def update
		@survey = current_account.surveys.find(params[:survey_id])
		@survey_item = @survey.items.find(params[:id])
		@survey_item.update_attributes(params[:survey_item])
	end
	
	def	create
		@survey = current_account.surveys.find(params[:survey_id])
		item_params = Rack::Utils.parse_nested_query(params[:item_params])
		type = item_params.delete('item_type')
		@item = get_item_constant(type).
			new((item_params['survey_item'] || {}).merge(survey: @survey, position: params[:item_position]))
		if @item.save
			render(partial: "survey_items/items/#{@item.type.demodulize.underscore}", locals:{item: @item})
		else
			render js: "alert('error')", status: :unprocessible_entry
		end
	end
	
	def destroy
		@survey = current_account.surveys.find(params[:survey_id])
  		@item = @survey.items.find(params[:id])
  		@item.destroy
  	end
  
  	def delete
    	@survey = current_account.surveys.find(params[:survey_id])
  		@item = @survey.items.find(params[:item_id])
	  	@item.update_attributes(:deleted_at => Time.now)
	  	render nothing: true, status: 200
  	end  	

  	def copy
    	@survey = current_account.surveys.find(params[:survey_id])
  		@item = @survey.items.find(params[:item_id])
	  	@new_item = SurveyItem.new(@item.attributes.merge(position: params[:item_position]))

	  	if @new_item.save
	  		@new_item = SurveyItem.find(@new_item.id)
			render(partial: "survey_items/items/#{@item.type.demodulize.underscore}", locals:{item: @new_item})
		else
			render js: "alert('error')", status: :unprocessible_entry
		end
  	end
	
	private
	
	def	get_item_constant(name)
		{ 'text_field_question' => 'SurveyItems::TextFieldQuestion',
			'multiple_select_question' => 'SurveyItems::MultipleSelectQuestion',
			'single_select_question' => 'SurveyItems::SingleSelectQuestion',
			'scale_question' => 'SurveyItems::ScaleQuestion',
			'desc_text' => 'SurveyItems::DescText',
			'drop_down_question' => 'SurveyItems::DropDownQuestion',
			'video_question' => 'SurveyItems::VideoQuestion',
			'single_select_grid' => 'SurveyItems::SingleSelectGrid',
			'page_break' => 'SurveyItems::PageBreak'}[name].constantize rescue nil
	end
	
end
