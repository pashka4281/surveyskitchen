class AddFieldsToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :setup_finished, :boolean, default: false
  end
end
