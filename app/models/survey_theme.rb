class SurveyTheme < ActiveRecord::Base
	ITEM_INNER_FONT_SIZES = %w(11px 13px 15px 17px 19px)
	ITEM_TITLE_FONT_SIZES = %w(13px 15px 17px 19px 21px)
	SURVEY_TITLE_FONT_SIZES = %w(19px 21px 24px 26px 28px)


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

	attr_protected :account_id, :account

	default_value_for :content, {}
	serialize :content, Hash

	custom_field_accessor :survey_bg_color, :survey_title_font_b, :survey_title_font_i,
					:survey_title_font_u, :survey_title_txt_color, :survey_title_bg_color, :item_title_font_b,
					:item_title_font_i, :item_title_font_u, :item_title_txt_color, :item_bg_color, :item_inner_font_b,
					:item_inner_font_i, :item_inner_font_u, :item_inner_txt_color, :inner_grid_border_color,
					:highlighted_area_color, :survey_title_font_name, :item_title_font_name, :item_inner_font_name
	
	custom_field_writer :item_inner_size, :item_title_size, :survey_title_size

	def self.find_theme(current_account_id, theme_id)
		where(['(account_id IS NULL AND id=?) OR (account_id=? AND id=?)', theme_id, current_account_id, theme_id]).first
	end

	has_many :surveys, foreign_key: 'theme_id'
	scope :global, where(account_id: nil)

	#seed attributes with default values
	after_initialize do
		return true unless self.new_record?
		{name: I18n.t("themes.form.default_survey_name")}.merge(
		self.attributes = YAML.load_file(Rails.root.join('config', 'defaults', 'new_theme.yml'))['attributes']).each do |key, val|
	      self.send(key).blank? ? send("#{key}=", val) : true
	    end
	end

	def item_inner_size
		ITEM_INNER_FONT_SIZES[get_custom_field_value(:item_inner_size).to_i + 1]
	end

	def item_title_size
		ITEM_TITLE_FONT_SIZES[get_custom_field_value(:item_title_size).to_i + 1]
	end

	def survey_title_size
		SURVEY_TITLE_FONT_SIZES[get_custom_field_value(:survey_title_size).to_i + 1]
	end

	def to_css
		<<-EOSTR
			.survey_theme_#{self.id}, .survey_theme_#{self.id} .survey_item { background-color: #{self.survey_bg_color} }
			.survey_theme_#{self.id} #title{ 
				background-color: #{self.survey_title_bg_color};
				color: #{self.survey_title_txt_color};
				font-size: #{survey_title_size};
			}
			.survey_theme_#{self.id} .survey_item  .item-title{
				color: #{self.item_title_txt_color};
				font-size: #{item_title_size};
			}
			.survey_theme_#{self.id} .survey_item .item-content{ 
				color: #{self.item_inner_txt_color};
				font-size: #{self.item_inner_size}
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
		self.content[field_name]
	end
end
