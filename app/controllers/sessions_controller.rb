class SessionsController < ApplicationController
  layout 'clear'
  skip_before_filter :set_locale
  before_filter :set_locale_marketing

  def new
  	
  end

  def create
  	user = User.find_by_email(params[:email])
	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect_to :dashboard, :notice => I18n.t('layout.user_signed_in_message', name: user.full_name)
	  else
	    flash.now.alert = "Invalid email or password"
	    render "new"
	  end
  end

  def destroy
    current_user_locale = current_user.language
  	session[:user_id] = nil
    redirect_to locale_root_path(current_user_locale)
  end
end
