class LiquidInviteProcessor
  def initialize(current_user_id, survey_id, client_id, share_method_id)
    @share_email  = ShareMethods::Email.find(share_method_id)
    @client       = Client.find(client_id)
    @survey       = Survey.find(survey_id)
    @current_user = User.find(current_user_id)

    @variables = {
      'contact_name'  => @client.full_name,
      'survey_link'   => "#{ APP_HOST }/s/#{ @survey.token }",
      'survey_name'   => @survey.name
    }
    p @variables
  end

  def to
    @client.email
  end

  def from
    parse_template(@share_email.from_email)
  end

  def body
    parse_template(@share_email.text)
  end

  def subject
    parse_template(@share_email.subject)
  end

  private

  def parse_template(text)
    template = Liquid::Template.parse(text)
    template.render(@variables)
  end
end