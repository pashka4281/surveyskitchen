class AddTypeToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :type, :string
    remove_column :surveys, :seed_item
  end
end
