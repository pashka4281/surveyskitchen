class SurveyItems::SingleSelectQuestion < SurveyItem
  attr_accessible :variants
  custom_field_reader :variants
  
  def variants=(txt)
	  set_custom_field(:variants, txt.split("\n").collect(&:chop))  
  end
  
end

