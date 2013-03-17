class ThemesController < ApplicationController
	before_filter :authenticate_user!

	def index
		@survey = current_account.surveys.find(params[:survey_id])
		@themes = current_account.survey_themes
	end


	def theme_preview
		@theme       = SurveyTheme.find_theme(current_account.id, params[:theme_id])
		@survey      = Survey.preview_survey(current_user.language)
		@paged_items = @survey.paged_items
		render layout: 'theme_preview'
	end

	def new
		@theme  = SurveyTheme.new
		@survey = current_account.surveys.find(params[:survey_id])
		@preview_survey = Survey.preview_survey(current_user.language)
	end
end
