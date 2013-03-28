class SurveyItems::SingleSelectQuestion < SurveyItem
  attr_accessible :variants, :include_txt_field, :shuffle_options
  custom_field_writer :include_txt_field
  custom_field_writer :shuffle_options
  
  def variants=(txt)
	  set_custom_field(:variants, txt.split("\n").collect(&:strip))  
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

  def shuffle_options
    {'0' => false, '1' => true}[get_custom_field_value(:shuffle_options)]
  end
  
end

