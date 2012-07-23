class CreateSurveyItems < ActiveRecord::Migration
  def change
    create_table :survey_items do |t|
      t.integer :survey_id
      t.text    :content
      t.string  :type
      t.string  :title
    end
  end
end

