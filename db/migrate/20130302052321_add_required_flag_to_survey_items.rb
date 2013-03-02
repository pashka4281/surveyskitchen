class AddRequiredFlagToSurveyItems < ActiveRecord::Migration
  def change
    add_column :survey_items, :required_field, :boolean, default: false
  end
end
