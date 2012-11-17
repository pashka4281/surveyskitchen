class ApplicationController < ActionController::Base
	helper_method :current_account
	protect_from_forgery

	def after_sign_in_path_for(resource)
		:dashboard
	end

	def current_account
		current_user.account rescue nil
	end

	def current_user_admin?
		unless current_user.try(:admin)
	  		redirect_to '/dashboard', alert: 'Access denied' and return false
		end
	end

end
