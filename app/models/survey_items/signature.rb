class SurveyItems::Signature < SurveyItem
  attr_accessible :signature_data
  custom_field_accessor :signature_data
end

