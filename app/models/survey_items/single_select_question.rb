class SurveyItems::SingleSelectQuestion < SurveyItem
  attr_accessible :variants, :include_txt_field
  custom_field_writer :include_txt_field
  
  def variants=(txt)
	  set_custom_field(:variants, txt.split("\n"))  
  end

  def variants
    (get_custom_field_value(:variants) || []).join("\n")
  end

  def variants_array
  	get_custom_field_value(:variants)
  end

  def include_txt_field
    {'0' => false, '1' => true}[get_custom_field_value(:include_txt_field)]
  end
  
end

