class ApplicationController < ActionController::Base
	helper_method :current_account
	protect_from_forgery

	def after_sign_in_path_for(resource)
		:dashboard
	end

	def current_account
		current_user.account rescue nil
	end

end
