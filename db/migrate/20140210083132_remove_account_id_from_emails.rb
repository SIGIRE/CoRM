class RemoveAccountIdFromEmails < ActiveRecord::Migration
  def up
    remove_column :emails, :account_id
  end

  def down
    add_column :emails, :account_id, :integer
  end
end
