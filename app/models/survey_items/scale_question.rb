class SurveyItems::ScaleQuestion < SurveyItem
  attr_accessible :scale_size
  custom_field_reader :scale_size
  
  def scale_size=(val)
    set_custom_field(:scale_size, val.to_i)
  end
end

