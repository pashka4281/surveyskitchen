class AddFieldsToThemes < ActiveRecord::Migration
  def change
  	add_column :survey_themes, :highlighted_area_color, :string, limit: 6
  	add_column :survey_themes, :survey_title_font_name, :string, limit: 20
  	add_column :survey_themes, :item_title_font_name, :string, limit: 20
  	add_column :survey_themes, :item_inner_font_name, :string, limit: 20

  	add_column :survey_themes, :survey_title_size, :integer, limit: 1
  	add_column :survey_themes, :item_title_size, :integer, limit: 1
  	add_column :survey_themes, :item_inner_size, :integer, limit: 1

  	add_column :survey_themes, :inner_grid_border_color, :string, limit: 6
  end
end
