class Survey < ActiveRecord::Base
  attr_accessible :account_id, :description, :category, :category_id, :theme_id,
    :name, :user_id, :user, :account, :items_positions, :prefill_items, :active

    default_scope order('created_at DESC')

  belongs_to :account
  belongs_to :user
  belongs_to :category
  belongs_to :theme, class_name: 'SurveyTheme'
  has_many   :items, dependent: :destroy, class_name: 'SurveyItem'
  has_many   :responses, dependent: :destroy
  has_many   :events, as: :eventable, dependent: :destroy
  serialize  :items_positions
  attr_accessor :prefill_items
  
  STEPS = %w(basic_info survey_type builder)
  
  validates :name, presence: true
  validates :category_id, presence: true, :unless => :seed_item?

  def self.preview_survey(lang)
    where(['account_id IS NULL AND preview_flag=?', lang]).first
  end
  
  def items_positions=(items)
    write_attribute(:items_positions, items.collect(&:to_i))
  end

  #returns an array of questions within the specified order (:questions_position)
  def sorted_items(params = {})
    self.items.active.sort do |x1, x2| 
      self.items_positions.index(x1.id) <=> self.items_positions.index(x2.id)
    end
  end

  #returns an array of questions within the specified order (:questions_position)
  def sorted_question_items
    self.items.active.question_items.sort do |x1, x2| 
      self.items_positions.index(x1.id) <=> self.items_positions.index(x2.id)
    end
  end

  #returns 2-dimensions array of items 
  def paged_items
    result = [[]]
    i = 0
    sorted_items.each do |x|
      if x.is_a?(SurveyItems::PageBreak)
        result << []; i += 1
      else
        result[i] << x
      end
    end
    result
  end
  
  #position - item num in the list
  #item_id - SurveyItem id
  def	insert_item(position, item_id)
  	self.items_positions.insert(position.to_i, item_id)
  end

  def switch!
    update_attributes(active: !self.active)
  end
  
  after_create :example_items, :event_on_created
  before_create :set_items_positions, :generate_token

  private
  
  def set_items_positions
    self.items_positions = []
  end
  
  def example_items
    return unless self.prefill_items
    #do something to fill this new survey with example items
  end

  def generate_token
    self.token = rand(20**7).to_s(16)
  end

  #create an event that there is a new survey
  def event_on_created
    self.events << Events::SurveyCreatedEvent.create(account_id: account_id)
  end
end

