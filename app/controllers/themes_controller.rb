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


	def create
		@survey = current_account.surveys.find(params[:survey_id])
		@theme = current_account.survey_themes.new(params[:survey_theme])
		if @theme.save
			@survey.update_attributes(theme: @theme)
			redirect_to look_survey_path(@survey, page: 'themes'), notice: "Theme created"
		else
			@page = 'new_theme'
			render 'surveys/look'
		end
	end

	def update
		@survey = current_account.surveys.find(params[:survey_id])
		@theme = current_account.survey_themes.find(params[:id])
		if @theme.update_attributes(params[:survey_theme])
			redirect_to look_survey_path(@survey, page: 'themes'), notice: "Theme updated"
		else
			redirect_to look_survey_path(@survey, page: 'theme_builder'), alert: "Some error occurred"
		end
	end
end
