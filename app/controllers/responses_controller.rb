class ResponsesController < ApplicationController
	
	def show
		@survey = Survey.find(params[:survey_id])
		@survey_items = @survey.items
		@response = @survey.responses.find(params[:id])
	end
end
