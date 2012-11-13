class AddCreatedAtToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :created_at, :datetime
  end
end
