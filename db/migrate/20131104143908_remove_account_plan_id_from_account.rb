class RemoveAccountPlanIdFromAccount < ActiveRecord::Migration
  def up
    remove_column :accounts, :account_plan_id
  end

  def down
    add_column :accounts, :account_plan_id, :integer
  end
end
