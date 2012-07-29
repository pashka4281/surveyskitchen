class AddFieldsToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :setup_finished, :boolean, default: false
    add_column :surveys, :category_id, :integer
  end
end
