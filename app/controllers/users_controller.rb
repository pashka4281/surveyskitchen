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
		@survey = Survey.demo_surveys.find_by_token(params[:ss])
		render layout: 'clear'
	end
	
	def create
		@user = User.new(params[:user])
		@survey = Survey.demo_surveys.find_by_token(params[:ss])
		if @user.save
			UserMailer.welcome_email(@user).deliver
			@survey.attach_to_user!(@user) if @survey
			session[:user_id] = @user.id
			redirect_to :dashboard, notice: I18n.t('layout.user_created_message')
		else
			render "new", layout: 'clear'
		end
	end
  	
end
