class QuizItemsController < ApplicationController

	def create
		@quiz = current_account.quizzes.find(params[:quize_id])
		@item_type = params[:item_type]
		@item = get_item_constant(@item_type).new(quiz_id: @quiz.id, 
			position: [params[:position_top].to_i, params[:position_left].to_i])
		@item.save
	end

	def update
		@quiz = current_account.quizzes.find(params[:quize_id])
		@item = @quiz.items.find(params[:id])
		@item.update_attributes(params[:item])
		render json: {css: @item.to_css}
	end


	private
	
	def	get_item_constant(name)
		{   'text_field_question' => 'SurveyItems::TextFieldQuestion',
			'multiple_select_question' => 'SurveyItems::MultipleSelectQuestion',
			'single_select_question' => 'SurveyItems::SingleSelectQuestion',
			'scale_question' => 'SurveyItems::ScaleQuestion',
			'desc_text' => 'QuizItems::DescText',
			'drop_down_question' => 'SurveyItems::DropDownQuestion',
			'video_question' => 'SurveyItems::VideoQuestion',
			'single_select_grid' => 'SurveyItems::SingleSelectGrid',
			'page_break' => 'SurveyItems::PageBreak'}[name].constantize rescue nil
	end

end