class RemoveFieldsFromTheme < ActiveRecord::Migration
  def up
  	remove_column :survey_themes, :survey_bg_color
	remove_column :survey_themes, :survey_title_font_b
	remove_column :survey_themes, :survey_title_font_i
	remove_column :survey_themes, :survey_title_font_u
	remove_column :survey_themes, :survey_title_txt_color
	remove_column :survey_themes, :survey_title_bg_color
	remove_column :survey_themes, :item_title_font_b
	remove_column :survey_themes, :item_title_font_i
	remove_column :survey_themes, :item_title_font_u
	remove_column :survey_themes, :item_title_txt_color
	remove_column :survey_themes, :item_bg_color
	remove_column :survey_themes, :item_inner_font_b
	remove_column :survey_themes, :item_inner_font_i
	remove_column :survey_themes, :item_inner_font_u
	remove_column :survey_themes, :item_inner_txt_color

	add_column :survey_themes, :content, :text
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
