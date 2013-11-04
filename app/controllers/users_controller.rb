class UsersController < ApplicationController
	before_filter :authenticate_user!, except: [:new, :create]
	skip_before_filter :set_locale, only: [:new, :create]
		before_filter :set_locale_marketing, only: [:new, :create]
	
	def dashboard
		@surveys         = current_account.surveys.all(:include => :responses)
		@responses       = current_account.responses.last_30_days.map(&:created_at).map(&:to_date)
		@grouped_count   = @responses.group_by(&:month).each{|x,y| y.clear }
		@responses_count = []
		
		29.downto(0).each do |x|
			date = (Time.current - x.days).to_date
			@grouped_count[date.month] = [] if @grouped_count[date.month].nil?
			@grouped_count[date.month] << [date, @responses.count(date)]
			@responses_count << @responses.count(date)
		end

		@grouped_count = @grouped_count.sort { |l, r| l[1]<=>r[1] }
		@max_chart_value = @responses_count.max
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
			UserMailer.delay.welcome_email(@user)
			@survey.attach_to_user!(@user) if @survey
			session[:user_id] = @user.id
			redirect_to :dashboard, notice: I18n.t('layout.user_created_message')
		else
			render "new", layout: 'clear'
		end
	end
  	
end
