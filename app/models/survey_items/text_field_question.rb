class SurveyItems::TextFieldQuestion < SurveyItem
	attr_accessible :title_placeholder, :appearance
	attr_accessor :title_placeholder
	
	custom_field_accessor :appearance

	after_initialize do
		self.appearance ||= 'txt_area' 
	end
end

