class ShareMethodsController < ApplicationController
	before_filter :authenticate_user!
	SHARE_METHODS = {
			'email'  => 'ShareMethods::Email',
			'embed'  => 'ShareMethods::Embed',
			'link'   => 'ShareMethods::Link',
			'invite' => 'ShareMethods::Email',
			'social' => 'ShareMethods::Email'
		}

	def new
		@survey = current_account.surveys.find(params[:survey_id])
		@share_method = get_share_method_constant(params[:type]).new
		@type = params[:type]
	end

	def create
		@survey = current_account.surveys.find(share_method_params[:survey_id])
		@type = share_method_params.delete(:type)
		(SHARE_METHODS.values & [@type]).first.constantize.create(share_method_params)
		redirect_to share_survey_path(@survey)
	end

	def destroy
		@survey = current_account.surveys.find(params[:survey_id])
		@share_method = get_share_method_constant(params[:type]).find(params[:id])
		@share_method.destroy
		redirect_to share_survey_path(@survey)
	end

	private

	def get_share_method_constant(type)
		SHARE_METHODS[type].constantize rescue nil
	end

	def share_method_params
		params[:share_methods_email] || params[:share_methods_embed] # || params[:share_xxxx]
	end
end
