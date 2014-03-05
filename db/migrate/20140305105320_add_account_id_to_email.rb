class AddAccountIdToEmail < ActiveRecord::Migration
  def change
    add_column :emails, :account_id, :integer
  end
end
