class Account < ActiveRecord::Base
  attr_accessible :name, :users, :owner

  has_many :users
  has_many :surveys
  has_many :responses, through: :surveys

  belongs_to :owner, class_name: 'User', :foreign_key => :owner_id
end
