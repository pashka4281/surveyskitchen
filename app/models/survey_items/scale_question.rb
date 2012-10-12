class SurveyItems::ScaleQuestion < SurveyItem
  attr_accessible :scale_size
  
  def scale_size=(val)
    set_custom_field(:scale_size, val.to_i)
  end

  def scale_size
  	get_custom_field_value(:scale_size) || 5
  end
end

