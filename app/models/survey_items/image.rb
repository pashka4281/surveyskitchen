class SurveyItems::Image < SurveyItem
	attr_accessible :image
	custom_field_accessor :image

	mount_uploader :image, SurveyItemImageUploader

	def image_will_change!
    	content_will_change!
    	@image_changed = true
  	end

  	def image_changed?
    	@image_changed
  	end

  	def write_uploader(column, identifier)
    	set_custom_field(:image, identifier)
  	end

  	def read_uploader(column)
    	get_custom_field_value(:image)
  	end
end