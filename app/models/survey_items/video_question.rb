class SurveyItems::VideoQuestion < SurveyItem
	attr_accessible :embed_url, :frame_size
	custom_field_accessor :frame_size
	custom_field_reader :youtube_id
	custom_field_reader :vimeo_id


	def embed_url=(val)
		set_custom_field(:youtube_id, $1) if val =~ /^http:\/\/www.youtube.com\/watch[?]v=(.+)$/
		set_custom_field(:vimeo_id, val.split('http://vimeo.com/')[1]) if val =~ /^http:\/\/vimeo.com\/\d{1,}$/

		set_custom_field(:embed_url, val)
	end

	def embed_url
		get_custom_field_value(:embed_url)
	end

	after_initialize do
		self.frame_size ||= '400x243' 
	end
end

