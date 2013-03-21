class SessionsController < ApplicationController
  layout 'clear'

  def new
  	
  end

  def create
  	user = User.find_by_email(params[:email])
	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect_to :dashboard, :notice => "Logged in!"
	  else
	    flash.now.alert = "Invalid email or password"
	    render "new"
	  end
  end

  def destroy
    current_user_locale = current_user.language
  	session[:user_id] = nil
    redirect_to locale_root_path(current_user_locale), :notice => "Logged out!"
  end
end
