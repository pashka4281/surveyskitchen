class Events::SurveyCreatedEvent < Event

  def message
  	I18n.t "models.#{eventable_type.downcase}.on_created_event", survey_name: eventable.name
  end
end
