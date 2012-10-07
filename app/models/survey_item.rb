class SurveyItem < ActiveRecord::Base
  attr_accessible :content, :survey_id, :type, :survey, :title, :position, :deleted_at
  belongs_to :survey

  serialize :content, Hash

  after_destroy :remove_position
  after_create  :add_position
  
  attr_writer :position
  scope :trashed, where('deleted_at <> NULL')
  scope :active, where(deleted_at: nil)
  
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
  
  before_create do
    self.content ||= {}
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

