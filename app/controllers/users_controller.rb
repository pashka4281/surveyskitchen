class UsersController < ApplicationController
	before_filter :authenticate_user!, except: [:new, :create]
	skip_before_filter :set_locale, only: [:new, :create]
  	before_filter :set_locale_marketing, only: [:new, :create]
	
	def dashboard
		@surveys = current_account.surveys.all(:include => :responses)
		@responses = current_account.responses.last_30_days.map(&:created_at).map(&:to_date)
		@events = current_account.survey_events.limit(10)
		
		time_ago = Time.now - 30.days
		time_now = Time.now
		@chart_data = Array.new(30, 0)
		@chart_days = Array.new(30, "")
		(Date.new(time_ago.year,time_ago.month,time_ago.day)..Date.new(time_now.year,time_now.month,time_now.day)).each_with_index do |date, i| 
			@chart_data[i] = @responses.count(date)
			@chart_days[i] = Time.parse(date.to_s).to_s(:day_of_month) if i % 4 == 0
		end
		@max_chart_value = @chart_data.max
	end

	def new
		@user = User.new
		@survey = Survey.demo_surveys.find_by_token(params[:ss])
		render layout: 'clear'
	end
	
	def create
		@user = User.new(params[:user])
		@survey = Survey.demo_surveys.find_by_token(params[:ss])
		if @user.valid?
			@user.roles = ['user', 'respondent']
			@user.save
			UserMailer.welcome_email(@user).deliver
			@survey.attach_to_user!(@user) if @survey
			session[:user_id] = @user.id
			redirect_to :dashboard, notice: I18n.t('layout.user_created_message')
		else
			render "new", layout: 'clear'
		end
	end
  	
end
