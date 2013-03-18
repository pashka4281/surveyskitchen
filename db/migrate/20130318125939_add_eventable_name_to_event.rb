class AddEventableNameToEvent < ActiveRecord::Migration
  def change
    add_column :events, :eventable_name, :string
  end
end
