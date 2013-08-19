class AddRolesToUser < ActiveRecord::Migration
  def change
    add_column :users, :roles, :string
    User.all.each do |u|
    	u.roles = ['user', 'respondent']
    	u.save
    end
  end
end
