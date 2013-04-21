class BuyRequest < ActiveRecord::Base
  attr_accessible :acc_type, :email, :how_found, :name, :text

  validates :email, :name, presence: true
end
