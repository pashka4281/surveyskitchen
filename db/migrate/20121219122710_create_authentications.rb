class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id
      t.string :access_token_secret
      t.string :access_token
      t.string :linked_name
      t.string :uid
      t.string :provider

      t.timestamps
    end
  end
end
