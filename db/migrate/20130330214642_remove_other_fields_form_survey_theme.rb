class RemoveOtherFieldsFormSurveyTheme < ActiveRecord::Migration
  def up
  	# remove_column :survey_themes, :survey_title_size
  	remove_column :survey_themes, :highlighted_area_color
  	remove_column :survey_themes, :survey_title_font_name
  	remove_column :survey_themes, :item_title_font_name
  	remove_column :survey_themes, :item_inner_font_name
  	remove_column :survey_themes, :item_title_size
  	remove_column :survey_themes, :item_inner_size
  	remove_column :survey_themes, :inner_grid_border_color
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
