class AddShareableToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :shareable_id, :integer
    add_column :responses, :shareable_type, :string
  end
end
