class Events::SurveyDestroyedEvent < Event

	def message
		I18n.t "surveys.common.on_destroyed_event", survey_name: eventable_name
	end
end
