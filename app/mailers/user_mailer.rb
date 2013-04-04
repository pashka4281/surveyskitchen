#encoding: utf-8

class UserMailer< ActionMailer::Base
  default from: "info@surveyskitchen.com"

  def welcome_email(user)
  	@user = user
  	mail(:to => @user.email, :subject => t('mailers.user.welcome.subject'))
  end
end