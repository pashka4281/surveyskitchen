class ExceptionMailer < ActionMailer::Base
  default from: "admin@surveyskitchen.com"

   def new_exception_notify(ex)
  	@ex = ex
  	mail(:to => "ceo@surveyskitchen.com", :subject => "New Exception")
  end
end
