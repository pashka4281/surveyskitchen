class SurveyItems::DropDownQuestion < SurveyItem
  attr_accessible :variants, :include_empty
  custom_field_accessor :include_empty
  
  def variants=(txt)
	  set_custom_field(:variants, txt.split("\n").collect(&:chop))  
  end

  def variants
    (get_custom_field_value(:variants) || []).join("\n")
  end

  def variants_array
  	get_custom_field_value(:variants)
  end

end
