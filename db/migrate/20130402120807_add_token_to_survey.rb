class AddTokenToSurvey < ActiveRecord::Migration
  def change
    add_index :surveys, :token, :unique => true
  end
end
