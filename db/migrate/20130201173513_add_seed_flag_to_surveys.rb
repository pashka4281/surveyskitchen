class AddSeedFlagToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :seed_item, :boolean, :default => false
  end
end
