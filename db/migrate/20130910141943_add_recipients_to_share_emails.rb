class AddRecipientsToShareEmails < ActiveRecord::Migration
  def change
    add_column :share_emails, :recipients, :text
  end
end
