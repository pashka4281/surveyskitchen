class SurveyTheme < ActiveRecord::Base

	class << self
	    def custom_field_accessor(*args)
	      custom_field_reader(*args)
	      custom_field_writer(*args)
	    end
	    
	    def custom_field_reader(*args)
	      args.each do |arg|
	        define_method(arg) do
	          get_custom_field_value(arg)
	        end
	      end
	    end
	    
	    def custom_field_writer(*args)
	      args.each do |arg|
	        define_method(arg.to_s + '=') do |val|
	          set_custom_field(arg, val)
	        end
	      end
	    end
	end

	attr_accessible :account_id, :name, :survey_bg_color, :survey_title_font_b, :survey_title_font_i,
					:survey_title_font_u, :survey_title_txt_color, :survey_title_bg_color, :item_title_font_b,
					:item_title_font_i, :item_title_font_u, :item_title_txt_color, :item_bg_color, :item_inner_font_b,
					:item_inner_font_i, :item_inner_font_u, :item_inner_txt_color, :inner_grid_border_color,
					:highlighted_area_color, :survey_title_font_name, :item_title_font_name, :item_inner_font_name,
					:survey_title_size, :item_title_size, :item_inner_size

	default_value_for :content, {}
	serialize :content, Hash

	custom_field_accessor :survey_bg_color, :survey_title_font_b, :survey_title_font_i,
					:survey_title_font_u, :survey_title_txt_color, :survey_title_bg_color, :item_title_font_b,
					:item_title_font_i, :item_title_font_u, :item_title_txt_color, :item_bg_color, :item_inner_font_b,
					:item_inner_font_i, :item_inner_font_u, :item_inner_txt_color, :inner_grid_border_color,
					:highlighted_area_color, :survey_title_font_name, :item_title_font_name, :item_inner_font_name,
					:survey_title_size, :item_title_size, :item_inner_size

	def self.find_theme(current_account_id, theme_id)
		where(['(account_id IS NULL AND id=?) OR (account_id=? AND id=?)', theme_id, current_account_id, theme_id]).first
	end

	has_many :surveys, foreign_key: 'theme_id'
	scope :global, where(account_id: nil)

	#seed attributes with default values
	after_initialize do
		return true unless self.new_record?
		self.name = I18n.t "themes.form.default_survey_name"
		self.attributes = YAML.load_file(Rails.root.join('config', 'new_theme_defaults.yml'))['attributes']
	end

	def to_css
		<<-EOSTR
			.survey_theme_#{self.id} { background-color: ##{self.survey_bg_color} }
			.survey_theme_#{self.id} #title{ 
				background-color: #{self.survey_title_bg_color};
				color: #{self.survey_title_txt_color};
			}
			.survey_theme_#{self.id} .survey_item  strong.item-title{
				color: #{self.item_title_txt_color};
			}
			.survey_theme_#{self.id} .survey_item .item-content{ 
				color: #{self.item_inner_txt_color};

			}
			.survey_theme_#{self.id} .survey_item .item-content .highlighted{ 
				background-color: #{self.highlighted_area_color};
			}
			.survey_theme_#{self.id} .survey_item .grid-table td{ 
				border-bottom: 1px dotted #{self.inner_grid_border_color};
			}
			.survey_theme_#{self.id} .survey_item label:hover{ 
				background-color: #{self.highlighted_area_color};
			}
		EOSTR
	end



	
	def set_custom_field(field_name, value)
		self.content = self.content.merge({field_name => value})
	end

	def get_custom_field_value(field_name)
		p field_name
		p self.content
		self.content[field_name]
	end
end
