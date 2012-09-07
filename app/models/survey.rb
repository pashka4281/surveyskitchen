class Survey < ActiveRecord::Base
  attr_accessible :account_id, :description, :category, :category_id, 
    :name, :user_id, :user, :account, :items_positions, :prefill_items

  belongs_to :account
  belongs_to :user
  belongs_to :category
  has_many  :items, :dependent => :destroy, class_name: 'SurveyItem'
  serialize :items_positions
  
  STEPS = %w(basic_info survey_type builder)
  
  validates :name, presence: true
  
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
  
  before_create :set_items_positions
  
  def set_items_positions
  	self.items_positions = []
  end
  
  after_create :example_items
  
  def example_items
    return unless self.prefill_items
    #do something to fill this new survey with example items
  end
end

