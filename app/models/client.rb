class Client < ActiveRecord::Base
  attr_accessible :account_id, :client_list_id, :email, :first_name, :full_name, :last_name, :note

  belongs_to :client_list
  belongs_to :account
end
