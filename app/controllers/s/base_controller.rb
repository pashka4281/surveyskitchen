class S::BaseController < ApplicationController
	layout 'clients'
	
	rescue_from ActiveRecord::RecordNotFound do
		render 'not_found'
	end

	protected

	def get_survey
		@survey = Survey.find_by_token!(params[:token])
	end

	def current_respondent
		current_user if current_user && current_user.has_role?('respondent') 
	end

	def authenticate_respondent!
		if @survey.interactive?
			!current_respondent && redirect_to(s_auth_path(token: @survey.token)) and return
		end
	end
end
