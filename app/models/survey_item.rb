class SurveyItem < ActiveRecord::Base
  attr_accessible :content, :survey_id, :type, :survey, :content, :title, :position
  belongs_to :survey

  serialize :content

  after_destroy :remove_position
  after_create  :add_position
  
  attr_writer :position


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

