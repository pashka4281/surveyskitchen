class ShareMethods::Email < ActiveRecord::Base
  self.table_name = "share_emails"

	attr_accessible :survey_id, :text, :active, :from_email, :subject, :recipients, :current_user_id
  attr_accessor :current_user_id

  serialize :recipients, Array

  	#seed attributes with default values
	after_initialize do
		return true unless self.new_record?
		self.text = YAML.load_file(Rails.root.join('config', 'defaults', 'share_email.yml'))[I18n.locale.to_s]['text']
	end

  after_create do # sending emails:
    self.recipients.each do |client_id|
      SurveyMailer.delay.invite(self.current_user_id, self.survey_id, client_id, self.id)
    end
  end
end
