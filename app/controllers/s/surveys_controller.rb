class S::SurveysController < ApplicationController
	layout 'clients'
	before_filter :get_survey

	rescue_from ActiveRecord::RecordNotFound do
		render 'not_found'
	end

	def show
		@paged_items = @survey.paged_items
		render 'deactivated' and return unless @survey.active
		render 'passed' and return if cookies["survey_passed_#{@survey.id}"]
		
		cookies.permanent["survey_shown_#{@survey.id}"] = { :value => true, :domain => :all }
	end

	def create_result
		render nothing: true and return if cookies["survey_passed_#{@survey.id}"]

		unless @survey.active
			@deactivated = true
			render action: :show
		end

		@survey.responses.create(
			user_agent_string: request.env['HTTP_USER_AGENT'],
			response_data: params[:response] || {},
			remote_ip: request.remote_ip
		)
		cookies.permanent["survey_passed_#{@survey.id}"] = { :value => true, :domain => :all }
		render 'passed'
	end

	private

	def get_survey
		@survey = Survey.find_by_token!(params[:token])
	end
end
