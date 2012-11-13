class ResponsesController < ApplicationController
	
	def show
		@survey = Survey.find(params[:survey_id])
		@survey_items = @survey.items
		@response = @survey.responses.find(params[:id])
	end

	def index
		@survey = Survey.find(params[:survey_id])
		@responses = @survey.responses.order('created_at DESC')
	end
end
