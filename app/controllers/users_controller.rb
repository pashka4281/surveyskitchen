class UsersController < ApplicationController
	before_filter :authenticate_user!, only: [:dashboard]
	
	def dashboard
		
	end

	def new
		@user = User.new
		render layout: 'clear'
	end
	
	def create
		@user = User.new(params[:user])
		if @user.save
			redirect_to :dashboard, notice: "Congratulations! Your account successfully created."
		else
			render "new", layout: 'clear'
		end
	end

	def update
	    @user = User.find(current_user.id)
	    email_changed = @user.email != params[:user][:email]
	    password_changed = !params[:user][:password].blank?

	    successfully_updated = if email_changed or password_changed
	      @user.update_with_password(params[:user])
	    else
	      @user.update_without_password(params[:user])
	    end

	    if successfully_updated
	      # Sign in the user bypassing validation in case his password changed
	      sign_in @user, :bypass => true
	      redirect_to :edit_profile, notice: 'Profile updated'
	    else
	      flash[:alert] = "Some errors occurred while updating.."
	      render "edit", layout: 'application'
	    end
  	end
  	
end
