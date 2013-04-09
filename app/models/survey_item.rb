class SurveyItem < ActiveRecord::Base

  QUESTION_ITEMS = %w(SurveyItems::PageBreak SurveyItems::DescText SurveyItems::VideoQuestion)

  attr_accessible :content, :survey_id, :type, :survey, 
    :title, :subtitle, :position, :deleted_at, :required_field
  belongs_to :survey

  serialize :content, Hash
  default_value_for :content, {}

  after_destroy :remove_position
  after_create  :add_position
  
  attr_writer :position
  scope :trashed, where('deleted_at IS NOT NULL') #sqlite compatible syntax
  # scope :trashed, where('deleted_at <> NULL') #postgres compatible syntax
  scope :active, where(deleted_at: nil)

  scope :question_items, where('type NOT IN(?)', QUESTION_ITEMS)

  #seed attributes with default values
  after_initialize do
    return true unless self.new_record?
    YAML.load_file(Rails.root.join('config', 'defaults', 'survey_items.yml'))[I18n.locale.to_s][self.simple_name].each do |key, val|
      p self.send(key)
      self.send(key).blank? ? send("#{key}=", val) : true
    end
    true
  end

  def simple_name
    self.class.name.demodulize.underscore
  end

  #survey type specific report data
  def report_data
    raise NotImplementedError.new("You must override this method in descendant class.")
  end

  class << self
    def custom_field_accessor(*args)
      custom_field_reader(*args)
      custom_field_writer(*args)
    end
    
    def custom_field_reader(*args)
      args.each do |arg|
        define_method(arg) do
          get_custom_field_value(arg)
        end
      end
    end
    
    def custom_field_writer(*args)
      args.each do |arg|
        define_method(arg.to_s + '=') do |val|
          set_custom_field(arg, val)
        end
      end
    end
  end
  
  
  def set_custom_field(field_name, value)
    self.content = self.content.merge({field_name => value})
  end
  
  def get_custom_field_value(field_name)
    self.content[field_name]
  end
  
  def remove_custom_field(name)
    self.content = self.content.try(:delete, name)
  end  
  
  private

  #pushes newly created survey item to the survey's items_positions arrays
  def add_position
  	@position.blank? ? survey.items_positions << id : survey.insert_item(@position, id)
    survey.save
  end

  #removes syrvey item from the survey's items_positions array
  def remove_position
    survey.items_positions.delete(id)
    survey.save
  end

end

