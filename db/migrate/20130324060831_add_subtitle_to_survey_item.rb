class AddSubtitleToSurveyItem < ActiveRecord::Migration
  def change
    add_column :survey_items, :subtitle, :string
  end
end
