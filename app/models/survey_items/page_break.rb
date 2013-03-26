class SurveyItems::PageBreak < SurveyItem
	attr_accessible :page_header, :page_description
	custom_field_accessor :page_header
	custom_field_accessor :page_description
end

