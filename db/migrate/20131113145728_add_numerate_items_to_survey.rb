class AddNumerateItemsToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :numerate_items, :boolean, default: true
  end
end
