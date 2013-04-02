class ShareMethodsController < ApplicationController
	before_filter :authenticate_user!

	def new
		@survey = current_account.surveys.find(params[:survey_id])
		@share_method = get_share_method_constant(params[:type]).new
		@type = params[:type]
	end

	def create
		@survey = current_account.surveys.find(params[:share_method][:survey_id])
		get_share_method_constant(params[:type]).create(params[:share_method])
		redirect_to share_survey_path(@survey)
	end

	def destroy
		
	end

	private

	def get_share_method_constant(type)
		{
			'email'  => 'ShareEmail',
			'embed'  => 'ShareEmbed',
			'link'   => 'ShareLink',
			'invite' => 'ShareEmail',
			'social' => 'ShareEmail'
		}[type].constantize rescue nil
	end
end
