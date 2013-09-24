class ShareMethods::Embed < ActiveRecord::Base
  self.table_name = "share_embeds"

	attr_accessible :survey_id, :active
	belongs_to :survey

	delegate :token, :to => :survey
	has_many :responses, :as => :shareable
end
