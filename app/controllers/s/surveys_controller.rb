class S::SurveysController < ApplicationController
	layout 'clients'

	rescue_from ActiveRecord::RecordNotFound do
		render 'not_found'
	end

	def show
		@survey = Survey.find_by_token!(params[:token])
		@paged_items = @survey.paged_items
	end

	def create_result
		@survey = Survey.find_by_token!(params[:token])
		render text: params.to_yaml
	end
end
