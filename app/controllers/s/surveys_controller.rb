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
		@survey.responses.create(
			user_agent_string: request.env['HTTP_USER_AGENT'],
			response_data: params[:response],
			remote_ip: request.remote_ip
		)
		render 'passed'
	end
end
