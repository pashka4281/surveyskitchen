class S::SurveysController < ApplicationController
	layout 'clients'

	def show
		@survey = Survey.find(params[:id])
	end
end
