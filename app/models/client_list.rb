class ClientList < ActiveRecord::Base
  attr_accessible :account_id, :name
  
  has_many :clients
  belongs_to :account
end
