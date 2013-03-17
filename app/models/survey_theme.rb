class SurveyTheme < ActiveRecord::Base
  attr_accessible 	:bg_color, :account_id,	:name, :survey_bg_color, :survey_title_font_b, :survey_title_font_i,
					:survey_title_font_u, :survey_title_txt_color, :survey_title_bg_color, :item_title_font_b,
					:item_title_font_i, :item_title_font_u, :item_title_txt_color, :item_bg_color, :item_inner_font_b,
					:item_inner_font_i, :item_inner_font_u, :item_inner_txt_color, :inner_grid_border_color,
					:highlighted_area_color, :survey_title_font_name, :item_title_font_name, :item_inner_font_name,
					:survey_title_size, :item_title_size, :item_inner_size

	def self.find_theme(current_account_id, theme_id)
		where(['(account_id IS NULL AND id=?) OR (account_id=? AND id=?)', theme_id, current_account_id, theme_id]).first
	end

	scope :global, where(account_id: nil)

	def to_css
		<<-EOSTR
			.survey_theme_#{self.id} { background-color: ##{self.survey_bg_color} }
			.survey_theme_#{self.id} #title{ 
				background-color: ##{self.survey_title_bg_color};
				color: ##{self.survey_title_txt_color};
			}
			.survey_theme_#{self.id} .survey_item  strong.item-title{
				color: ##{self.item_title_txt_color};
			}
			.survey_theme_#{self.id} .survey_item .item-content{ 
				color: ##{self.item_inner_txt_color};

			}
			.survey_theme_#{self.id} .survey_item .item-content .highlighted{ 
				background-color: ##{self.highlighted_area_color};
			}
			.survey_theme_#{self.id} .survey_item .grid-table td{ 
				border-bottom: 1px dotted ##{self.inner_grid_border_color};
			}
			.survey_theme_#{self.id} .survey_item label:hover{ 
				background-color: ##{self.highlighted_area_color};
			}
		EOSTR
	end
end
