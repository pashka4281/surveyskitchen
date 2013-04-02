class AddViewedAtToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :viewed_at, :datetime
  end
end
