class ApplicationController < ActionController::Base
	helper_method :current_account, :current_user
	protect_from_forgery
	before_filter :set_locale

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

	def authenticate_user!
		!current_user && redirect_to(:login, alert: 'You have to login first') and return
	end

	#getting current locale from user profile or from headers
	def set_locale
		I18n.locale = get_locale_from_user || extract_locale_from_accept_language_header
	end

	def set_locale_marketing
		lang_from_param  = (["en", "ru"] & [params[:locale]]).first
		I18n.locale = lang_from_param || get_locale_from_session || extract_locale_from_accept_language_header
		cookies.permanent[:remember_locale] = { :value => lang_from_param, :domain => :all }
	end

	def redirect_back_or_default_url
		redirect_to request.referer ? :back : :root
	end

	private

  	def current_user
	    @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def get_locale_from_user
		current_user && current_user.language
	end

	def get_locale_from_session
		cookies[:remember_locale]
	end

	def extract_locale_from_accept_language_header
		request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first rescue "en"
	end

end
