class Category < ActiveRecord::Base
  attr_accessible :name, :surveys
  has_many :surveys
  
  validates :name, presence: true, uniqueness: true
end
