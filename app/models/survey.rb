class Survey < ActiveRecord::Base
  attr_accessible :account_id, :description, :category, :category_id, :theme_id, :theme,
    :name, :user_id, :user, :account, :items_positions, :prefill_items, :active

  default_scope order('created_at DESC')

  belongs_to :account
  belongs_to :user
  belongs_to :category
  belongs_to :theme, class_name: 'SurveyTheme'
  has_many   :items, dependent: :destroy, class_name: 'SurveyItem'
  has_many   :responses, dependent: :destroy
  has_many   :events, as: :eventable
  serialize  :items_positions, Array
  default_value_for  :items_positions, []

  #share methods:
  has_one :share_link
  has_one :share_embed
  has_one :share_email

  attr_accessor :prefill_items
  
  STEPS = %w(basic_info survey_type builder)
  
  validates :name, presence: true
  validates :category_id, presence: true

  scope :demo_surveys, where('user_id IS NULL')

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
  def	insert_item!(previous_item_id, item_id)
    if previous_item_id
      index = self.items_positions.index(previous_item_id.to_i)
  	  self.items_positions.insert(index + 1, item_id)
    else
      self.items_positions.unshift(item_id)
    end
    self.save
  end

  def move_item!(previous_item_id, item_id)
    self.items_positions.delete(item_id)
    if previous_item_id
      index = self.items_positions.index(previous_item_id.to_i)
      self.items_positions.insert(index + 1, item_id)
    else
      self.items_positions.unshift(item_id)
    end
    self.save
  end

  def switch!
    update_attributes(active: !self.active)
  end
  
  def attach_to_user!(user)
    self.user_id = user.id
    self.account_id = user.account_id
    self.save
  end

  after_create :example_items, :event_on_created, :setup_default_share_methods
  after_destroy :event_on_destroyed
  before_create :assign_theme, :generate_token

  private
  
  def example_items
    return unless self.prefill_items
    #do something to fill this new survey with example items
  end

  def generate_token
    self.token = loop do
      random_token = rand(20**7).to_s(16) #SecureRandom.urlsafe_base64
      break random_token unless self.where(token: random_token).exists?
    end
  end

  def setup_default_share_methods
    ShareLink.create(survey_id: self.id, active: true)
    ShareEmbed.create(survey_id: self.id, active: true)
    # ShareEmail.create(survey_id: self.id)
  end

  #create an event that there is a new survey
  def event_on_created
    self.events << Events::SurveyCreatedEvent.create(account_id: account_id, eventable_name: self.name)
  end  

  #create an event that a survey is destroyed
  def event_on_destroyed
    self.events << Events::SurveyDestroyedEvent.create(account_id: account_id, eventable_name: self.name)
  end


  def assign_theme
    self.theme = SurveyTheme.global.first
  end
end

