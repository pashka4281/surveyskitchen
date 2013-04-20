class Demo::SurveysController < ApplicationController
	layout 'clear'
	skip_before_filter :set_locale
	before_filter :set_locale_marketing

	def builder
		@survey = Survey.create(name: t('surveys.demo.default_name'), category: Category.first)
		@no_left_bar = true
	    @themes_global  = SurveyTheme.global
	end

	def preview
		@survey = Survey.demo_surveys.find_by_token(params[:survey_token])
		@paged_items = @survey.paged_items
		render '/surveys/preview', layout: 'clients'
	end

	def trashbox
		@survey = Survey.demo_surveys.find_by_token(params[:survey_token])
		render '/surveys/trashbox', layout: false
	end
end