class UsersController < ApplicationController
	before_filter :authenticate_user!, except: [:new, :create]
	skip_before_filter :set_locale, only: [:new, :create]
  	before_filter :set_locale_marketing, only: [:new, :create]
	
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
			session[:user_id] = @user.id
			redirect_to :dashboard, notice: I18n.t('layout.user_created_message')
		else
			render "new", layout: 'clear'
		end
	end
  	
end
