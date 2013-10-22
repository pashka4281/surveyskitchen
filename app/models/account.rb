class Account < ActiveRecord::Base
	attr_accessible :name, :users, :owner

	has_many :users
	has_many :surveys
  has_many :responses, through: :surveys
	has_many :survey_visits, through: :surveys
	has_many :clients
	has_many :client_lists
	has_many :survey_themes

	has_many :quizzes

	belongs_to :owner, class_name: 'User', :foreign_key => :owner_id
end
