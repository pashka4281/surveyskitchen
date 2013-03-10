class UsersController < ApplicationController
	before_filter :authenticate_user!, except: [:new, :create]
	
	def dashboard
		@surveys = current_account.surveys.all(:include => :responses)
		@responses = current_account.responses
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
  	
end
