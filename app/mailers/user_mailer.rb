class UserMailer< ActionMailer::Base
  default from: "info@surveyskitchen.com"

  def welcome_email(user)
  	@user = user
  	mail(:to => @user.email, :subject => "Добро пожаловать в SurveysKitchen")
  end
end
