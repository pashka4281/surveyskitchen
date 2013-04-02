class ShareLink < ActiveRecord::Base
	attr_accessible :survey_id, :custom_url, :active
	belongs_to :survey

	validates :custom_url, uniqueness: true, allow_blank: true
	delegate :token, :to => :survey

	has_many :responses, :as => :shareable

	def url_suffix
		custom_url || token
	end
end
