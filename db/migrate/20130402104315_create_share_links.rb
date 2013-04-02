class CreateShareLinks < ActiveRecord::Migration
  def change
    create_table :share_links do |t|
      t.integer :survey_id
      t.string :custom_url
      t.boolean :active
    end
  end
end
