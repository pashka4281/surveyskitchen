class SurveyItems::MultipleSelectQuestion < SurveyItem
  attr_accessible :variants
  custom_field_accessor :include_txt_field
  
  def variants=(txt)
	  set_custom_field(:variants, txt.split("\n"))  
  end
  
  def variants
    (get_custom_field_value(:variants) || []).join("\n")
  end

  def variants_array
  	get_custom_field_value(:variants)
  end
end

