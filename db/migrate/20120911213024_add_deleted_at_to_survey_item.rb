class AddDeletedAtToSurveyItem < ActiveRecord::Migration
  def change
    add_column :survey_items, :deleted_at, :datetime
  end
end
