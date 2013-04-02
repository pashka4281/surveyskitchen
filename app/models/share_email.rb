class ShareEmail < ActiveRecord::Base
	attr_accessible :survey_id, :text, :active

  	#seed attributes with default values
	after_initialize do
		return true unless self.new_record?
		self.text = YAML.load_file(Rails.root.join('config', 'defaults', 'share_email.yml'))[I18n.locale.to_s]['text']
	end
end
