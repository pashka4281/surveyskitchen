class ApplicationController < ActionController::Base
	helper_method :current_account, :current_user
	protect_from_forgery
	before_filter :set_locale

	unless Rails.env.development?
		rescue_from Exception,                            :with => :render_500
		rescue_from ActionController::RoutingError,       :with => :render_404
		rescue_from ActionController::UnknownController,  :with => :render_404
		rescue_from AbstractController::ActionNotFound,   :with => :render_404
		rescue_from ActiveRecord::RecordNotFound,         :with => :render_404
	end

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
		!current_user && redirect_to(login_path(I18n.default_locale)) and return
	end

	def authenticate_admin!
		redirect_to(locale_root_path(I18n.default_locale)) and return if !current_user || !current_user.admin?
	end

	#getting current locale from user profile or from headers
	def set_locale
		# unless self.class.parent.name == 'RailsAdmin'
			I18n.locale = get_locale_from_user || extract_locale_from_accept_language_header
		# else
		# 	I18n.locale = :en
		# end
	end

	def set_locale_marketing
		lang_from_param  = (["en", "ru"] & [params[:locale]]).first
		I18n.locale = lang_from_param || get_locale_from_session || extract_locale_from_accept_language_header || I18n.default_locale
		cookies.permanent[:remember_locale] = { :value => lang_from_param, :domain => :all } if lang_from_param
	end

	def redirect_back_or_default_url
		redirect_to request.referer ? :back : :root
	end

	def	get_item_constant(name)
		{ 'text_field_question' => 'SurveyItems::TextFieldQuestion',
			'multiple_select_question' => 'SurveyItems::MultipleSelectQuestion',
			'single_select_question' => 'SurveyItems::SingleSelectQuestion',
			'scale_question' => 'SurveyItems::ScaleQuestion',
			'desc_text' => 'SurveyItems::DescText',
			'drop_down_question' => 'SurveyItems::DropDownQuestion',
			'video_question' => 'SurveyItems::VideoQuestion',
			'single_select_grid' => 'SurveyItems::SingleSelectGrid',
			'signature' => 'SurveyItems::Signature',
			'page_break' => 'SurveyItems::PageBreak'}[name].constantize rescue nil
	end

	protected

	def load_user
		@user = current_user
	end

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
		(["en", "ru"] & [request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first]).first rescue I18n.default_locale
	end


	def render_404(exception)
		return if image_suffix?
		# render :text => exception.class and return
		flash.now[:alert] = exception.message
		ExceptionStorage.from_exception(exception)# unless exception.is_a?(ActiveRecord::RecordNotFound)
		respond_to do |type|
			type.html { render('/error_pages/404', :status => 404, layout: current_user ? 'application' : 'clear') and return }
		end
	end

	def render_500(exception)
		return if image_suffix?
		ExceptionStorage.from_exception(exception)
		respond_to do |type|
			type.html { render('/error_pages/500', :status => 500, layout: current_user ? 'application' : 'clear') and return }
		end
	end

	def image_suffix?
		request.url =~ /\.(png|gif|jpe?g|bmp|tiff?|svg|psd)$/i
	end

end
