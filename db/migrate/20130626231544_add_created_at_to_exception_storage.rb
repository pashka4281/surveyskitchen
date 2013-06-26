class AddCreatedAtToExceptionStorage < ActiveRecord::Migration
  def change
    add_column :exception_storages, :created_at, :datetime
  end
end
