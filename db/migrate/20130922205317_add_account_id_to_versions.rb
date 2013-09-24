class AddAccountIdToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :account_id, :integer
  end
end
