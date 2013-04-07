class Quiz < ActiveRecord::Base
  attr_accessible :account_id, :name, :user_id
  belongs_to :account
end
