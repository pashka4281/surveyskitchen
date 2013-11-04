class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :plan_id
      t.integer :account_id

      t.datetime :last_payed_at
      t.datetime :created_at
    end
  end
end
