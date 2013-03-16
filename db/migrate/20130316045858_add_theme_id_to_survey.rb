class AddThemeIdToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :theme_id, :integer
  end
end
