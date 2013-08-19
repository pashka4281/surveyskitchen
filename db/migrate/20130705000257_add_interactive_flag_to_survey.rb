class AddInteractiveFlagToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :interactive, :boolean, default: false
  end
end
