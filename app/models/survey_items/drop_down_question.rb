class SurveyItems::DropDownQuestion < SurveyItem
  attr_accessible :variants, :include_empty
  custom_field_accessor :include_empty
  custom_field_reader :variants
  
  def variants=(txt)
	  set_custom_field(:variants, txt.split("\n").collect(&:chop))  
  end

end
