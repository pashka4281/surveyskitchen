class AddPreviewFlagToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :preview_flag, :string, limit: 3
  end
end
