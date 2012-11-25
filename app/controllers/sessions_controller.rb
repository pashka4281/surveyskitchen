class SessionsController < ApplicationController
  layout 'clear'

  def new
  	
  end

  def create
  	user = User.find_by_email(params[:email])
    p params
    p user
    p params[:password]
    p user.authenticate(params[:password])
	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect_to :dashboard, :notice => "Logged in!"
	  else
	    flash.now.alert = "Invalid email or password"
	    render "new"
	  end
  end

  def destroy
  	session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
