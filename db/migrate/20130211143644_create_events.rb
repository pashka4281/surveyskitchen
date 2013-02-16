class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :eventable_type
      t.integer :eventable_id
      t.integer :account_id

      t.string :type

      t.datetime :created_at
    end
  end
end
