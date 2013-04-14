class CreateQuizItems < ActiveRecord::Migration
  def change
    create_table :quiz_items do |t|
      t.integer :quiz_id
      t.string :type
      t.text :css_options
      t.string :size
      t.string :position
      t.text :content
    end
  end
end
