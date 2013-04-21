class CreateBuyRequests < ActiveRecord::Migration
  def change
    create_table :buy_requests do |t|
      t.string :email
      t.string :name
      t.string :how_found
      t.text :text
      t.string :acc_type

      t.timestamps
    end
  end
end
