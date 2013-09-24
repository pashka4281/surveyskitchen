class SurveyMailer < ActionMailer::Base
  default from: "info@surveyskitchen.com"

  def invite(current_user_id, survey_id, client_id, share_method_id)
    lp = LiquidInviteProcessor.new(current_user_id, survey_id, client_id, share_method_id)
    mail(
      to:       lp.to,
      from:     lp.from,
      subject:  lp.subject,
      body:     lp.body
    )
  end
end
