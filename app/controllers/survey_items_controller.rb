class SurveyItemsController < ApplicationController
	helper :all
	
	def	create
		@survey = Survey.find(params[:survey_id])
		item_params = Rack::Utils.parse_nested_query(params[:item_params])
		@item = get_item_constant(params[:item_type]).
			new(item_params.merge(survey: @survey, position: params[:item_position]))
		if @item.save
			render(partial: "survey_items/items/#{@item.type.demodulize.underscore}", locals:{item: @item})
		else
			render js: "alert('error')", status: :unprocessible_entry
		end
	end
	
	def destroy
	  @item = SurveyItem.find(params[:id])
	  @item.destroy
	  render nothing: true, status: 200
  end
	
	private
	
	def	get_item_constant(name)
		{ 'open_question' => 'SurveyItems::OpenQuestion',
			'multiple_select_question' => nil,
			'scale_question' => 'SurveyItems::ScaleQuestion',
			'desc_text' => 'SurveyItems::DescText',
			'page_break' => 'SurveyItems::PageBreak'}[name].constantize rescue nil
	end
	
end
