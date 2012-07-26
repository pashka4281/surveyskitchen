class SurveyItems::MultipleSelectQuestion < SurveyItem
  attr_accessible :variants
  
  def variants=(txt)
	  set_custom_field(:variants, txt.split("\n"))  
  end
  
  def variants
    get_custom_field_value(:variants)
  end
end

