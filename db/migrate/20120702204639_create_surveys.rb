class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer   :account_id
      t.integer   :user_id
      t.string    :name
      t.text      :description
      t.string    :items_positions

      t.datetime  :updated_at
    end
  end
end

