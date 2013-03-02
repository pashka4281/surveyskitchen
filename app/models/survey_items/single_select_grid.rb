class SurveyItems::SingleSelectGrid < SurveyItem
  attr_accessible :rows, :columns
  custom_field_writer :include_txt_field
  
  #ROWS
  def rows=(txt)
	  set_custom_field(:rows, txt.split("\n").collect(&:strip))  
  end

  def rows
    (get_custom_field_value(:rows) || []).join("\n")
  end

  def rows_array
    get_custom_field_value(:rows)
  end

  #COLUMNS
  def columns=(txt)
    set_custom_field(:columns, txt.split("\n").collect(&:strip))  
  end

  def columns
    (get_custom_field_value(:columns) || []).join("\n")
  end

  def columns_array
  	get_custom_field_value(:columns)
  end
  
end

