module S
	class SurveysController < BaseController
		before_filter :get_survey
		before_filter :authenticate_respondent!, only: [:show, :create_result]

		def show
			@paged_items = @survey.paged_items
			# if @survey.interactive
			# 	@current_respondent = current_respondent()
			# else
				render 'deactivated' and return unless @survey.active
				render 'passed' and return if cookies["survey_passed_#{@survey.id}"]
				
				cookies.permanent["survey_shown_#{@survey.id}"] = { :value => true, :domain => :all }
				@survey.survey_visits.create(
					user_agent_string: request.env['HTTP_USER_AGENT'],
					response_data: params[:response] || {},
					remote_ip: request.remote_ip
				)
			# end
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
	end
end