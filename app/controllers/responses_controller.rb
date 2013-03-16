class ResponsesController < ApplicationController
	before_filter :authenticate_user!
	
	def show
		@survey = current_account.surveys.find(params[:survey_id])
		@survey_items = @survey.items
		@response = @survey.responses.find(params[:id])
	end

	def index
		@survey = current_account.surveys.find(params[:survey_id])
		@responses = @survey.responses.order('created_at DESC').page(params[:page])
	end

	def destroy
		@survey = current_account.surveys.find(params[:survey_id])
		@response = @survey.responses.find(params[:id])
		@response.destroy

		redirect_to survey_responses_path(@survey)
	end
end
