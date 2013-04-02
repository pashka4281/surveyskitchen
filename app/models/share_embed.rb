class ShareEmbed < ActiveRecord::Base
	attr_accessible :survey_id, :active
	belongs_to :survey

	delegate :token, :to => :survey
	has_many :responses, :as => :shareable
end
