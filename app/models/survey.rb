class Survey < ActiveRecord::Base
  attr_accessible :account_id, :description, :name, :user_id, :user, :account, :items_positions

  belongs_to :account
  belongs_to :user
  has_many  :items, :dependent => :destroy, class_name: 'SurveyItem'
  serialize :items_positions
  
  def items_positions=(items)
    write_attribute(:items_positions, items.collect(&:to_i))
  end

  #returns an array of questions within the specified order (:questions_position)
  def sorted_items(params = {})
    self.items.sort do |x1, x2| 
      self.items_positions.index(x1.id) <=> self.items_positions.index(x2.id)
    end
  end
  
  #position - item num in the list
  #item_id - SurveyItem id
  def	insert_item(position, item_id)
  	self.items_positions.insert(position.to_i, item_id)
  end
  
  before_create do
  	self.items_positions = []
  end
end

