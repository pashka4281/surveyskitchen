class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.integer :account_plan_id
      t.string :subdomain #if account plan allow it
      t.integer :owner_id

      t.datetime :created_at
    end
  end
end
