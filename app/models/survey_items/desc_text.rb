class SurveyItems::DescText < SurveyItem
  attr_accessible :text_content
	
  def text_content=(txt)
	  set_custom_field(:text_content, txt)  
  end
  
  def text_content
    get_custom_field_value(:text_content)
  end

end