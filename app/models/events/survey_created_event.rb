class Events::SurveyCreatedEvent < Event

  def message
  	I18n.t "surveys.common.on_created_event", survey_name: eventable_name
  end
end
