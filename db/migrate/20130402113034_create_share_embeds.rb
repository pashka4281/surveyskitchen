class CreateShareEmbeds < ActiveRecord::Migration
  def change
    create_table :share_embeds do |t|
      t.integer :survey_id
      t.boolean :active
    end
  end
end
