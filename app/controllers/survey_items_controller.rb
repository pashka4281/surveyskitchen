class SurveyItemsController < ApplicationController
	helper :all

	def new
		render layout: false
	end

	def edit
		@survey = Survey.find(params[:survey_id])
		@survey_item = @survey.items.find(params[:id])
		render layout: false
	end

	def update
		@survey = Survey.find(params[:survey_id])
		@survey_item = @survey.items.find(params[:id])
		@survey_item.update_attributes(params[:survey_item])
	end
	
	def	create
		@survey = Survey.find(params[:survey_id])
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
		@survey = Survey.find(params[:survey_id])
  		@item = @survey.items.find(params[:id])
  		@item.destroy
  		render nothing: true, status: 200
  	end
  
  	def delete
  		p params
    	@survey = Survey.find(params[:survey_id])
  		@item = @survey.items.find(params[:item_id])
	  	@item.update_attributes(:deleted_at => Time.now)
	  	render nothing: true, status: 200
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
