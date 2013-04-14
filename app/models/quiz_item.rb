class QuizItem < ActiveRecord::Base
  attr_accessible :content, :css_options, :position, :quiz_id, :size, :type

  serialize :css_options, Hash
  default_value_for :css_options, {}

  serialize :content, Hash
  default_value_for :content, {}

  serialize :size, Array
  default_value_for :size, []

  serialize :position, Array
  default_value_for :position, []

  belongs_to :quiz

  #seed attributes with default values
  after_initialize do
    return true unless self.new_record?
    YAML.load_file(Rails.root.join('config', 'defaults', 'quiz_items.yml'))[I18n.locale.to_s][self.simple_name].each do |key, val|
    	self.send(key).blank? ? send("#{key}=", val) : true
    end
  	true
  end

  def to_css
  	(css_options.collect{|k,v| "#{k}:#{v};" } + 
  		["left: #{position[1]}px;", "top: #{position[0]}px;", "width: #{size[0]}px;", "height:#{size[1]}px;"]).join
  end

  def simple_name
  	self.class.name.demodulize.underscore
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
end
