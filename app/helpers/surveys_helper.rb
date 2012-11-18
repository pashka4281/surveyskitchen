module SurveysHelper

	def popup_link(name, desc)
		link_to name, '#', title: desc, rel: 'tooltip'
	end

	def survey_desc_link(desc)
		desc.blank? ? popup_link('more', 'There is no description for this survey') : popup_link('more', desc)
	end
end