class S::SurveysController < ApplicationController
	layout 'clients'

	def show
		@survey = Survey.find(params[:id])
		@paged_items = @survey.paged_items
	end

	def create_result
		@survey = Survey.find(params[:id])
	end
end
