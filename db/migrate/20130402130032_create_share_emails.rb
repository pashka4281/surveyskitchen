class CreateShareEmails < ActiveRecord::Migration
  def change
    create_table :share_emails do |t|
      t.integer :survey_id
      t.text :text
      t.boolean :active
    end
  end
end
