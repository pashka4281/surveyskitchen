#encoding: utf-8

class UserMailer< ActionMailer::Base
  default from: "info@surveyskitchen.com"
  layout "email"

  def welcome_email(user)
  	@user = user
  	mail(:to => @user.email, bcc: 'ceo@surveyskitchen.com', :subject => t('mailers.user.welcome.subject'))
  end
end
