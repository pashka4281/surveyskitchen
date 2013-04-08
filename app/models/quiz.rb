class Quiz < ActiveRecord::Base
  attr_accessible :account_id, :name, :user_id
  belongs_to :account
  has_many :items, dependent: :destroy, class_name: 'QuizItem'
end
