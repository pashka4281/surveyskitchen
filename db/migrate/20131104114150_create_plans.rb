class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.float :price

      t.boolean :remove_survey_footer
      t.boolean :custom_logo
      t.integer :surveys_count_limit
      t.integer :responses_count_limit
    end
  end
end
