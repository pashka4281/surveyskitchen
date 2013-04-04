class AddFieldsToShareEmail < ActiveRecord::Migration
  def change
    add_column :share_emails, :from_email, :string
    add_column :share_emails, :subject, :string
  end
end
