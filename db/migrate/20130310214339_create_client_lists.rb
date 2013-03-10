class CreateClientLists < ActiveRecord::Migration
  def change
    create_table :client_lists do |t|
      t.string :name
      t.integer :account_id

      t.timestamps
    end
  end
end
