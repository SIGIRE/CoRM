class AddActiveColumnToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :active, :boolean
    Account.update_all active: true
  end
end
