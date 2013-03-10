class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :account_id
      t.string :full_name
      t.text :note

      t.timestamps
    end
  end
end
